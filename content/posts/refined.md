---
title: "Refined: simple refinement types for Rust"
date: 2025-02-07
draft: false
tags:
  - rust
summary: An alpha library for refinement types with rich support for serde
---

<!-- dprint-ignore-start -->
{{<tagline>}}
An alpha library for refinement types with rich support for <a href="https://serde.rs/">serde</a>
{{</tagline>}}
<!-- dprint-ignore-end-->

In my off time for the past few month or two I've been working on
[refined](https://crates.io/crates/refined), a library to provide better support for
[refinement types](https://en.wikipedia.org/wiki/Refinement_type) in Rust. The basic functionality
is now where I want it to be, so I've released an initial alpha version so that others can play with
it if they'd find it useful. The [crate documentation](https://docs.rs/refined/latest/refined/) is
good enough to get up and running (I think,
[let me know](https://github.com/jkaye2012/refined/issues/new?template=Blank+issue) if you
disagree!), but I also wanted to provide more background on why I've been working on this the types
of problems that the library solves.

## What is refinement?

To understand `refined`, it's necessary to first understand the concept of refinement in general. An
excerpt from the definition linked above:

> A refinement type is a type endowed with a predicate which is assumed to hold for any element of
> the refined type. Refinement types can express preconditions when used as function arguments or
> postconditions when used as return types.

I like to think of refinement as narrowing the possible set of values that can be associated with a
type. The easiest examples to consider are strings and numerics. These are ubiquitous types that
have a huge range of possible values, which is part of what makes them so useful in general. In more
specific contexts, however, it's often only correct for certain values to take on a very small
subset of those possible values. This is where refinement becomes useful: it allows us to model
those domain invariants within the type system, improving documentation and maintainability while
simultaneously preventing bugs.

## A contrived example

As a contrived example, we could conceive of a situation wherein we need to score a test, but where
the problem domain dictates that test scores must lie between 1 and 100 inclusive. In Rust, the best
that we can do to model this value is to reach for `u8`. Using `refined`, we can lift the domain
invariant into the type system by defining a `Refinement` over `u8` like so:

```rust
use refined::{Refinement, RefinementError, boundable::unsigned::ClosedInterval};

type TestScore = Refinement<u8, ClosedInterval<1, 100>>;
```

With this definition in place, `refined` will now guarantee that any value of type `TestScore` is a
`u8` between 1 and 100. If you have a `TestScore`, you can be sure that it is a proper value as
dictated by the domain.

[Creating values](https://docs.rs/refined/latest/refined/struct.Refinement.html#method.refine) is
easy, though there is a small runtime cost to ensure the predicate:

```rust
use refined::{Refinement, RefinementError, boundable::unsigned::ClosedInterval};

type TestScore = Refinement<u8, ClosedInterval<1, 100>>;

fn main() {
  let good_score = 99u8;
  let buggy_score = 200u8;

  TestScore::refine(good_score).unwrap(); // TestScore
  TestScore::refine(buggy_score).unwrap(); // panic!
}
```

Using values of a refined type is also easy via the
[Deref impl for Refinement](https://docs.rs/refined/latest/refined/struct.Refinement.html#impl-Deref-for-Refinement%3CT,+P%3E):

```rust
use refined::{Refinement, RefinementError, boundable::unsigned::ClosedInterval};

type TestScore = Refinement<u8, ClosedInterval<1, 100>>;

// This function is from a foreign library that doesn't know about our TestScore type
// fn classify_test_score(score: u8) -> ScoreClassification;

fn main() {
  let user_input = 99u8; // In the real world, this would come from an external source that we don't have control over

  let score = TestScore::refine(good_score).expect("invalid score provided");
  let classification = classify_test_score(*score);
}
```

There are a number of other
[convenience functions](https://docs.rs/refined/latest/refined/struct.Refinement.html#implementations)
implemented for `Refinement` to make it easier to work with as well, but we don't need to go through
all of them here.

Of course, I should mention that the _most_ correct way to model this test score would be as an enum
with 100 variants, but I'm going to make the assumption that most of us would avoid that route.
There are, however some
[interesting thoughts](https://lexi-lambda.github.io/blog/2020/11/01/names-are-not-type-safety/) on
when it might be worth using "better" type safety than a library like `refined` is able to provide.

## Parse, don't validate

One of my
[all-time favorite blog posts](https://lexi-lambda.github.io/blog/2019/11/05/parse-don-t-validate/)
focuses on the difference between _parsing_ and _validation_:

> Consider: what is a parser? Really, a parser is just a function that consumes less-structured
> input and produces more-structured output. By its very nature, a parser is a partial function —
> some values in the domain do not correspond to any value in the range — so all parsers must have
> some notion of failure.

So, a parser might look something like this:

```rust
fn parse(input: &str) -> Result<Output, SomeError>
```

while a validator might look more like:

```rust
fn validate(input: Thing) -> bool
```

The key concept here (and what `refined` provides) is that by having an `Output`, we **know** that
our invariants must be met. In the latter case, when we have a `Thing` we might _think_ that our
invariants have been validated, _but there's no guarantee that it has_! Surely when the system is
first implemented the validations might've been correctly applied, but as systems evolve over time,
mistakes are possible, and something like forgetting a validation is an easy mistake to make.

My driving motivation behind `refined` was to create something that integrates seamlessly with
`serde` in much the same way that the excellent [validator](https://crates.io/crates/validator)
crate does for validation.

With the `serde` feature enabled (it's on by default), we get the essence of "parse, don't validate"
for free when using refinement types:

```rust
use refined::{Refinement, RefinementError, boolean::And, boundable::unsigned::{ClosedInterval, NonZero}, string::Trimmed};
use serde::{Serialize, Deserialize};

type StudentName = Refinement<String, And<Trimmed, NonZero>>; // Name can't start or end with whitespace, and can't be the empty string
type TestScore = Refinement<u8, ClosedInterval<1, 100>>;

#[derive(Debug, Deserialize, Serialize)]
struct TestResult {
  name: StudentName,
  score: TestScore,
}
```

For me, this is power, and is a great demonstration of why I'm a proponent of rich type systems.
Domain invariants are now verified for us by the compiler, and a library ensures that they're
maintained. Data can be modeled directly, and we can be sure that our values are always meeting the
expectations that we have of them.

## Wrapping up

This was really just a quick tour of my motivation for creating `refined`. If you're interested in
learning more (in particular, I think the unstable
[implication feature](https://docs.rs/refined/latest/refined/implication/trait.Implies.html) is
pretty cool!), check out the
[crate documentation](https://docs.rs/refined/latest/refined/index.html). If you find any issues, or
have any ideas for how the library could be improved, please
[open an issue](https://github.com/jkaye2012/refined/issues/new?template=Blank+issue) so that we can
get it sorted out!
