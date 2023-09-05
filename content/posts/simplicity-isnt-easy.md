---
title: Simplicity isn't easy
date: 2023-09-05
draft: false
tags:
  - leadership
  - software
---

{{<tagline>}}
Simple is the opposite of complex, easy is the opposite of difficult
{{</tagline>}}

I spend a lot of time thinking about complexity. I read an essay recently about [complexity and cognitive load](https://rpeszek.github.io/posts/2022-08-30-code-cognitiveload.html) in software engineering that touches on a specific point that I think is important to the professional development of software: the difference between _simplicity_ and _ease_.

Like many engineers, I don't enjoy working within overly complex systems. The cognitive load required to get anything
done within such code bases is far greater than it should be. Even once you're able to accomplish something in such a system, it can leave you
with a sort of bad taste in your mouth - why was that _so hard_? When writing code on my own, I do my best to keep
things simple for myself, but "just keep it simple" unfortunately doesn't seem to be a philosophy that can be
effectively applied to teams and departments of engineers.

While most engineers would like to keep things simple,  decreased internal complexity can unintentionally lead to
increased external complexity, pushing what would have been the engineer's problems onto their users (or other software
engineers within the company) instead. This in turn has led to assertions like [no one actually wants
simplicity](https://lukeplant.me.uk/blog/posts/no-one-actually-wants-simplicity/). While I don't agree with most of
what's laid forth there, it's true that even when trying to do the
right thing, we can ultimately end up with many of the same issues that we would've had in the first place, just shuffled
slightly out of our sight and into another aspect of the [system](https://jordankaye.dev/lexicon/#system).

With all of this in mind, it becomes slightly easier to understand one of the most common dilemmas in professional
software development: engineers feel they don't have enough time to "do things right". This situation manifests in all sorts of
different ways, one such being that external pressures force them to make decisions that they may not have made
otherwise, potentially causing complexity that was not at all necessary. If it's generally accepted that unnecessary
complexity isn't a good thing for technical systems, why do so many engineering organizations seem to get caught in this trap?

A framework that can help us understand this more meaningfully is the paradoxical relationship between simplicity and ease. The words simple and easy are often used interchangeably, but I think it more prudent to ascribe more specific meanings:

* Simple is the opposite of complex; a property of a solution, system, component, etc. A simple system can be _understood_ by an individual without onerous effort and with a high likelihood of that understanding being correct
* Easy is the opposite of difficult; a property of a task or undertaking. An easy task can be _accomplished_ by an individual without onerous effort and with a high likelihood of the outcome being correct

Communicating in this way makes things clear. When someone proposes a solution because it would be easy to implement,
that sounds great - but it may be worth questioning how the solution would impact the overall simplicity of the system.
Is the easy way out a band-aid, or does it address the source of the problem to be solved at the root? Are we running a
risk of letting days of programming save us from hours of thinking?

These definitions are important because they allow complexity and difficulty to be connected to other aspects of [SDLC](https://en.wikipedia.org/wiki/Systems_development_life_cycle) processes. Complexity is an aspect of systems, while ease is an aspect of the work that has to be done. The _difficulty_ of a task is not always connected directly to the _simplicity_ of that task, and in fact the two are often inversely correlated. This situation is difficult to grapple with precisely because because _simplicity is often very difficult to achieve_. The type of simplicity that makes solutions easy to understand, use, and maintain requires a level of careful thought, foresight, and effort that can be difficult to find the time for. When an easy to implement solution is readily available, why take the time to search for something simple?

Therein lies the conflict. Avoiding complexity is not an easy thing to do. It's time consuming and difficult. Perhaps even worse, spending time on it doesn't not guarantee success. At times, the answer will be that attempting to reduce complexity doesn't make sense, even if there are well-understood ways to do so. When time to market is paramount or things are on fire, an easy solution that carries extra complexity may well be the best path forward. When time isn't of the essence, on the other hand, [searching for a simpler solution may well be worthwhile](https://jordankaye.dev/posts/go-slow-move-fast/).

Ultimately, the most important reason to think about the trade-off between simplicity and ease is to help yourself and your team consider the higher-order effects of the decisions that you're making. If we always choose the easiest solution that comes to mind, where are we likely to end up in the future? If we always search for the simplest possible solution, will we ever be able to get anything done? As ever in software engineer, there are no hard and fast answers to these questions - but we can provide ourselves with another tool to help answer the difficult questions.