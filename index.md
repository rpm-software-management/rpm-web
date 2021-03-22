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

