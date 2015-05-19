---
layout: default
title: Problems of layering
---
One level up: [Contribute](../contribute.html)

# Problems of layering

Additional to the Problems/Integration there are now different tools that build on top of RPM. All functionality that was "missing" in RPM was implemented there. We still miss a evaluation what functionality would better fit into RPM itself. While this page should collect a complete lists of such features not all should go into RPM.

## Package selection

Group packages and offer a selected set of packages that have meaning for the user while hiding packages that will installed automatically when needed. The idea is to move that away from the actual packages so it can be decided and changed on distribution/spin level.

Implementations:

* comps.xml in [yum](http://yum.baseurl.org/) repositories used by anaconda, pirut, yum, others (Fedora)
* [Patterns](http://en.opensuse.org/Patterns) (SuSE) 

## Language support

Select language packages for the languages and the programs installed on the system. Not yet supported very well.

* Somehow supported with [Dependencies](http://en.opensuse.org/Software_Management/Dependencies) in SuSE's [Patterns](http://en.opensuse.org/Patterns)
  * TODO: Can someone with more experience please comment on that a bit more, please? -- FlorianFesti? 2008-09-23T11:47:34Z) 

## Richer Dependencies

Give a hint what packages to install beyond the pure necessity.

* "Weak" dependencies, suggestes, enhances, ...
* Select the "right one" of several possible provides
* Offer the user a choice between alternatives
* Allow removing parts that are required right now but are not really essential (help (browser), documentation, ... ) but still install it by default. 

Implementations:

* [Patterns](http://en.opensuse.org/Patterns) (SuSE) 

## Update information

Classify updates as bug fix, security fix, feature enhancement, ... Can/should not be done on package level, but could be stored in the rpmdb or a yet to be invented rpm log.

Implementations:

* exist (TODO: add here) 

## RPM Log

Currently RPM doesn't keep it's own log of what happend. This has led to upper layer tools (yum, zypper) implementing their own logging facilities.

See [RpmLog](rpmlog.html)
