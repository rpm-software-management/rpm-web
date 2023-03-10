---
layout: default
title: rpm.org - Home
---
## RPM Package Manager

The RPM Package Manager (RPM) is a powerful package management system
capable of

* building computer software from source into easily distributable
  packages
* installing, updating and uninstalling packaged software
* querying detailed information about the packaged software, whether
  installed or not
* verifying integrity of packaged software and resulting software installation

## News

#### RPM 4.18.1 released (Mar 13 2023)
* This is a bug fix release addressing a number of regressions and other issues.
* See [release notes](wiki/Releases/4.18.1) for details and download information
* Highlights include:
  * Preserve packages bit-by-bit again when adding and then removing signatures
  * Fix install of block and character special files
  * Disable `debuginfod` server lookups during package builds
  * Plugin fixes (fapolicyd and selinux)
  * Various OpenPGP and macro parser fixes

#### RPM v6 package format draft published (Jan 30 2023)
* The initial v6 format draft is now [up for discussion](https://github.com/rpm-software-management/rpm/discussions/2374)

#### RPM 4.18.0 released (Sep 20 2022)
* See [release notes](wiki/Releases/4.18.0) for details and download information
* Highlights include:
  * Big file handling rework to address a class of symlink vulnerabilities
    during install, restore and erasure
  * More intuitive conditional builds macro `%bcond`
  * Weak dependencies accept qualifiers like `meta` and `pre` now
  * New Sequoia-based OpenPGP backend
  * New interactive shell for working with macros (`rpmspec --shell`) and embedded Lua (`rpmlua`)
  * New `%conf` spec section for build configuration
  * New `rpmuncompress` cli tool simplifies unpacking multiple sources
  * Numerous macro improvements and fixes
  * Numerous internal OpenPGP parser correctness and security fixes

#### POPT 1.19 released (Sep 20 2022)
* See [release notes](https://github.com/rpm-software-management/popt/releases/tag/popt-1.19-release) for full details and download information
* Highlights since popt 1.18 include
  * Two regressions from 1.18 fixed
  * Code cleanups and fixes
  * License clarification

#### RPM 4.18.0 rc1 released (Sep 02 2022)
* See [release notes](wiki/Releases/4.18.0) for details and download information
* Highlights since 4.18.0-beta1 release include
  * Sequoia-based OpenPGP backend added
  * New SourceLicense tag in spec
  * Miscellanous bugfixes across the board

#### RPM 4.17.1.1 released (Sep 02 2022)
* This is a bug fix release to address two regressions introduced in 4.17.1.
* See [release notes](wiki/Releases/4.17.1.1) for details and download information

#### RPM 4.17.1 released (Jul 01 2022)
* This is primarily a bug fix release, with select minor enhancements.
* See [release notes](wiki/Releases/4.17.1) for details and download information
* Highlights include:
  * New `%bcond` macro for a nicer way to define build conditionals
  * New `%{verbose:...}` macro for verbose mode expansion
  * Separate warning summary in `rpmbuild(8)`
  * OpenPGP parser and IMA security fixes (CVE-2021-3521)
  * Buildroot policy fixes
  * Various other important and regression fixes

#### RPM 4.18.0 beta1 released (Jun 28 2022)
* See [release notes](wiki/Releases/4.18.0) for details and download information
* Highlights since 4.18.0-alpha2 release include
  * Misc bugs old and new fixed

#### POPT 1.19 rc1 released (Jun 07 2022)
* See [release notes](https://github.com/rpm-software-management/popt/releases/tag/popt-1.19-rc1) for full details and download information
* Highlights since popt 1.18 include
  * Two regressions from 1.18 fixed
  * Code cleanups and fixes
  * License clarification

#### RPM 4.18.0 alpha2 released! (May 05 2022)
* See [release notes](wiki/Releases/4.18.0) for details and download information
* Unfortunately alpha1 had a handful of small but annoying regressions
  introduced late in the cycle, making it quite untestable in large scale.
  This alpha2 update is just to address those, no new functionality is
  being added.

#### RPM 4.18.0 alpha1 released! (Apr 13 2022)
* See [release notes](wiki/Releases/4.18.0) for details and download information
* Highlights include:
  * Big file handling rework to address a class of symlink vulnerabilities
    during install, restore and erasure
  * More intuitive conditional builds macro `%bcond`
  * Weak dependencies accept qualifiers like `meta` and `pre` now
  * New interactive shell for working with macros (`rpmspec --shell`) and embedded Lua (`rpmlua`)
  * New `%conf` spec section for build configuration
  * New `rpmuncompress` cli tool simplifies unpacking multiple sources
  * Numerous macro improvements and fixes
  * Numerous OpenPGP parser correctness and security fixes

#### GitHub Discussions open (Apr 13 2022)
* We're opening up the [GitHub Discussions](https://github.com/rpm-software-management/rpm/discussions)
  to section as an experiment to improve communications with the community

#### RPM 4.17.0 released! (Sep 3 2021)
* See [release notes](wiki/Releases/4.17.0) for details and download information
* [Original announcement](https://lists.rpm.org/pipermail/rpm-announce/2021-September/000092.html)
* Highlights include:
  * More robust install failure handling
  * Many macro improvements, in particular wrt Lua integration
  * Some long-needed transaction API improvements
  * New buildroot policy to remove `.la` files by default
  * New dbus-announce plugin added
  * Many miscellaneous bugs, leaks and regressions fixed
  * Man pages converted to Markdown for easier maintenance + many other
    doc improvements
  * Beginnings of a reference manual:
    https://rpm-software-management.github.io/rpm/manual/
  * Debuginfo extraction split to external project:
    https://sourceware.org/debugedit/
  * Python helpers split to external project:
    https://github.com/rpm-software-management/python-rpm-packaging
  * Various unmaintained scripts removed

#### RPM 4.17.0 RC1 released! (Aug 20 2021)
* See [draft release notes](wiki/Releases/4.17.0) for details and download information
* [Original announcement](https://lists.rpm.org/pipermail/rpm-announce/2021-August/000091.html)
* Highlights since alpha include:
  * Fix building from tarball to not require pandoc
  * New dbus-announce plugin added
  * Multiple minor resource leaks fixed

#### RPM 4.17.0 BETA1 released! (Jun 22 2021)
* See [draft release notes](wiki/Releases/4.17.0) for details and download information
* [Original announcement](https://lists.rpm.org/pipermail/rpm-announce/2021-June/000090.html)
* Highlights since alpha include:
  * Debuginfo extraction split to external project:
    https://sourceware.org/debugedit/
  * Python helpers split to external project:
    https://github.com/rpm-software-management/python-rpm-packaging
  * Various unmaintained scripts removed
  * New buildroot policy to remove `.la` files by default
  * Man pages converted to Markdown for easier maintenance + many other
    doc improvements
  * Miscellaneous bugs and regressions fixed

#### IRC-channel move to Libera Chat (Jun 17 2021)
* The recent developments leave us no choice but to follow the masses
  to the new Libera Chat IRC network
* Along with the change we're moving from #rpm.org to #rpm channel
* Further details in the [original announcement](https://lists.rpm.org/pipermail/rpm-announce/2021-June/000089.html)

#### RPM 4.17.0 ALPHA released! (Apr 26 2021)
* See [draft release notes](wiki/Releases/4.17.0) for details and download information
* [Original announcement](http://lists.rpm.org/pipermail/rpm-announce/2021-April/000088.html)
* Highlights include:
  * More robust install failure handling
  * Many macro improvements, in particular wrt Lua integration
  * Some long-needed transaction API improvements
  * Beginnings of a reference manual

#### RPM 4.16.1.3 and 4.15.1.1 released! (Mar 22 2021)
* These are primarily security releases for CVE-2021-3421, CVE-2021-20271
  and CVE-2021-20266, with some additional fixes for important bugs.
* See [4.16.1.3](wiki/Releases/4.16.1.3) and [4.15.1.1](wiki/Releases/4.15.1.1)
  release notes for download information and further details.

#### RPM 4.16.1.2 released! (Dec 16 2020)
* See [release notes](wiki/Releases/4.16.1.2) for download information
* This is a brown paperbag release to fix a single regression in 4.16.1
  which causes rpmbuild to crash if hostname is not resolvable, and
  an accidental soname bump introduced in now withdrawn 4.16.1.1.

#### RPM 4.16.1.1 released ... and withdrawn (Dec 16 2020)
* The release got eaten by a mob of angry 2020 grues.

#### RPM 4.16.1 released! (Dec 10 2020)
* See [release notes](wiki/Releases/4.16.1) for full details and download information
* This is a bugfix-only release to address one regression in 4.16.0 and
  various other bugs, old and new.

#### RPM 4.16.0 released! (Sep 30 2020)
* See [release notes](wiki/Releases/4.16.0) for full details and download information
* [Announcement](http://lists.rpm.org/pipermail/rpm-announce/2020-September/000082.html) email
* Highlights include:
  * Database backends:
    * NDB backend promoted to stable
    * New sqlite-based backend
    * New experimental read-only BDB backend
    * BDB database backend deprecated
  * Powerful macro and %if expressions including ternary operator and native version comparison
  * Optional MIME type based file classification
  * Dependency generation by parametric macros
  * A new version parsing and comparison API in C and Python
  * Parallelise test-suite execution
  * Clarify RPM license

#### RPM 4.16.0 RC1 released! (Aug 31 2020)
* See [draft release notes](wiki/Releases/4.16.0) for full details and download information
* Miscellaneous bugfixes across the board

#### RPM 4.16.0 BETA3 released! (Jun 24 2020)
* See [draft release notes](wiki/Releases/4.16.0) for full details and download information
* Fixes (reverts) dependency generator regression in beta2

#### RPM 4.16.0 BETA2 released! (Jun 23 2020)
* See [draft release notes](wiki/Releases/4.16.0) for full details and download information
* Highlights since beta1 release include:
  * Several important fixes across the board
  * Parallelise test-suite execution

#### POPT 1.18 released, upstream rebooted! (Jun 23 2020)
* See [release notes](https://github.com/rpm-software-management/popt/releases/tag/popt-1.18-release) for full details and download information
* Highlighs since popt 1.16 include
  * Ancient security issue with popt failing to drop privileges on alias exec from a SUID/SGID program
  * Collected accumulated fixes from distros etc
  * Source and build-system cleanup and modernization

#### POPT 1.18 RC1 released, upstream rebooted! (May 29 2020)
* See [the announcement](http://lists.rpm.org/pipermail/rpm-announce/2020-May/000077.html) for the background story, details and download info
* Highlighs since popt 1.16 include
  * Ancient security issue with popt failing to drop privileges on alias exec from a SUID/SGID program
  * Collected accumulated fixes from distros etc
  * Source and build-system cleanup and modernization

#### RPM 4.16.0 BETA1 released! (May 29 2020)
* See [draft release notes](wiki/Releases/4.16.0) for full details and download information
* Highlights since the alpha release include:
  * A new version parsing and comparison API in C and Python
  * Native version comparison support in expressions
  * Assorted bugfixes and minor enhancements

#### RPM 4.14.3 released! (Apr 28 2020)
* See [release notes](wiki/Releases/4.14.3) for full details and download information
* Highlights include
  * Backported support for caret version
  * Numerous bugfixes across the board
  * Clarify RPM license

#### RPM 4.14.3 RC1 released! (Mar 26 2020)
* See [draft release notes](wiki/Releases/4.14.3) for full details and download information
* Highlights include
  * Backported support for caret version
  * Numerous bugfixes across the board
  * Clarify RPM license

#### RPM 4.16.0 ALPHA released! (Mar 23 2020)
* See [draft release notes](wiki/Releases/4.16.0) for full details and download information
* Highlights include:
  * New experimental sqlite and read-only BDB backends, NDB promoted to stable
  * Powerful macro and %if expressions including ternary operator
  * Automatic SSD detection and optimization on Linux
  * Optional MIME type based file classification
  * Dependency generation by parametric macros
  * Clarify RPM license

#### RPM 4.15.1 released! (Nov 18 2019)
* See [release notes](wiki/Releases/4.15.1) for full details and download information
* Highlights include:
  * Fixes to several important bugs and regressions
  * New gcrypt crypto backend

