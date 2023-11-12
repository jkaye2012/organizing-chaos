---
title: A gentle introduction to C++ template metaprogramming
date: 2023-11-05
draft: true
tags:
  - c++
  - metaprogramming
  - tutorial
---

{{<tagline>}}
C++ templates are a powerful tool that should be better understood
{{</tagline>}}

[Templates](https://en.cppreference.com/w/cpp/language/templates) are one of the most powerful features of modern C++.
In exchange for their power, the template system is quite complex. So complex, in fact, that many engineers shy away
from writing templates whenever possible. While it's true that templates aren't a silver bullet that should be used to
solve every problem, I feel that there is a lot being left on the table by the barrier of entry to using templates in
C++. What's more, gaining an understanding of templates in general can also allow one to begin to think beyond the more
"basic" use cases for templates and into the realm of full-fledged template metaprogramming.

My goal in this post is not to be technically perfect or to cover ever corner of the template specification. Like most
C++ features, the spec is large enough and has enough edge cases that it would be impossible to cover everything in a
single post like this. Instead, my goal is provide a basic level of intuition for templates that I hope will help newer
C++ developers as a starting point for a deeper understanding of these concepts. Almost all of the information that I'm
sharing here is available in much more depth (albeit correspondingly more complex) in the reference documentation that
will be linked within each section.

As a companion to this post, I've created a [small GitHub repo](https://github.com/jkaye2012/fixed-size-hash/tree/main)
that contains a complete listing of the code that I'll be showing. All examples require C++20. If you find any errors or
think you can otherwise improve the examples, pull requests are more than welcome! I will update the post as changes are
made to the repository.

# What is a template?

As their name suggests, templates are a way for a programmer to direct the compiler to generate different code depending
on parameters provided by users of the code. Often, this takes the shape of data structures and functions that are able
to operate over disparate types. The `std::vector` class is a canonical example, allowing dynamic storage of an
arbitrary number of arbitrarily typed values:

```c++
template<typename T>
class vector;
```

This can be read as "the class `vector` is a template that accepts a single template type parameter named `T`".

{{<aside>}}
The real std::vector has another template type parameter that allows customization of the vector's allocator. Many of
the examples in the post are simplified for ease of understanding - please see the reference documentation for more
details.
{{</aside>}}

All templates have _parameters_, and those parameters are our levers to statically control the code that will be
generated for us. All of this happens at compile time, meaning that the compiler is able to inspect the results of each
template and ensure that the generated code is valid.

# Quick detour: declarations and definitions

Templates have two unique "phases" to consider: _specialization_ and _instantiation_. To understand these, it's
important to first understand how entities are declared and defined in C++ in general.

C++ separates the idea of [declaration](https://en.cppreference.com/w/cpp/language/declarations) from that of
[definition](https://en.cppreference.com/w/cpp/language/definition). A declaration introduces a name into a program
without providing a corresponding implementation for that name. Implementations are provided by definitions. The
simplest example are standard header and source files:

```c++ {title="hello.hpp"}
// hello.hpp
#pragma once
#include <string_view>

void say_hello(std::string_view name);
```

In `hello.hpp`, we _declare_ that a function named `say_hello` shall exist that accepts a `std::string_view` as its only
parameter. The function has not yet been defined, so we have no implementation details, but other headers are able to
include `hello.hpp` and call `say_hello`, relying upon the linker to "bind" the declaration to its corresponding
definition later on.

```c++ {title="hello.cpp"}
// hello.cpp
#include "hello.hpp"

#include <iostream>

void say_hello(std::string_view name) {
    std::cout << "Hello, " << name << "!" << std::endl;
}
```

In `hello.cpp`, we _define_ the `say_hello` function that we declared previously. This is the definition that the linker
will use for all callsites in the program that invoked the function. If the One Definition Rule has confused you at any
point before, hopefully it now makes sense: the linker needs a unique definition to link for each declaration that it
encounters. If more than one definition were provided for a unique name, there would be no way for the linker to know
which should be used at each callsite.

# Specialization and instantiation

# Template types

When we talk about templates in C++, one of the first points of confusion is that there are actually _many different
types_ of templates. When we're thinking about how to solve a problem using templates (or trying to debug an issue being
caused by them!), it's important to understand which type of template is in use. As of this writing, there are 5
different "types" of templates:

* Class templates
* Function templates
* Alias templates
* Variable templates
* Concepts

All template types support the same three different types of parameters:

* Type parameters
* Nontype parameters
* Template parameters

## Class templates

## Function templates

## Alias templates

## Variable templates

## Concepts

# Template parameters

# Variadic templates

https://en.cppreference.com/w/cpp/language/parameter_pack

# Template recursion