---
title: Flexible systems
date: 2023-06-21
draft: false
tags:
  - reflection
summary: Most decisions that you make are not nearly as important as your ability to change them in the future
---

{{<tagline>}}
Most decisions that you make are not nearly as important as your ability to change them in the future
{{</tagline>}}

When designing [systems](/lexicon#system), it's easy to get caught up in the minutia of each decision that has to be
made along the way. Technical systems may raise concerns about choosing the appropriate logging framework or determining
the most effective concurrency model. Human systems may instead be concerned with how many meetings to hold, with whom,
and how often.

While individual decisions may be important to the outcome of the project, the ability to adapt and change those
decisions in the future is likely to be significantly more critical. Despite careful thought and planning, achieving
100% certainty in the correctness of every decision is highly unlikely. Even if this level of certainty were possible,
the [Pareto principle](https://en.wikipedia.org/wiki/Pareto_principle) suggests that 80% of the overall outcome will be
driven by only 20% of these decisions; therefore, investing excessive time to ensure the absolute correctness of _every_
decision would necessarily result in a considerable amount of wasted resources.

Given that many decisions will need to be adapted to changing requirements or unforeseen constraints, it is more prudent
to focus on the ease of modifying decisions rather than striving for perfection at any given point. Taking this idea a
step further involves identifying the fundamental properties that are believed to be resistant to change over time — Pareto's
"vital few". These conceptual building blocks serve as a foundation for framing all other decisions,
warranting dedicated time to clarify and reduce uncertainty based on the specific problem domain.

Strong technologists are already accustomed to this type of thinking: [modular
design](https://en.wikipedia.org/wiki/Modular_design), the [single-responsibility
principle](https://en.wikipedia.org/wiki/Single-responsibility_principle),
[coupling](https://en.wikipedia.org/wiki/Coupling_(computer_programming)), and
[cohesion](https://en.wikipedia.org/wiki/Cohesion_(computer_science)) are just a few examples of the types of techniques
and concepts that software engineers employ to create technical systems that can be easily modified over time.
Strong leaders should be also be accustomed to the approach, but this is unfortunately not always the case.

In many ways, human systems are more difficult to design and modify than their technical counterparts. People are
complex, individual, and don't follow the strict rules that we can happily expect of our code and operating systems. So
why should we focus on creating flawless systems for collaboration? Every company is different. Every team within every
company is different. Every person within every team is different. While there are strategies that we can use to
increase the chance of success across teams and organizations, leaders should be careful not to reduce their
systems to rigid rules that resist change.

Time spent trying to craft a perfect process or [SDLC](https://en.wikipedia.org/wiki/Systems_development_life_cycle)
could be better spent crafting an environment of psychological safety. Empower people to provide feedback. Give teams
the autonomy and purpose that they need to make changes to the way that they work. Understand that the whole is more
than the sum of its parts. Embrace that nothing will ever be perfect. Focus on the ability to adapt and improve as
situations change. It doesn't really matter so much how people are working at any point in time provided that
their goals are being accomplished.

Thus my assertion: whether you're working with people or with technology, your ability to change decisions in the future
will often outweigh the importance of the decisions themselves.
