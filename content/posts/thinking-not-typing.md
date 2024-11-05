---
title: Software engineering is about thinking, not typing
date: 2023-10-11
draft: false
tags:
  - leadership
  - software
summary: Weeks of coding can save you hours of planning
---

{{<tagline>}}
Weeks of coding can save you hours of planning
{{</tagline>}}

Software engineering best practices emphasize and value the importance of iterative work. They encourage working in ways
that give us opportunities to make decisions frequently and adapt to changing circumstances. These principles are nearly
ubiquitous and seem necessary for successful engineering efforts at large scales, but the concept is sometimes taken to
an extreme that can be unhelpful. While it's almost always a good idea to maintain the ability to iterate quickly and
[change our minds]({{< ref "flexible-systems.md" >}}), that doesn't mean that one shouldn't take time to think before
they begin to act.

When confronted with a problem, rather than jumping directly to thoughts of "how can I fix this with code", it's often
more effective to first carefully consider the universe of potential solutions. By the time code begins flowing into an
editor, there should be a good idea of an overall plan; what is it that is actually being built towards? What concepts
are being programming against? Should new foundational concepts be introduced to this region of code to facilitate the
implementation? Which preexisting concepts will have to be modified? Without answers to these questions and others like
it, it's very easy to end up just "coding by accident", wading through unforeseen problem after problem until eventually
solution emerges that seems to work well enough, but most likely isn't implemented as well as it could've been.

The more inexperienced an engineer is, the stranger this may sound to them. After all, their job is to write code, so how
can _thinking_ be more valuable than actually _doing_? One of the best explanations can be found in a pithy quote for
which I've been unable to find a source:

> Weeks of coding can save you hours of planning.

The point is that it doesn't really matter how quickly someone is able to write code if they're writing code for the
wrong reasons. One of the worst possible outcomes for a software engineer is to spend days or weeks working on a solution only
to learn that they've been building the wrong thing the entire time. Of course, this usually isn't solely the fault of the
engineer alone (and agile methodologies should help to identify problems like this earlier in the process), but the fact
remains that there is almost always more than each of us can be doing as individuals to
make sure that we're solving the right problems in the best way available to us.

The idea can also be difficult to implement in practice for many reasons:

* If the problem is completely novel, attempting to write some code can be a good way to better understand the problem
  space
* Writing code is, for many engineers, a lot more fun and approachable than sitting around and thinking about problems
  in the abstract
* There is a lot of uncertainty involved in abstract thought of this nature; how does one know that they're thinking
  about the right things?
* Spending too much time thinking and planning ahead of time can be just as bad as not spending enough; how does one
  know when to stop thinking and start doing?

