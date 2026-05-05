---
layout: post
title: Changes to RPM version semantics and release cycle
---

The major version number has always meant the RPM package format it produces,
but the minor and micro versions have been less clear, to say the least.

In the 4.x series that ran over two decades, micro releases have mostly been
"bugfixes and minor features", but pretty much anything could happen in a minor
release. Sometimes major breakage. Especially the last few 4.x versions were
pretty rough as we pushed for some foundational changes.

It was painful for the users, and consequently for us developers as well.

With RPM 6.x, we are moving to a different mindset and a clearer definition of
what the numbers mean:

- Major version indicates the RPM package format (so no change here)
- Minor releases
    - Contain new features and bugfixes
    - Do not break things
    - Happen more often (biannual or even quarterly, this remains to be seen)
    - Will not have a full alpha/beta cycle, just release candidates over a few
      weeks at most
- Micro releases are security and bugfixes only, if needed between minor
  releases

If that sounds vaguely familiar, it is indeed drawing some inspiration from the
Linux kernel [release model](http://www.kroah.com/log/blog/2025/12/09/linux-kernel-version-numbers/).

This means, there will be a 6.1 release this quarter, preceded by a release
candidate or two.
