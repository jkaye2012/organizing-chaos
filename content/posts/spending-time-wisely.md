---
title: Spending time wisely
date: 2024-11-06
draft: false
tags:
  - leadership
  - practices
summary: Getting a lot done is important only when we're doing the right things
---

{{<tagline>}}
Getting a lot done is important only when we're doing the right things
{{</tagline>}}

All of us would like to increase our productivity, but it’s easy to confuse "doing more" with doing what actually
matters. There are many ways that we can talk about productivity and how we can differentiate useful work from staying
busy. Toil and overhead are terms often used interchangeably to describe necessary but unproductive work, but they
differ significantly in what they demand from us. Likewise, balancing efficiency and effectiveness is essential to
getting valuable work done without sacrificing the flexibility that allows teams to adapt and innovate. Understanding
these dynamics will make teams not only more productive, but also more impactful.

# Effective vs. Efficient

Let's begin with some simple definitions for **effective** and **efficient**.

A team's **effectiveness** is defined by their ability to achieve desired outcomes. It's about doing the right things,
including prioritizing impact, quality, and adaptability to unexpected demands. As Tom DeMarco argues in [Slack](https://www.goodreads.com/book/show/123715.Slack),
effectiveness requires unallocated time and capacity to handle unanticipated work and to innovate. Critically, the effectiveness of
a team should be considered separately from how quickly they're able to achieve these outcomes.

A team's **efficiency** is defined by their ability to minimize resource usage (time, money, effort, etc.) required
to achieve outputs. Efficiency is about doing things right, reducing waste, and adhering to streamlined processes. How quickly
things are getting done is a result of the team's efficiency rather than their effectiveness.

In general, there's a very large focus on making engineering teams more efficient. Consider the [DORA metrics](https://dora.dev/guides/dora-metrics-four-keys/)
for example:

> Technology-driven teams need ways to measure performance so that they can assess how they’re doing today, prioritize improvements, and validate their progress.
> DORA has identified four software delivery metrics—the four keys—that provide an effective way of measuring the outcomes of the software delivery process.
>
> * Change lead time: the time it takes for a code commit or change to be successfully deployed to production. It reflects the efficiency of your delivery pipeline.
> * Deployment frequency: how often application changes are deployed to production. Higher deployment frequency indicates a more efficient and responsive delivery process.
> * Change fail percentage: the percentage of deployments that cause failures in production, requiring hotfixes or rollbacks. A lower change failure rate indicates a more reliable delivery process.
> * Failed deployment recovery time: the time it takes to recover from a failed deployment. A lower recovery time indicates a more resilient and responsive system.

I'm a fan of DORA in general. The metrics are a good way to measure outputs and to gauge the predictability and maturity of an [SDLC](https://en.wikipedia.org/wiki/Systems_development_life_cycle).
But they decidedly _do not_ measure the _outcomes_ of the software delivery process as asserted here. They're necessary, but not sufficient. Two teams can have identical
DORA metrics while one is delighting their customers and the other is shipping changes that no one wants. The teams are equally efficient, but one is effective while the
other is not.

If you could choose between having a team that is effective but inefficient, or one that is efficient but ineffective, which would you choose?
I believe we should _always_ choose the effective team. The efficient but ineffective team may actually be providing net negative value by
generating work that is going to have to be maintained without any tangible benefit. An increase in maintainence cost without a corresponding
impact on the bottom line is worse than doing nothing at all.

Of course, we don't actually want teams that are _only_ efficient or _only_ effective.
Balancing effectiveness with efficiency doesn’t mean sacrificing one for the other; rather, it’s about understanding
where efficiency enhances effectiveness and where it hinders it.

The key point here is that "doing work" is not enough. We also need to ensure that the work that we're doing is useful and impactful. It sounds obvious,
but take a look in detail at how engineering teams are measuring themselves and you'll quickly find that most are devoid of any real idea of how effective
they are. Shipping often is great, but only if you're shipping changes that matter.

Further, we can compare effectiveness and efficiency on a few different core aspects:

| Aspect                   | Effectiveness                                      | Efficiency                                           |
|----------------------    |----------------------------------------------------|------------------------------------------------------|
| **Focus**                | Doing the *right* things                           | Doing things *right*                                 |
| **Slack**                | Requires flexibility and problem-solving           | Usually sees slack as waste                          |
| **Innovation**           | Enables innovation and problem-solving             | May limit innovation, focusing on routine            |
| **Resilience**           | Higher, due to capacity for unplanned work         | Lower, as high efficiency reduces flexibility        |
| **Goal**                 | Maximizing impact and adaptability                 | Minimizing resource consumption, increasing delivery |

Efficiency is normally considered to be a virtue, but as we can see, extreme efficiency can lead to a
lack of resilience. Resources are so tightly allocated that there’s little room for slack, flexibility, or innovation. A focus on
effectiveness doesn't share these same limitations.

So, while the focus is often on maximizing efficiency, more often we'd be better served by focusing on making our teams
more effective. Getting a lot done is important only when we're doing the right things. This is a large part of why
it's important to [measure outcomes over outputs](https://martinfowler.com/bliki/OutcomeOverOutput.html). While it's
true that measuring outcomes is, in general, much more difficult than measuring the outputs of a given team, it's
the act of _attempting_ to measure the outcome that is as important as anything else. Teams should be focused on the
outcomes that they're achieving rather than thinking myopically about the number of features that they've delivered or
story points that they've closed in each sprint. The mindset rather than the perfection of the measurement is the goal.

This isn't to say that teams shouldn't focus at all on their efficiency. It's going to be very difficult to have a large impact on the
business if you're never shipping anything, and there are [inherent benefits to focusing on small steps](https://www.geepawhill.org/series/many-more-much-smaller-steps/).
Comparatively, however, it's much easier to optimize a team's efficiency than their effectiveness. Solve the hard problem of how to do
the right things first, then move on to making sure that those changes are being delivered as efficiently as feasible without removing
too much slack from the human system.

# Toil vs. Overhead

Another way to think about the difference between efficiency and effectiveness is through the lens of the ostensibly non-engineering work that
is generally required of engineering teams. [Google's SRE book](https://sre.google/sre-book/eliminating-toil/) assigns specific, differentiated
meaning to **toil** and **overhead** that we can use to to help with this purpose. Though similar at first glance, understanding the nuanced
difference can change how we allocate resources and shape processes.

**Toil** consists of the repetitive, manual tasks required to maintain a service in production, scaling linearly with
service growth. It’s tactical and operational, offering no incremental benefit to service quality or innovation. The key
is that toil is automatable; if automated, toil disappears with a net positive impact on the system or team.

**Overhead**, on the other hand, encompasses any work that doesn't directly produce value but is necessary for
maintaining business or engineering operations. It’s usually structural (e.g. administrative tasks, mandatory meetings,
or compliance processes) and generally cannot be automated entirely. Overhead often provides indirect or long-term
value, such as alignment across teams, though its cumulative weight can reduce an organization’s efficiency.

Toil looks like restarting a service on a daily basis. Overhead looks like a bi-weekly planning meeting.

So, while the terms sound similar, they are in fact quite different. Toil provides no inherent benefit whatsoever,
while overhead does. Communicating about the concepts in this way helps us to contexualize and understand how we should
treat them differently despite the fact that they both negatively impact efficiency on the surface.

Similar to effective vs. efficient, we can compare toil and overhead in more detail:

| Aspect            | Toil                                         | Overhead                                                               |
|-------------------|----------------------------------------------|------------------------------------------------------------------------|
| **Nature**        | Repetitive, operational                      | Administrative, process-oriented                                       |
| **Growth**        | Scales linearly with service size            | Constant with some economies of scale                                  |
| **Value**         | No inherent value                            | Indirect value, coordination and alignment benefits                    |
| **Eliminability** | Can be automated away                        | Often structural, elimination may impact coordination or communication |
| **Goal**          | Reduce/eliminate through automation          | Streamline, minimize where possible                                    |

Both toil and overhead negatively impact efficiency. We would complete more tasks without any overhead and with no toil. The indirect value of
overhead is generated from its impact on effectiveness. With no overhead at all, engineers wouldn't have the context and understanding that
they need to get the right things done. Of course, this is a delicate balancing act. It's difficult to identify the right amount of
overhead. This is part of why I believe it's so important to [minimize global process](/posts/minimize-global-process/) and give teams as
much control over their overhead as feasible.

Critically, this means that removing _all_ overhead should be an anti-goal! The goal is not to remove all overhead, but rather to ensure
that a team's overhead is useful and minimal. Toil, on the other hand, should always be removed when it's deemed cost-effective to do so.
Toil that takes 5 minutes twice a year might not be worth automating, but toil that consumes hours per month almost certainly should be
automated.

When evaluating the effectiveness of overhead, consider questions like:

* Does the overhead directly clarify goals, priorities, or expectations?
* Does the team fully understand the purpose of their overhead?
* Is the effort required for the overhead fixed, or does it scale somehow with team or service size?

All of this is to say: **is our overhead helping us be more effective?** Framing overhead in this way can help
contextualize the importance of these rituals for engineers. When people understand the motivation for processes,
they'll be more engaged with them and more likely to leverage them to their fullest extent. Everyone on the team
should be helping to ensure that overhead is useful and streamlined.

As a general rule of thumb, if some amount of overhead isn't being regularly removed, chances are you have too much. Overhead tends to
grow naturally over time, requiring proactive time and effort to keep it minimal. Choose a cadence (quarterly works well enough) and
set some time aside to carefully evaluate the overhead of your time. If there's even a chance that a piece of overhead might not be
valuable, try to get rid of it and see if anything breaks. You might be surprised by how much you can trim while still maintaining
what you need to be effective.

Striking a balance between necessary overhead and relentless elimination of toil can be complex, but by centering
decisions on effectiveness, teams can sustain their impact while they improve their efficiency.

In the end, it’s not about moving faster; it’s about moving meaningfully. Define what matters most, guard the time and
resources to achieve it, and be relentless in reducing the rest. When you do, productivity is not a measure of speed but
of purpose.
