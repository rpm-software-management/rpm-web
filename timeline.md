---
layout: default
title: rpm.org - Timeline
---

#### RPM 4.13.0-rc2 released! (October 20th 2016) ####
 * Numerous bugfixes and minor enhancements across the board
 * Support for debuginfo compression and minidebuginfo
 * See [the original announcement](http://lists.rpm.org/pipermail/rpm-maint/2016-October/004620.html) for full details of what has changed since rc1
 * See [draft release notes](wiki/Releases/4.13.0) for download information and full details of changes since 4.12.0.1

#### RPM 4.13.0-rc1 released! (September 2nd 2015) ####
 * Finalized syntax for [Rich Dependencies](PackagerDocs/BooleanDependencies)
 * Added support for file signatures in security.ima xattr
 * Enable {} expansion in rpmGlob()/%files and enhanced glob handling
 * Fix compressed patches
 * Don't warn when an escaped macro is in comment.
 * Add --filetriggers query option
 * Fix for Py3 compatibility
 * Do not bytecompile python scripts in docdir
 * Improvements to find-lang.sh and perl dependency generator
 * Use default value (currently 7) for XZ compression if not value is given
 * See [draft release notes](wiki/Releases/4.13.0) for download information and full details of changes since 4.12.0.1

#### RPM 4.13.0 alpha released! (July 24th 2015) ####
 * Support for File Triggers
 * Support for Boolean Dependencies
 * Lots code cleanups and numerous bugfixes
 * See [draft release notes](wiki/Releases/4.13.0) for download information and full details of changes since 4.12.0.1
#### RPM 4.12.0.1 released! (Sep 18th 2014) ####
 * Fixes a regression in archive size calculation during build
 * See [release notes](wiki/Releases/4.12.0.1) for download information and full details of changes since 4.12.0

#### RPM 4.12.0 released! (Sep 16th 2014) ####
 * Support for files over 4GB in packages
 * Support for weak dependency tags (suggests, recommends etc)
 * Support for plugins
 * Faster package generation and signing
 * New APIs to access package payloads
 * Vast code cleanups and numerous bugfixes
 * See [release notes](wiki/Releases/4.12.0) for download information and full details of changes since 4.11.2

#### RPM 4.11.3 released! (Sep 5th 2014) ####
 * Assorted bug fixes all over the place
 * See [release notes](wiki/Releases/4.11.3) for download information and full details of changes since 4.11.2

#### RPM 4.12.0 rc1 released! (Aug 27th 2014) ####
 * Fixes several icky regressions introduced in the beta
 * See [draft release notes](wiki/Releases/4.12.0) for download information and full details of changes since 4.11.2

#### RPM 4.12.0 beta1 released! (Aug 18th 2014) ####
 * A few regressions in the alpha, and some other minor bugs fixed
 * Optimizations to dependency check processing
 * Support automatic generation of weak dependencies
 * See [draft release notes](wiki/Releases/4.12.0) for download information and full details of changes since 4.11.2

#### RPM 4.12.0 alpha released! (Jun 27th 2014) ####
 * Support for files over 4GB in packages
 * Support for weak dependency tags (suggests, recommends etc)
 * Support for plugins
 * Faster package generation and signing
 * New APIs to access package payloads
 * Vast code cleanups and numerous bugfixes
 * See [draft release notes](wiki/Releases/4.12.0) for download information and full details of changes since 4.11.2

#### RPM 4.11.2 released! (Feb 13th 2014) ####
 * Assorted bug fixes all over the place
 * Various minor enhancements to Python bindings
 * See [release notes](wiki/Releases/4.11.2) for download information and full details of changes since 4.11.1 

#### RPM 4.11.2 rc2 released! (Feb 06th 2014) ####
 * Fixes a nasty dormant bug brought to daylight in rpm >= 4.10, plus some other minor tweaks over rc1
 * See [draft release notes](wiki/Releases/4.11.2) for download information and full details of changes since 4.11.1

#### RPM 4.11.2 rc1 released! (Jan 20th 2014) ####
 * Assorted bug fixes all over the place
 * Various minor enhancements to Python bindings
 * See [draft release notes](wiki/Releases/4.11.2) for download information and full details of changes since 4.11.1

#### RPM 4.11.1 released! (Jun 27th 2013) ####
 * Much improved macro and spec parsing performance
 * Improved rpmdb concurrent access support
 * Lots of bugs, old and new, fixed
 * See [release notes](wiki/Releases/4.11.1) for download information and full details of changes since 4.11.0
 * No changes from rc2

#### RPM 4.11.1 rc2 released! (Jun 20th 2013) ####
 * Fixes a minor spec-parsing regression introduced in rc1
 * Fixes to couple of old macro expansion bugs, debugedit improvements
 * See [release notes](wiki/Releases/4.11.1) for download information and full details of changes since 4.11.0

#### RPM 4.11.1 rc1 released! (Jun 10th 2013) ####
 * Much improved macro and spec parsing performance
 * Improved rpmdb concurrent access support
 * Lots of bugs, old and new, fixed
 * See [release notes](wiki/Releases/4.11.1) for download information and full details of changes since 4.11.0

#### RPM 4.10.3.1 released! (Feb 6th 2013) ####
 * Fixes severe regression related to %ghost %config handling introduced in 4.10.3
 * This release effectively replaces the original 4.10.3 which has been
   permanently pulled out of distribution.
 * See [release notes](wiki/Releases/4.10.3.1) for download information and changes from 4.10.3

#### RPM 4.11.0.1 released! (Feb 1st 2013) ####
 * Fixes severe regression related to %ghost %config handling introduced in 4.11.0
 * This release effectively replaces the original 4.11.0 which has been
   permanently pulled out of distribution.
 * See [release notes](wiki/Releases/4.11.0.1) for download information and changes from 4.11.0

#### RPM 4.11.0 released! (Jan 29th 2013) ####
 * Improved performance and memory use
 * Improved file conflict detection
 * Improved %config file handling
 * Easy separation of licenses from other documentation in packaging
 * Fully automated patch application with optionally using DVCS of choice in specs
 * Lots of bugs, old and new, fixed
 * See [release notes](wiki/Releases/4.11.0) for download information and full details of changes since 4.10.x

#### RPM 4.10.3 released! (Jan 29th 2013) ####
 * Fixes an install-time regression which can cause creation of real files and
   directories skipped when the path is shared with a %ghost.
 * Various other minor fixes
 * See [release notes](wiki/Releases/4.10.3) for download information and full details of changes since 4.10.2

#### RPM 4.11.0 beta1 released! (Dec 11th 2012) ####
 * Various mostly minor bugs and regressions fixed since alpha
 * See [draft release notes](wiki/Releases/4.11.0) for download information and full details of changes since 4.10.x
 * [Original announcement](http://lists.rpm.org/pipermail/rpm-announce/2012-December/000037.html)

#### RPM 4.10.2 released! (Dec 10th 2012) ####
 * Fixes a security regression introduced in rpm 4.10.0
 * Various other minor bugs and regressions fixed
 * See [release notes](wiki/Releases/4.10.2) for download information and full details of changes since 4.10.1
 * [Original announcement](http://lists.rpm.org/pipermail/rpm-announce/2012-December/000036.html)

#### RPM 4.11.0 alpha released! (Nov 7th 2012) ####
 * Improved performance and memory use
 * Improved file conflict detection
 * Improved %config file handling
 * Easy separation of licenses from other documentation in packaging
 * Fully automated patch application with optionally using DVCS of choice in specs
 * Lots of bugs, old and new, fixed
 * See [draft release notes](wiki/Releases/4.11.0) for download information and full details of changes since 4.10.x
 * [Original announcement](http://lists.rpm.org/pipermail/rpm-announce/2012-November/000035.html)

#### RPM 4.10.1 released! (Oct 3rd 2012) ####
 * Several fixes to regressions introduced all the way back in 4.9.0 and some in 4.10.0
 * Some minor enhancements to (spec parsing, package building, install-performance on shared files etc)
 * See [release notes](wiki/Releases/4.10.1) for download information and full details of changes since 4.10.0
 * [Original announcement](http://lists.rpm.org/pipermail/rpm-announce/2012-October/thread.html)

#### RPM 4.10.0 released! (May 24th 2012) ####
 * Support for dpkg-style tilde version/release sort operator added
 * Erasure progress implemented
 * Performance improvements
 * Lots of bugs, old and new, fixed
 * See [release notes](wiki/Releases/4.10.0) for download information and full details of changes since 4.9.x
 * [Original announcement](http://lists.rpm.org/pipermail/rpm-announce/2012-May/000033.html)

#### RPM 4.10.0 beta1 released (Apr 23rd 2012) ####
 * Main changes since 4.10.0-alpha:
   * Several regressions fixed
   * File conflict detection improvements
   * Obsoletes handling improvements
   * Support for dpkg-style sorting of tilde in versions
 * See [draft release notes](wiki/Releases/4.10.0) for download information and full details of changes since 4.9.x
 * [Original announcement](http://lists.rpm.org/pipermail/rpm-announce/2012-April/000032.html)

#### RPM 4.9.1.3 released! (Apr 3rd 2012) ####
 * This is a security-only update for CVE:2012-0060, CVE:2012-0061 and CVE:2012-0815
 * See [release notes](wiki/Releases/4.9.1.3) for download information and full details of changes since 4.9.1.2

#### RPM 4.10.0 alpha released (Mar 20th 2012) ####
 * Lots of bugs, old and new, fixed
 * Performance improvements
 * Erasure progress implemented
 * See [draft release notes](wiki/Releases/4.10.0) for download information and full details of changes since 4.9.x
 * [Original announcement](http://lists.rpm.org/pipermail/rpm-announce/2012-March/000030.html)

#### RPM 4.9.1.2 released! (Sep 29th 2011) ####
 * CVE:2011-3378 security issue causing crashes on reading malformed packages (RhBug:741606)
 * Fixes rpmdb signal handling regressions introduced in 4.9.1 and 4.9.1.1 (RhBug:739492)
 * See [release notes](wiki/Releases/4.9.1.2) for download information and full details of changes since 4.9.1.1

#### RPM 4.9.1.1 released! (Aug 2nd 2011) ####
 * Fixes package building regressions introduced in 4.9.1, which is a brown paperbag release and best avoided
 * See [release notes](wiki/Releases/4.9.1.1) for download information and full details of changes since 4.9.1

#### RPM 4.9.1 released! (Jul 15th 2011) ####
 * Two potential security issues fixed:
   * Malformed signature for which a key is not available could slip through unnoticed
   * Crash/memory corruption on PGP key armors containing more than one key
 * Numerous other bugfixes ranging from crashers to memory leaks to quiet misbehavior
 * Numerous minor enhancements especially wrt packaging and dependency generation
 * See [release notes](wiki/Releases/4.9.1) for download information and full details of changes since 4.9.0
 * [Original announcement](http://lists.rpm.org/pipermail/rpm-announce/2011-July/000028.html)

#### Temporary restrictions on bug reporting (Mar 25th 2011) ####
Due to a big surge in spam tickets in recent times, ticket creation and modification have temporarily been restricted to "known users". Better ways to deal with ticket spam are being investigated and the restriction will be naturally lifted once a better solution is in place. Apologies for any inconvenience caused, and feel free to use the mailing lists for reporting issues for the time being.

#### RPM 4.9.0 released! (Mar 2nd 2011) ####
 * Pluggable and filterable dependency generator
 * Performance improvements
 * New ordering hinting mechanism
 * Lots of bugs, old and new, fixed
 * See [release notes](wiki/Releases/4.9.0) for full details what has changed since 4.8.x
 * [Original announcement](http://lists.rpm.org/pipermail/rpm-announce/2011-March/000027.html)

#### RPM 4.9.0 rc1 released! (Feb 15th 2011) ####
 * Main changes since beta1:
   * A few bug / regression fixes
   * Dependency matching corner case fix when release is not specified
   * Support for %posttrans dependencies added
   * Support for self-conflicting packages added
 * See [draft release notes](wiki/Releases/4.9.0) for full details what has changed since 4.8.x

#### RPM 4.9.0 beta1 released! (Jan 17th 2011) ####
 * Main changes since alpha:
   * Several bug / regression fixes
   * Further customization features in the dependency generator
   * Install order hinting mechanism added 
 * See [draft release notes](wiki/Releases/4.9.0) for full details what has changed since 4.8.x
 * [Original annoucement](http://lists.rpm.org/pipermail/rpm-announce/2011-January/000026.html)

#### RPM 4.9.0 alpha released! (Nov 19th 2010) ####
 * Pluggable dependency generator
 * Performance improvements
 * ...and much much more, see [draft release notes](wiki/Releases/4.9.0) for full details what has changed since 4.8.x
 * [Original announcement](http://lists.rpm.org/pipermail/rpm-announce/2010-November/000025.html)

#### RPM 4.8.1 released! (Jun 11th 2010) ####
 * CVE:2010-2059 security issue on hardlinked executables with SUID/SGID bits and POSIX file capabilities
 * Transactions no longer hang due to unrelated non-responsive filesystems such as NFS / FUSE mounts
 * Several regressions and other bugs fixed 
 * See [release notes](wiki/Releases/4.8.1) for details what has changed since 4.8.0
 * [Original annoucement](http://lists.rpm.org/pipermail/rpm-announce/2010-June/thread.html)

#### RPM 4.8.0 released! (Jan 8th 2010) ####
 * Performance improvements, much improved ordering (erasures ordered too, dependency loops handled better) etc...
 * Major revamp of Python bindings, including preliminary support for Python 3.x
 * Lots of bugs, old and new, fixed
 * See [release notes](wiki/Releases/4.8.0) for details what has changed since 4.7.x
 * [Original announcement](http://lists.rpm.org/pipermail/rpm-announce/2010-January/000023.html)

#### RPM 4.8.0 beta1 released! (Dec 7th 2009) ####
 * Performance improvements, much improved ordering (erasures ordered too, dependency loops handled better) etc...
 * Major revamp of Python bindings, including preliminary support for Python 3.x
 * Lots of bugs, old and new, fixed
 * See [draft release notes](wiki/Releases/4.8.0) for details what has changed since 4.7.x
 * [Original annoucement](http://lists.rpm.org/pipermail/rpm-announce/2009-December/000022.html)

#### RPM 4.7.2 released! (Nov 25th 2009) ####
 * Lots of bugfixes all around, some minor enhancements
 * See [release notes](wiki/Releases/4.7.2) for further details.
 * [Original annoucement](http://lists.rpm.org/pipermail/rpm-announce/2009-November/000021.html)

#### RPM 4.7.1 released! (Jul 21st 2009) ####
 * Lots of bugfixes all around, some minor enhancements
 * See [release notes](wiki/Releases/4.7.1) for further details.
 * [Original annoucement](http://lists.rpm.org/pipermail/rpm-announce/2009-July/000020.html)

#### RPM 4.6.1 released! (May 18th 2009) ####
 * Several signature checking/handling fixes
 * Various other bugfixes and minor improvements all around
 * See [release notes](wiki/Releases/4.6.1) for further details.
 * [Original annoucement](http://lists.rpm.org/pipermail/rpm-announce/2009-May/000019.html)

#### RPM 4.7.0 released! (Apr 16th 2009) ####
 * Vastly improved performance and reduced memory footprint over older versions
 * XZ/LZMA payload compression support
 * Support for POSIX file capabilities
 * Lots of bugs fixed
 * RPM 4.7.0 [release notes](wiki/Releases/4.7.0)
 * [Original announcement](http://lists.rpm.org/pipermail/rpm-announce/2009-April/000018.html) and changes from RC1.

#### RPM 4.7.0 rc1 released! (Apr 9th 2009) ####
 * Fixes a few nasty regressions introduced in beta1
 * Bunch of bug fixes, both old and new, fixed, see [original announcement](http://lists.rpm.org/pipermail/rpm-announce/2009-April/000017.html) for full summary of changes since beta1
 * RPM 4.7.0 [draft release notes](wiki/Releases/4.7.0)

#### RPM 4.7.0 beta1 released! (Feb 26th 2009) ####
 * Big performance improvements over previous versions, much reduced memory footprint
 * Support for POSIX file capabilities
 * Lots of bugs, old and new, fixed
 * See [draft release notes](wiki/Releases/4.7.0) for details what has changed since 4.6.0

#### RPM 4.6.0 released! (Feb 6th 2009) ####
 * Vast amount of fixes and improvements over the aging 4.4.x series
 * See [release notes](wiki/Releases/4.6.0) and
   [compatibility notes](wiki/Releases/4.6.0#Compatibilitynotes) for details what has changed since 4.4.x
 * [Original announcement](http://lists.rpm.org/pipermail/rpm-announce/2009-February/000013.html)

#### RPM 4.6.0 release candidate 4 out (Jan 30th 2009) ####
 * Fixes:
   * Various corner-case misbehaviors and segfaults 
   * Reduce impact of NSS disliking forks
 * Full summary of changes since RC3 available [here](http://lists.rpm.org/pipermail/rpm-announce/2009-January/000012.html)
 * RPM 4.6.0 draft [release notes](wiki/Releases/4.6.0)

#### RPM 4.6.0 release candidate 3 out (Dec 9th 2008) ####
 * Fixes:
   * Queryformat regressions
   * Public header C++ brokenness
   * Compatibility workarounds for old and broken packages
   * Buildroot correctness on sub-packages with differing versions
 * Full summary of changes since RC2 available [here](http://lists.rpm.org/pipermail/rpm-announce/2009-January/000012.html)
 * RPM 4.6.0 draft [release notes](wiki/Releases/4.6.0)

#### RPM 4.6.0 release candidate 2 out (Nov 29th 2008) ####
 * Bunch of more or less minor issues found in rc1
 * Full summary of changes since RC1 available [here](http://lists.rpm.org/pipermail/rpm-announce/2009-January/000012.html)
 * RPM 4.6.0 draft [release notes](wiki/Releases/4.6.0)

#### RPM 4.6.0 release candidate 1 out (Oct 16th 2008) ####
 * RPM 4.6.0 draft [release notes](wiki/Releases/4.6.0)

#### RPM 4.5.90 (4.6 alpha) available for testing (Sep 30th 2008) ####
 * RPM 4.6.0 draft [release notes](wiki/Releases/4.6.0)

#### rpm.org site update (Sep 30th 2008) ####

 * Rpm.org has moved to new hosting provider ([OSU Open Source Lab](http://osuosl.org))
 * The website has been converted from mixture of static html and Moin Wiki to [Trac](http://trac.edgewall.org/)
 * Rpm finally has a real upstream bug tracking system via Trac

#### RPM 4.4.2.3 released! (Apr 1st 2008) ####

 * Dozens of bugfixes and minor improvements all around
 * [Summary of changes](wiki/Releases/4.4.2.3)
 * [Original announcement](https://lists.dulug.duke.edu/pipermail/rpm-announce/2008-April/000003.html) (with incorrect tarball url, duh)


#### RPM development switches to GIT (Mar 31th 2008) ####

 * Rpm code repository has been converted from Mercurial to GIT, effective immediately. Access details are documented on [wiki/GetSource] page.

#### RPM 4.4.2.3 release candidate 1 out for testing (Jan 25th 2008) ####

 * Dozens of bugfixes and minor improvements all around
 * [Original announcement](https://lists.dulug.duke.edu/pipermail/rpm-maint/2008-January/000737.html)

#### RPM 4.4.2.2 released! (Oct 3rd 2007) ####

 * Dozens of bugfixes and minor improvements all around
 * [Summary of changes](wiki/Releases/4.4.2.2)
 * [Original announcement](https://lists.dulug.duke.edu/pipermail/rpm-maint/2007-October/000546.html)

#### RPM 4.4.2.1 released! (Jul 23rd 2007) ####

 * Dozens of bugfixes and minor improvements all around
 * Cleaning up of vendor specific hacks etc
 * [Summary of changes](wiki/Releases/4.4.2.1)
 * [Original announcement](https://lists.dulug.duke.edu/pipermail/rpm-announce/2007-July/000001.html)

#### rpm.org reboot (Dec 14th 2006) ####

 * [Original announcement](https://http://lists.rpm.org/pipermail/rpm-announce/2006-December/000005.html)
