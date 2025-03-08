---
title: "Refinement in Rust: optimization, arithmetic, and stateful refinement"
date: 2025-03-08
draft: false
tags:
  - rust
  - refined
summary: v0.0.4 of refined has been released
---

<!-- dprint-ignore-start -->
{{<tagline>}}
v0.0.4 of <a href="https://docs.rs/refined/latest/refined/">refined</a>, my library providing support for refinement types in Rust, has been released
{{</tagline>}}
<!-- dprint-ignore-end-->

In my [last post](https://jordankaye.dev/posts/refined/), I announced the initial release of
`refined`, a library providing support for
[refinement types](https://en.wikipedia.org/wiki/Refinement_type) in Rust. Since the release, a
number of interesting ideas have been contributed by the community. `v0.0.4` of the library has now
been released, including support for three important new features along with a number of minor
improvements.

The major features that this post will focus on are:

- `optimized`: a feature flag that allows runtime bounds checking to be elided via use of an
  `unsafe` optimization
- `arithmetic`: a feature flag that allows relevant specializations of the
  [Refinement](https://docs.rs/refined/latest/refined/struct.Refinement.html) struct to be used
  directly with the arithmetic traits from [std::ops](https://doc.rust-lang.org/std/ops/index.html)
- Stateful refinement: the ability for users to define
  [StatefulPredicate](https://docs.rs/refined/latest/refined/trait.StatefulPredicate.html)
  implementations, allowing for more efficient refinement in cases where applying predicate logic is
  both pure and computationally intensive

# Optimized

Shortly after the initial release of `refined`,
[an issue was raised](https://github.com/jkaye2012/refined/issues/9) asking about the possibility of
eliding bounds checks through the use of
[hint::assert_unchecked](https://doc.rust-lang.org/std/hint/fn.assert_unchecked.html). Given the
design of `refined` and the guarantees that it provides, this seemed like an easy win for
performance for those who are willing to opt in to `unsafe` behavior.

When you turn on the `optimized` feature, you should notice no difference other than that the
generated code is faster than it was before. To better understand the impact of this change, we can
look at the generated assembly from a
[small example program](https://github.com/jkaye2012/refined/blob/main/examples/optimized/src/main.rs)
using [cargo-show-asm](https://github.com/pacak/cargo-show-asm/tree/master).

First, the code that we'll be inspecting:

```rust
use refined::{boundable::unsigned::LessThan, prelude::*};

type Size = Refinement<usize, LessThan<12>>;

#[no_mangle]
fn month_name(s: &Size) -> &'static str {
    const MONTHS: [&str; 12] = [
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December",
    ];
    MONTHS[**s]
}

fn main() {
    let raw_index = std::env::args()
        .next_back()
        .unwrap()
        .parse::<usize>()
        .unwrap();
    let index = Size::refine(raw_index).unwrap();

    println!("{}", month_name(&index));
}
```

In "standard" Rust (using a `u8` as the argument to `month_name` rather than the `Size` refinement),
a bounds check on the array access is required. Looking at the generated assembly without
`optimized`, we can see that `refined` shares this behavior:

```bash
$ cargo asm -p refined-optimized --bin refined-optimized month_name
   Finished `release` profile [optimized] target(s) in 0.01s
```

```asm
.section .text.month_name,"ax",@progbits
        .globl  month_name
        .p2align        4
.type   month_name,@function
month_name:
        .cfi_startproc
        mov rdi, qword ptr [rdi]
        cmp rdi, 11
        ja .LBB11_2
        shl rdi, 4
        lea rcx, [rip + .L__unnamed_9]
        mov rax, qword ptr [rdi + rcx]
        mov rdx, qword ptr [rdi + rcx + 8]
        ret
.LBB11_2:
        push rax
        .cfi_def_cfa_offset 16
        lea rdx, [rip + .L__unnamed_10]
        mov esi, 12
        call qword ptr [rip + core::panicking::panic_bounds_check@GOTPCREL]
```

For those unfamiliar with assembly, the bounds check is right around the start of the function; if
the input argument is greater than 11, we drop into a panic handler:

```asm
...
        mov rdi, qword ptr [rdi]
        cmp rdi, 11
        ja .LBB11_2
...
.LBB11_2:
        push rax
        .cfi_def_cfa_offset 16
        lea rdx, [rip + .L__unnamed_10]
        mov esi, 12
        call qword ptr [rip + core::panicking::panic_bounds_check@GOTPCREL]
```

Taking a look at enabling `optimized`, we can see that this bounds check is no longer generated:

```bash
$ cargo asm -p refined-optimized --bin refined-optimized month_name --features optimized
    Finished `release` profile [optimized] target(s) in 0.01s
```

```asm
.section .text.month_name,"ax",@progbits
        .globl  month_name
        .p2align        4
.type   month_name,@function
month_name:
        .cfi_startproc
        mov rcx, qword ptr [rdi]
        shl rcx, 4
        lea rdx, [rip + .L__unnamed_9]
        mov rax, qword ptr [rcx + rdx]
        mov rdx, qword ptr [rcx + rdx + 8]
        ret
```

Because `refined` knows that the predicate must always hold, the bounds check is entirely spurious.
Critically, this optimization _removes a branch point_ from the generated code, which could
significantly improve performance if the code path is used infrequently enough that good branch
prediction cannot come into play. In any case, removing checks that aren't required is a Good Thing
for performance; as such, once the feature has had time for some testing in the wild to prove its
soundness, it will likely become a default feature of `refined`.

# Arithmetic

Many of the [provided predicates](https://docs.rs/refined/latest/refined/trait.Predicate.html) in
`refined` are numeric. A particularly common case is the desire to constrain numeric values to a
subset of the possible values inhabited by the type. These bounding constraints create integral
ranges, allowing for implementation of
[interval arithmetic](https://en.wikipedia.org/wiki/Interval_arithmetic) for such types in some
situations. This in turn allows `refined` to provide "refined arithmetic" with proven bounds that
are verified at compile time rather than at run time when the `arithmetic` feature is enabled.

Similar to [implication](https://docs.rs/refined/latest/refined/#implication), this feature requires
the use of `generic_const_exprs`, so its stability cannot be guaranteed.

Here's a straightforward example:

```rust
#![allow(incomplete_features)]
#![feature(generic_const_exprs)]

use refined::{prelude::*, boundable::unsigned::ClosedInterval};

type Larger = Refinement<u16, ClosedInterval<100, 1000>>;
type Smaller = Refinement<u16, ClosedInterval<50, 500>>;

fn main() {
  let larger = Larger::refine(500).unwrap();
  let smaller = Smaller::refine(100).unwrap();
  // Type annotation not required; provided for clarity
  let result: Refinement<u16, ClosedInterval<0, 20>> = larger / smaller;
  assert_eq!(*result, 5);
}
```

I've attempted to implement all combinations of interval arithmetic that I believe are sound in all
situations, but if you find an arithmetic operation that you think should be supported but is not,
please [let me know](https://github.com/jkaye2012/refined/issues/new) so that we can get it added to
the library.

# Stateful refinement

Stateful refinement allows for the use of
[predicates that contain state](https://docs.rs/refined/latest/refined/trait.StatefulPredicate.html).
This is useful in situations where the "materialization" of a predicate is costly or prone to
potential failure due to e.g. a dependency on an external resource.

A motivating example is the
[Regex predicate](https://docs.rs/refined/latest/refined/string/struct.Regex.html). Regular
expressions are often costly to compile; if you find yourself in a situation where you need to
refine many different values using the same regular expression, your program would previously spend
the majority of its time in refinement re-compiling the same regex over and over for each value's
refinement. Stateful refinement solves this problem by allowing us to cache the compiled predicate
for re-use:

```rust
use refined::{prelude::*, string::Regex};

type_string!(FiveLowercaseLetters, "^[a-z]{5}$");
type FiveLower = Refinement<String, Regex<FiveLowercaseLetters>>;

fn main() {
    let predicate = Regex::<FiveLowercaseLetters>::default(); // Compiles the regex

    // Same regex re-used for each refinement
    let good1 = FiveLower::refine_with_state(&predicate, "abcde".to_string());
    assert!(good1.is_ok());
    let good2 = FiveLower::refine_with_state(&predicate, "zzzzz".to_string());
    assert!(good2.is_ok());
    let bad = FiveLower::refine_with_state(&predicate, "AAAAA".to_string());
    assert!(bad.is_err());
}
```

Note that the regular expression functionality is kept behind the `regex` feature flag to prevent an
unnecessary dependency for those who don't need it, but this does not affect the core stateful
functionality (which is always available).

# Wrapping up

v0.0.4 included a few other small changes, including a
[contribution guide](https://github.com/jkaye2012/refined/blob/main/CONTRIBUTING.md) for new
contributors to the project. A complete list of all changes can be found in
[the changelog](https://github.com/jkaye2012/refined/blob/main/CHANGELOG.md#004---2025-03-02).

The library is quickly reaching a stable state where I'll be releasing a major version to indicate
ongoing, stable support for the existing functionality as I continue to build it out over time.
Please reach out or drop me an issue if you have any ideas for future improvements or additions!
