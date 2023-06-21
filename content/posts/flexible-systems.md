---
title: "Flexible systems"
date: 2023-06-21
draft: false
tags:
  - reflection
---

{{<tagline>}}
Most decisions that you make are not nearly as important as your ability to change them in the future.
{{</tagline>}}

When designing [systems](/lexicon#system), it's easy to get caught up in the minutia of each decision that has to be
made along the way. For technical systems one may be worried about which logging framework to use or how the systems'
concurrency model should work. For human systems, the concern may instead be focused on how many meetings to hold, with
whom, and how often.

While many individual decisions may be important to the outcome of the project, what is likely to be significantly more
important is the ability to change those decisions in the future. With enough thought and planning, it's possible to
increase the probability of a correct decision that will stand the test of time, but it's highly unlikely that you'll be
able to get that probability anywhere close to 100%. Even if it somehow is possible to reach that level of certainty,
the [Pareto principle](https://en.wikipedia.org/wiki/Pareto_principle) suggests that 80% of the overall outcome will be
driven by only 20% of these decisions; therefore, spending so much time to ensure the absolute correctness of _every_
decision would necessarily result in a huge amount of wasted time and effort.

Because it's almost guaranteed that many of your decisions are going to have to be adapted to changing requirements or
unforeseen constraints, it's often better to focus on the ease of modifying a decision than it is to focus on trying to
make the absolute best decision at any point in time.

The idea can be extended a step further by attempting to define the truly fundamental properties that we believe cannot
(or should not) change over time. These are Pareto's "vital few": the conceptual building blocks that can be used to
frame all other decisions. They are where most time should be spent and where uncertainty should be clarified and
removed to whatever extent possible depending on the problem domain.

Strong technologists are already accustomed to this type of thinking: [modular
design](https://en.wikipedia.org/wiki/Modular_design), the [single-responsibility
principle](https://en.wikipedia.org/wiki/Single-responsibility_principle),
[coupling](https://en.wikipedia.org/wiki/Coupling_(computer_programming)), and
[cohesion](https://en.wikipedia.org/wiki/Cohesion_(computer_science)) are just a few examples of the types of techniques
and concepts that software engineers employ to create technical systems that are not difficult to modify over time.
Strong leaders should be accustomed to it as well, but this is unfortunately not always the case.

In many ways, human systems are more difficult to design and modify than their technical counterparts. People are
complex, individual, and don't follow the strict rules that we can happily expect of our code and operating systems. So
why should we focus on creating perfect systems of working together? Every company is different. Every team within every
company is different. Every person within every team is different. While there are strategies that we can employ that
will increase our chances of success across teams and organizations, leaders should be careful not to reduce their
systems to rigid rules that resist change.

Time spent trying to craft a perfect process or [SDLC](https://en.wikipedia.org/wiki/Systems_development_life_cycle)
could be better spent crafting an environment of psychological safety. Empower people to provide feedback. Give teams
the autonomy and purpose that they need to make changes to the way that they work. Understand that the whole is more
than the sum of its parts. Embrace that nothing will ever be perfect. By focusing on the ability to adapt and improve as
situations change means that it doesn't really matter so much how people are working at any point in time, provided that
their goals are being accomplished.

Thus my assertion: whether you're working with people or with tech, most decisions that you make are not nearly as
important as your ability to change them in the future.