One approach that I like to use personally is to identify what I think of as the _core concepts_ that underlie the
problem at hand. Most problems can be decomposed into constituent ideas that are more or less independent from one
another. This should sound familiar to most engineers, as this is very similar to the important software design concepts
of [coupling](https://en.wikipedia.org/wiki/Coupling_(computer_programming)) and
[cohesion](https://en.wikipedia.org/wiki/Cohesion_(computer_science)). While decoupling is a mostly technical process,
identification of these core concepts is a theoretical one. The goal is to search for the ideas that exist within the
problem itself so that we can build our technical boundaries along the conceptual boundaries that exist within the core
of the problem at hand. More specifically, the best outcome is when the identified concepts are loosely coupled, yet
highly cohesive.

As a practical example, consider a command-line application that can generate [devcontainers](https://containers.dev/)
specifications for users by combining tools together declaratively rather than forcing them to write the configuration
files by hand. Writing devcontainers specifications and their corresponding Dockerfiles can be a bit a pain because of
the unexpected interactions between the running container and the user's development environment; for example, the
container's timezone should be synchronized with that of the user, the UID of the user in the container should match the
UID of the external user, and SSH passthrough authentication should "just work", but these are not features that
devcontainers provides for the user. The idea is that the tool should be able to take a simplified configuration file
that allows the user to say: "I want to use Rust, Git, Vim, and the [Oil shell](https://www.oilshell.org/)", click a
button, and get a fully-instrumented and repeatable development environment.

Consider challenging yourself to put some thought into this problem: what are some core concepts that you can identify
that might make sense to construct this tool around? Once you're done, expand the section below to see what I
identified. Are your concepts different from mine? Perhaps I've missed something!

{{< rawhtml >}}
<details>
	<summary>Core Concepts</summary>

<ul>
<li> Repository: the highest-level construct supported by the tooling; usually a versioned-controlled source repository,
  can hold one or more Projects
<li> Project: a desired development experience associated with a subset of its Repository. Has a single Configuration at
  any point in time
<li> Configuration: a point-in-time instance of a Project. Each Configuration generates a single unique Devcontainers spec and associated Docker image
<li> Host: the host environment from which the tool is being executed, used as a source for information that must be
  injected into a Configuration
<li> Environment: an actively running instance of a Configuration, usually managed by the Editor
<li> Editor: the source code editor that will be used to run the Devcontainer
<li> Tool: an individual piece of functionality that can be composed with other Tools to provide a development environment
</ul>
</details>
{{< /rawhtml >}}

While this is a simplified list, it should be clear that these are concepts associated with the problem itself rather than individual
technical decisions. Nothing in the list above prescribes _how_ the tool will deal with any of these concepts, only that
they exist and should be considered during development. That's part of why it's important to think before writing code:
we want to avoid [anchoring](https://en.wikipedia.org/wiki/Anchoring_effect) our thought process to what we have done in
the past.

More technical questions then arise from consideration of these concepts:

* Should Repositories be restricted to containing only a single project? How might that effect users of
  [monorepos](https://monorepo.tools/)?
* It's possible that running Environments will drift from the current Configuration (if an environment is left running
  after the configuration is modified); does this matter?
* The Configuration is likely to have to understand the different Editors supported by the tool; how should that be
  accomplished?
* How should the tool deal with different Host platforms?
* How can Tools be composed with one another when generating a final specification?

And from here, the ability to begin iterative development as usual against these concept emerges.

It's worth mentioning explicitly that I'm not advocating for design by committee, waterfall development, architecture
astronauts, or any of the other anti-patterns that frustrate engineers who really just want to get things done. Thinking
before typing is an _individual_ activity, something that every engineer can ensure that they're doing to potentially
improve the final results of the work that they create. Writing some code to understand the problem space may be a great
idea, for example - but if you're going to get started right away, you may do well to remind yourself to consider
throwing that experimental code
away and _think about the problem_ before you stray too deeply down any single path. Especially if problem discovery is
the purpose of a prototype, the possibility of falling into the [XY problem](https://xyproblem.info) is ever-present.

Another aspect of this idea that I find very useful is that it can be used to help explain some of the difficulties
involved in software engineering to less technical individuals, especially stakeholders and executives. Measurement of
engineering teams, for example, is a hot topic lately off the tails of the success of [DORA
metrics](https://cloud.google.com/blog/products/devops-sre/using-the-four-keys-to-measure-your-devops-performance), the
relatively recent release of the [SPACE framework](https://queue.acm.org/detail.cfm?id=3454124), and then the
unfortunate [McKinsey
system](https://www.mckinsey.com/industries/technology-media-and-telecommunications/our-insights/yes-you-can-measure-software-developer-productivity)
that has [drawn some misgivings](https://newsletter.pragmaticengineer.com/p/measuring-developer-productivity) from
experienced engineering leaders.

SPACE in particular does a good job of acknowledging that there is much more to
engineering than the code that an engineer produces. While it can be difficult for many to understand the details of the
development process, it's part of the job of an engineering leader to advocate for their teams and help stakeholders
understand where time is being spent and why things take as long as they do. Focusing on the importance of planning,
design, and thinking can help leaders explain these concepts in terms that anyone should be able to understand
regardless of their technical acumen.

Because most software engineering is an inherently creative endeavor, it's difficult to distill the daily activities of
an engineer down to the type of cleanly measurable metrics that many executives (particularly those with less
familiarity with the engineering process) would like to see. The [glue engineer](https://noidea.dog/glue) for example
may be critical to the overall function of their team, but any attempts to measure that individual's impact by focusing
on their issue completion or commit history is bound to fail in the general case. This is why experienced engineering
leaders try to focus more on measuring [outcomes over outputs](https://martinfowler.com/bliki/OutcomeOverOutput.html).

The most interesting aspect of this difficulty of measurement is that the difficulty tends to grow with the seniority of
the engineer in question. The more experienced and impactful someone is, the more likely it is that they're impact is
coming from intangibles like their ability to influence others. While this is a generalization, there's a good reason
that many of the [open source engineering progression frameworks](https://progression.fyi/) focus on influence rather
than output at their highest engineering levels. These are just a few of the tools that can be used to help socialize
this type of understanding of the SDLC throughout an organization.

So, every now and then considering reminding your engineers: software engineering is about thinking, not typing.
