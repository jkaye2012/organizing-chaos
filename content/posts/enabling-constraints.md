---
title: Enabling constraints
date: 2024-03-06
draft: false
tags:
  - reflection
---

{{<tagline>}}
Constraints don't always have to make things more difficult.
{{</tagline>}}

What comes to mind when you hear the word _constraint_?

Often, thoughts will immediately jump to the negative: a constraint as a barrier that makes it more difficult to
accomplish a goal. This additional difficulty can end up being a [significant source of
complexity](https://www.hillelwayne.com/post/complexity-constraints/) when trying to solve problems, sometimes to the
point that avoiding constraints becomes a goal of its own. Constraints with this type of negative impact can be called
_restrictive_. Teams subject to too many restrictive constraints will eventually slow to a crawl as they attempt to
solve problems within such strict boundaries.

There is, however, another lens through which constraints can be viewed wherein they simplify a problem rather than
complicating it. A constraint can remove possibilities from the problem space, leaving fewer edge cases to handle and
less to think about overall. Constraints with this type of positive impact can instead be called _enabling_. Teams that
can identify enabling constraints will find their work simplified as they are freed from edge cases and consideration of
unknown unknowns.

When [designing systems](/posts/flexible-systems/), it's therefore important to understand the difference between
restrictive and enabling constraints. The former should generally be minimized to whatever extent is reasonable, while
the latter should be embraced when they can be identified. As the number of restrictive constraints grows, a team is
usually well-served to search more proactively for corresponding enabling constraints. The simplicity provided by
enabling constraints can be used as a tool to offset the complexity introduced by the restrictions.

One way to think about constraints that restrict relative to those that enable is by examining the source of the
constraint. If the source of the constraint is external, it will often be restrictive; these constraints are usually
imposed upon a system from the outside. Enabling constraints, on the other hand, are intentionally selected; they're
brought into a system for the simplicity benefits that they bring to the overall design. Restrictive constraints are not
within our control, so other ways need to be found to offset the complexity that they introduce. Note that by
"external", I mean external to the team responsible for solving a problem, not necessarily external to an
organization. Understanding the impacts of these types of constraints and effectively communicating those impacts to
less technical individuals (stakeholders in particular) is a primary tool that effective technical leaders can use to
help reduce the burden on their teams.

Another more detailed parallel can be drawn between constraints and complexity, specifically the concept of [essential
and accidental
complexity](https://medium.com/background-thread/accidental-and-essential-complexity-programming-word-of-the-day-b4db4d2600d4). Enabling
constraints remove essential complexity from a problem by obviating the need to handle a subset of the more generic
problem statement. Ideally, they're also selected so that they make accidental complexity less likely, or at least less
impactful.

Finally, the fantastic book [Leadership is Language](https://davidmarquet.com/leadership-is-language-book/) provides yet
another way to think about these ideas via Marquet's concepts of Redwork and Bluework. Redwork is reactive, mechanical,
and routine. It's the day-to-day operations that we carry out to get our jobs done. Bluework, on the other hand, is
exploratory, flexible, and varied. It's the higher-level cognitive tasks that we focus on to improve the way that we
work. Bluework benefits from increasing variability of thought and possibility, while Redwork benefits from increasing
certainty and reducing decision making. Through this lens, we can think of a subset of Bluework as identifying enabling
constraints. Finding such constraints is often not [easy](/posts/simplicity-isnt-easy), but once identified they have
the potential to greatly aid our Redwork by reducing the uncertainty to be considered when carrying out tasks.

Interestingly, it's possible for the same constraint to change from enabling to restrictive through the course of
time. Consider the concept of [service level
agreements](https://en.wikipedia.org/wiki/Service-level_agreement). Generally, the provider of a service will define the
service level that they can reasonably support. This advertised service level becomes a constraint: changes to the
system that would cause it to violate the service level cannot be enacted. On the other hand, the inverse is also true:
a design that would significantly simplify the system that doesnt't cause it to violate the service level can be chosen.

This type of decision can have large ramifications to the design and architecture of the system in question: whether
updates need to be immediately or eventually consistent, what types of standbys and fail-overs are necessary, and what
types of deployments can be supported, just to name a few. When a system is first created, defining the service level up
front can act as an enabling constraint; if it's determined that a system need only support 100000
[QPS](https://en.wikipedia.org/wiki/Queries_per_second), the design considerations and complexity that must be taken
into account are far simpler than those for a system that must support one hundred million or more.

As time passes, however, the system will continue to evolve, and could potentially reach a point where being forced to
maintain even the 100000 QPS level becomes restrictive given new required functionality. When originally selected, the
constraint enabled a simpler design, but as the number of users and desired functionality grows, the constraint becomes
externally-enforced, making it restrictive. Understanding how constraints are likely to impact a system as it changes
over time can help to decide which constraints should be designed against as a core property of the system and which
should be treated only as ancillary considerations.

Ultimately, managing complexity is one of the most important parts of software engineering, and thinking about
constraints is only one tool among many that we have to help us think about the systems that we're responsible for. We
should search for enabling constraints that allow us to simplify the designs and implementations of our systems. We must
also recognize that a constraint that enables when a system is first designed can eventually become a restriction with
significant negative impact if proper care isn't exercised.

It's almost always a good idea to pay attention to that constraints that you're working against and how they influence
your decision making.
