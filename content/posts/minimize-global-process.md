---
title: Minimize global process
date: 2023-11-15
draft: false
tags:
  - practices
  - sdlc
---

{{<tagline>}}
Global consistency comes at the cost of autonomy; be careful not to stifle what could be your most effective teams
{{</tagline>}}

Earlier this week, I was discussing Platform Engineering with some other technical leaders. Someone suggested that one
of the main benefits of an effective Platform was "reducing duplicate effort for developers", to which another replied:

> I have worked for a company that forced all engineers to use the same shitty CI/CD system. The Platform team “reduced
> duplicate efforts” such that no-one maintained their own CI/CD system anymore, but the fact was that the centralized
> solution was shitty, it made all engineer’s lives worse.
>
> If you are to remove duplicate efforts you need to be very certain that that solution also is a better one than what
> engineers have come up with themselves (generally, the product engineers know the problem they have better than a
> platform team)".

I agreed wholeheartedly with their point, but also couldn't help but think that the core message of this statement
extends far beyond the details of Platform Engineering. The idea that we should be able to simplify workflows or reduce
duplicate effort is very common among technical leaders; after all, many of us were once engineers ourselves and
optimizing [systems](/lexicon/#system) is second nature. Removing unnecessary work sounds great on the
surface, so it's not uncommon to see leaders who strive for global consistency across their entire organization.

Unfortunately, the complex dynamics of high functioning teams means that the situation is not as simple as we might like
it to be.

The benefits of global consistency are easy to understand, but the drawbacks are not so immediately obvious. I'm a
strong believer that autonomy is one of the most important traits of a high-performing engineering team, and global
processes are at odds with local autonomy by definition. While it's important to have some level of global consistency
across teams, I believe that most organizations would be better served by minimizing their global processes in favor of
more localized decisions.

# The role of autonomy in software engineering

Ultimately, the purpose of an engineering team is to drive positive outcomes. We often reach for measurements
of development workflows to understand the efficacy of a team, but even with very high velocity and high
quality systems a team may not be effective if they aren't contributing to outcomes that further the goals of the
business. Therefore, focusing on exactly how those outcomes are achieved is usually midguided, leading to concepts like
[outcomes over outputs](https://martinfowler.com/bliki/OutcomeOverOutput.html).

Given that it's difficult to gauge the inner workings of the team from outside - and nearly impossible to do so across
many different teams - it's usually more impactful to encourage teams to work in the way that they find are most
effective for them. Giving a team autonomy over the way that they work has many potential benefits:

* Members of the team will feel greater ownership over their work
* Different teams gain the ability to work in radically different ways; [ensemble
  programming](https://ensembleprogramming.xyz/) being one such example
* The team will have the ability to [change their localized process](/flexible-systems/) quickly and easily
* Engineers will no longer feel burdened by undue process as they now have a large hand in controlling it

The last point is particularly salient and is something that most professional engineers and leaders are likely to have
encountered at some point during their career. Many engineers have had bad experiences with process of all kinds: why
should I spend time "pushing paper" when I could be spending time getting things done?! It can be frustrating to hear
from a manager's perspective, but the core message makes sense: effective processes should always be facilitating work,
not getting in the way of it. A process that people find frustrating on a day-to-day basis is probably not something
that is worth keeping around.

The more generic and global a process is, the less likely it is that the process can be easily understood in a more
localized context. The individual who proposed and implemented the process likely did so with the organization's best
interests in mind, but by the time that process makes its way into the individual engineering teams, most of the context
behind _why_ that process is important is likely to have been lost. This, I believe, is a large factor in general
frustration with SDLC processes that are adopted globally in most companies. Individual teams find themselves going
through the motions without an understanding of why they're doing so or what benefit it has to them.

Teams that are responsible for their own processes have a great incentive to care about them. If something is
frustrating the engineers on a team, they know that they have the ability to change it, so it's in their best interest
to raise their thoughts with the rest of the team. Because the processes affect only the individual team, there is a
very low impediment to making such changes, and change fatigue is minimized because the suggested changes are coming
from within the team itself. Through this method of iterative improvement, over time, each team should eventually reach
an equilibrium where things are running smoothly: the Goldilocks zone of localized process.

# The benefits of global consistency

While I advocate for autonomy, I'm in no way opposed to some amount of global process. There are a lot of good things to
be said for global consistency, and it would be difficult to operate a large engineering organization without a common
baseline shared by all teams. Crucially though, rather than thinking about this commonality as ensuring that people work
in the same way, I find it's more effective to think about it as providing constraints that people can work within.  The
difficult part of this is finding the line between _enabling_ constraints and _restrictive_ constraints. The goal should
be to provide simplicity by reducing cognitive load, usually by reducing the total number of decisions that have to be
made.

When considered through this lens, I like to think of global process as the constraints that define the bounds of
autonomy for engineering teams.

A few examples of what I would consider to be beneficial global consistency:

* All code should be stored in the same source control system (though not necessarily in the same repository!)
* All changes should follow some sort of pull request workflow; changes should not be made directly to main
* All teams should make a best effort to accurately represent their work with issues

In most organizations, global constraints like this are likely to be uncontroversial and should help teams to
answer basic questions without requiring much thought.

There are other constraints that are more difficult to define. Should ideas like these be global constraints, or should
they be left to local autonomy?

* All code changes require at least one non-author code review before being merged to main
* All repositories should have a minimum code coverage threshold of 40%
* Only the following programming languages may be used: (insert your favorite list here)

I don't think there is a single correct answer. The situation is different for every company and the result is likely to
depend upon things like company culture, executive values, and organization size. You can easily find many competing
arguments about the relative merits of doing any of these (or all of them, or none of them), so it's really up to your
leadership team to define how far global consistency should go. Just make sure that you do so consciously and for the
right reasons.

# The SDLC toolkit: a practical middle-ground

I'm advocating that teams should be allowed to operate autonomously within some high-level bounds of global consistency.
One important question remains: how can something like this be achieved?

One approach that I've used personally to very good effect is something that I like to call the
[SDLC](https://en.wikipedia.org/wiki/Systems_development_life_cycle) toolkit. The basic idea is simple: define the
absolute minimum amount of global consistency that you need to effectively run the organization, then define a "library"
of team-level processes that teams can pick and choose from. This library shouldn't be something static owned by a
single individual, but instead a living repository of processes that different teams have found useful during their time
within the organization.

With such a library in place, teams are able to select processes that they believe might work well for them without
having to go through a potentially large amount of research and discovery in order to construct their individualized
process. If a team feels that something is missing from the library, they are free to do the work required to define the
new process, provided that they contribute it back to the library once it's complete. Before long, the library will
begin to stabilize, and teams will simply be picking and choosing processes that best suit their team members and the
systems that they own.

From an implementation perspective, there are many different routes that could be taken to accomplish this. Low tech
approaches like a shared wiki or Google doc are likely to suffice for smaller organizations, while larger organizations
may wish to provide automation using a tool like [GitLab Triage](https://gitlab.com/gitlab-org/ruby/gems/gitlab-triage).
My organization values automation wherever possible, so we've had good success with the latter, but different approaches
are likely to work for different companies.

Here are a few examples of what global policies and a policy library may look like. Each global policy also describes
the motivation behind it; in order for a global policy to be considered an enabling constraint, it's necessary to be
able to succinctly describe why it's important and why teams should care about it.

## Global policies

* All issues must be labeled with their owning team
  * Issues must be owned by a single team who is accountable for the issue's final outcome. Teams will also always need
    a way to filter their issues from the rest of the company, so it makes sense to apply this concept globally
* A closed Epic or Milestone should not contain open issues
  * This situation represents an obvious mistake in how work has been represented. The open issue(s) should either be
    closed or disassociated with the closed artifact
* Merge requests open for more than a month without activity are automatically closed
  * The author may be  notified a week before the merge request is closed. A merge request open for this long without
    any activity is unlikely to be useful, and inactive merge requests should not be allowed to accumulate unbounded
    over time

The nice thing about policies like this is that it's easy to automate them across the entire organization. Even with
high-level policies like this, it's important to consistently collect feedback from teams about what is and is not
working so that global consistency can be improved alongside localized processes.

## Policy library

* Issue weighting (story pointing): a team may decide that any issue that is brought into in-progress must have a
  weight associated with it
* Iteration cadences (sprints): a team may decide that any issue that is not in an explicit `backlog` state must have an
  iteration cadence associated with it
* Due dates: a team may decide that any issue that is brought into in-progress must have a due date set
* Custom labels: a team may decide that any issues associated with their `team::` label must also have a more specific
  set of scoped labels set
* Work-in-progress limits: a team may decide that they want to limit the total number of issues in progres, either on
  the team level or the individual level

Really, each of these policies are little more than ways of plucking out pieces of [Scrum](https://en.wikipedia.org/wiki/Scrum_(software_development)), [Kanban](https://en.wikipedia.org/wiki/Kanban_(development)), [XP](https://en.wikipedia.org/wiki/Extreme_programming), and other SDLC
methodologies that you're probably already familiar with. Depending on how far you want to take the concept, you could
decide to "bundle" policy libraries together so that teams can say things like "we'd like to use Scrum" rather than
having to select each policy individually.

## Challenges

The main challenge with the SDLC toolkit approach is ensuring that teams have the capabilities that they need to operate
autonomously using localized processes like these. As I acknowledged previously, one of the benefits of global
consistency is that is lowers cognitive load; requiring each team to have the expertise to run independently could be a
significant barrier to some organizations.

Personally, I believe that that the required effort is worth the payoff, but it's worth noting that an underperforming
team is unlikely to have the skills and discipline required to succeed using the SDLC toolkit without proper coaching.

# Conclusion

Achieving the correct balance between global consistency and local autonomy is a difficult challenge for software
engineering organizations. Striking the balance requires a thoughtful approach that, acknowledging that high performing
teams thrive on autonomy. By embracing a flexible framework like the SDLC toolkit, organizations can foster a culture
where teams have the freedom to choose processes that best suit their needs while simultaneously maintaining a
consistent set of global constraints.

The end goal is to empower teams to drive positive outcomes. Make sure that your global processes enhance your teams'
effectiveness rather than getting in the way.

