---
layout: default
title: rpm.org - Roadmap
---

# RPM Roadmap

An overview of the project's direction and release plans. Both the dates and
the content are tentative and subject to change. Everything above the
horizontal line is completed and only kept for reference.

#### RPM 6.1 release (2026 Q2)
* Improved keystore locking
* Restored NSS user/group support
* Signature verification tweaks
* Literal and one-shot macros
* Usable syslog plugin
* New man pages
* Clean Clang builds
* New [release model](../2026/05/11/release-cycle.html)
* See the [release notes](../releases/6.1.0) for details

---

#### RPM 6.2 release (2026 Q3/Q4)
* Symbol versioning in librpm (#1127)
* Database parking (image reproducibility) (#2219)
* Meaningful operation names in syslog plugin (#4215)
* First steps towards transaction robustness
* New man pages (dependencies, spec format)

#### Upcoming releases (2027)
* Durable, journal-based transactions (#2950)
* Filesystem capability checks (#2637)
* Improved file triggers usability (systemd) (#4185)
* BuildSystem rough edges & shortcomings (#3965)
* OverlayFS-compatible database rebuilds (#2355)
* Complete man page suite (#3612)

#### Future releases (2028 and later)
* Policy based package permissions (#4186)
* File classifier based actions (#2207)
* Improved scriptlet ordering (#436)
* Container-native database format (#2005)
* Optimized payload installation (copy-on-write/reflinks) (#4223)
* Better soname dependencies (#2872)
* True multiarch support (#2197)
* Arch-independent source archive format
* DVCS integration (packaging, `%config` file management)
* Buildinfo subpackages

For further information and feedback, head over to our [discussion forum.](https://github.com/rpm-software-management/rpm/discussions/2982)
