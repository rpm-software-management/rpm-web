#### RPM 4.19.0 BETA released (Aug 02 2023)
* This is a feature-complete pre-release with a number of bug fixes since ALPHA2.
* See [draft release notes](wiki/Releases/4.19.0) for details and download information
* Highlights include:
    * New `sysusers.sh` script as a drop-in replacement for `systemd-sysusers(8)`
    * New `%{specpartsdir}` macro for configuring the spec snippet location
    * New `%{rpmversion}` macro for obtaining the running RPM version
    * New Python binding usage examples
    * Adoption of Linux containers in the test-suite, replacing `fakechroot(1)`
    * Platform detection fixes and improvements for x86 CPUs
    * Chroot handling fixes

#### RPM 4.19.0 ALPHA2 released (Jun 09 2023)
* This is a bug fix update to address a couple of issues found by the early
  adopters of ALPHA1, mostly related to some bits and pieces missed during the
  CMake transition.
* See [draft release notes](wiki/Releases/4.19.0) for details and download information

#### RPM 4.19.0 ALPHA released (Apr 13 2023)
* See [draft release notes](wiki/Releases/4.19.0) for details and download information
* Highlights include:
    * New spec snippet [support](https://rpm-software-management.github.io/rpm/manual/dynamic_specs.html) for dynamic spec generation
    * New `sysusers.d(5)` [integration](https://rpm-software-management.github.io/rpm/manual/users_and_groups.html) for automated user and group handling
    * Memory and address-space aware build resource allocation
    * Proper shell-like globbing and escaping in `%files` and CLI
    * New CMake build system
    * Translations [split off](https://github.com/rpm-software-management/rpm-l10n/)
    * Removal of various deprecated and/or unused APIs
    * Various internal code cleanups

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

#### POPT 1.18 RC1 released, upstream rebooted! (May 29 2029)
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

#### RPM 4.15.1 released! (Nov 18 2019)
* See [release notes](wiki/Releases/4.15.1) for full details and download information
* Highlights include:
  * Fixes to several important bugs and regressions
  * New gcrypt crypto backend

#### RPM 4.15.0 released! (Sep 26 2019)
* See [release notes](wiki/Releases/4.15.0) full details and download information
* Highlights include:
  * Dynamic build dependencies
  * Support for %elif, %elifos and %elifarch statements in spec
  * Caret version operator (the opposite of tilde)
  * New %patchlist and %sourcelist spec sections
  * New %{expr:...} built-in macro for evaluating expressions
  * New %dnl macro primitive for comments
  * Support for non-privileged chroot operations (experimental)
  * Native support for Lua 5.2-5.3 without compat defines in Lua
  * String data is returned as surrogate-escaped utf-8 in Python 3 bindings
  * Numerous bugfixes and other enhancements all over the place

#### RPM 4.15.0 rc1 released! (Aug 28 2019)
* See [release notes](wiki/Releases/4.15.0) full details and download information
* Highlights since beta:
  * New %{expr:...} built-in macro for evaluating expressions
  * Several bugs and regressions (in 4.15.0 beta and otherwise) fixed

#### RPM 4.15.0 beta released! (Jun 26 2019)
* See [release notes](wiki/Releases/4.15.0) full details and download information
* Several bugs and regressions in 4.15.0 alpha fixed
* Highlights since alpha:
  * %dnl macro primitive for comments
  * Support for gcc -g3 level debuginfo
  * Ban unprintable ASCII control codes in filenames

#### RPM 4.15.0 alpha released! (Jun 5 2019)
* See [release notes](wiki/Releases/4.15.0) full details and download information
* Highlights include:
  * Faster builds on SMP systems
  * Support for dynamic build dependencies
  * Support for %elif, %elifos and %elifarch statements in spec
  * Caret version operator (the opposite of tilde)
  * New %patchlist and %sourcelist spec sections
  * Support for non-privileged chroot operations (experimental)
  * Native support for Lua 5.2-5.3 without compat defines in Lua
  * String data is returned as surrogate-escaped utf-8 in Python 3 bindings
  * Numerous bugfixes and other enhancements all over the place

#### RPM 4.14.2.1 released! (Oct 22 2018)
* Critical security bugfix for --setperms and --setugids regression in 4.14.2
* See [release notes](wiki/Releases/4.14.2.1) for details and download information

#### RPM 4.14.2 released! (Aug 21 2018)
* Support for enforcing signature policy and payload verification
* Numerous bugfixes and minor enhancements across the board
* See [release notes](wiki/Releases/4.14.2) for details and download information

#### RPM 4.14.2-rc2 released! (Aug 08 2018)
* Fixes to various minor resource leaks and other misc bugfixes since rc1
* See [release notes](wiki/Releases/4.14.2) for details and download information

#### RPM 4.14.2-rc1 released! (Jun 29 2018)
* Support for enforcing signature policy and payload verification
* Numerous bugfixes and minor enhancements across the board
* See [release notes](wiki/Releases/4.14.2) for details and download information

#### RPM 4.13.1 released! (Mar 28 2018)
* See [release notes](wiki/Releases/4.13.1) for details and download information
* This release is primarily about file trigger bugfixes and with/without/unless rich dependency backport

#### RPM 4.14.1 released! (Jan 16 2018)
* See [release notes](wiki/Releases/4.14.1) for details and download information
* This is primarily a bug fix release, with a few minor enhancements as well

#### RPM 4.13.0.2 released! (Oct 26 2017)
* See [release notes](wiki/Releases/4.13.0.2) for details and download information
* This is a security and bug fix update

#### RPM 4.14.0 released! (Oct 12 2017)
* See [release notes](wiki/Releases/4.14.0) for details and download information
* Highlights include:
  * Major revamp of debuginfo packages
  * Major macro engine changes to sanitize and improve the "language"
  * Major rewrite of package/header reading and signature checking to utilize a single codepath
  * New SHA256 digests in packages: one for compressed payload alone and one for the header
  * Weak dependencies are taken into account when ordering
  * Support for a configurable mode to conserve SSD disks
  * Support for 'with', 'without' and 'unless' rich dependencies
  * Support for zstd compression
  * Experimental support for LMDB database backend
  * Restrict symlink following on installation (CVE-2017-7500, CVE-2017-7501)
  * Many bugfixes and enhancements all over the place

#### RPM 4.14.0 RC2 released! (Sep 28 2017)
* See [release notes](wiki/Releases/4.14.0) for details and download information
* Highlights since RC1:
  * Two symlink following related security bugs (CVE-2017-7500, CVE-2017-7501)
  * Fix a bug of file triggers failing on some packages
  * Fix a package generation regression on 32bit architectures with packages
    over 2GB in size (introduced in 4.14.0 alpha)

#### RPM 4.14.0 RC1 released! (Sep 06 2017)
* See [release notes](wiki/Releases/4.14.0) for details and download information
* Highlights since alpha:
  * Support for 'unless' rich dependencies
  * Ensure header is present in callback events
  * Macro argument quoting changed to be much more compatible
  * Experimental LMDB backend
  * Misc bugfixes and minor enhancements

#### RPM 4.14.0 alpha released! (Thu Aug 2017)
* See [release notes](wiki/Releases/4.14.0) for details and download information* Highlights include:
  * Major revamp of debuginfo packages
  * Major macro engine changes to sanitize and improve the "language"
  * Major rewrite of package/header reading and signature checking to utilize a single codepath
  * A configurable mode to conserve SSD disks
  * Weak dependencies are taken into account when ordering
  * Support for with/without rich dependencies
  * New SHA256 digests in packages: one for compressed payload alone and one for the header
  * Many bugfixes and enhancements all over the place 

#### RPM 4.13.0.1 released! (Feb 16 2017)
* See [release notes](wiki/Releases/4.13.0.1) for details and download information
* This is a security and regression fix update

#### RPM 4.13.0 released! (Nov 03 2016)
* See [release notes]( wiki/Releases/4.13.0) for details and download information
* Major new features include:
  * File triggers
  * Boolean dependencies
* Numerous other enhancements and bugfixes

#### RPM 4.12.0.2 released! (Nov 03 2016)
* See [release notes]( wiki/Releases/4.12.0.2) for details and download information
* This is a security and regression fix update

#### RPM 4.13.0-rc2 released! (October 20th 2016) ####
 * Numerous bugfixes and minor enhancements across the board
 * Support for debuginfo compression and minidebuginfo
 * See [the original announcement](http://lists.rpm.org/pipermail/rpm-maint/2016-October/004620.html) for full details of what has changed since rc1
 * See [draft release notes](wiki/Releases/4.13.0) for download information and full details of changes since 4.12.0.1

#### RPM 4.13.0-rc1 released! (September 2nd 2015) ####
 * Finalized syntax for [Rich Dependencies](user_doc/boolean_dependencies.html)
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

#### RPM moves to GitHub (Mar 24th 2016) ####
 * RPM git master repo moved from rpm.org to GitHub

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
 * [Original announcement](http://lists.rpm.org/pipermail/rpm-announce/2008-April/000003.html) (with incorrect tarball url, duh)


#### RPM development switches to GIT (Mar 31th 2008) ####

 * Rpm code repository has been converted from Mercurial to GIT, effective immediately. Access details are documented on [wiki/GetSource] page.

#### RPM 4.4.2.3 release candidate 1 out for testing (Jan 25th 2008) ####

 * Dozens of bugfixes and minor improvements all around
 * [Original announcement](http://lists.rpm.org/pipermail/rpm-maint/2008-January/000737.html)

#### RPM 4.4.2.2 released! (Oct 3rd 2007) ####

 * Dozens of bugfixes and minor improvements all around
 * [Summary of changes](wiki/Releases/4.4.2.2)
 * [Original announcement](http://lists.rpm.org/pipermail/rpm-maint/2007-October/000546.html)

#### RPM 4.4.2.1 released! (Jul 23rd 2007) ####

 * Dozens of bugfixes and minor improvements all around
 * Cleaning up of vendor specific hacks etc
 * [Summary of changes](wiki/Releases/4.4.2.1)
 * [Original announcement](http://lists.rpm.org/pipermail/rpm-announce/2007-July/000001.html)

#### rpm.org reboot (Dec 14th 2006) ####

 * [Original announcement](http://lists.rpm.org/pipermail/rpm-announce/2006-December/000005.html)

#### RPM 4.4.2 released (Jul 21st 2005 ??) ####

 * [rpm-4.4.2.tar.gz](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-4.4.x/rpm-4.4.2.tar.gz)

#### RPM 4.4.1 released (??) ####

 * rpm-4.4.1.tar.gz missing

#### RPM 4.4 released (??) ####

 * rpm-4.4.tar.gz missing

#### RPM 4.3.3 released (Nov 2 2005 ??) ####

 * [rpm-4.3.3.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-4.3.x/rpm-4.3.3.tar.gz)

#### RPM 4.2.3 released (Sep 2004 ??) ####

 * rpm-4.2.3.tar.gz missing

#### RPM 4.3.2 released (Sep 17 2004 ??) ####

 * rpm-4.3.2.tar.gz missing

#### RPM 4.3.1 released (Apr 16 2004 ??) ####

 * rpm-4.3.1.tar.gz missing

#### RPM 4.2.2 released (Mar 24 2004 ??) ####

 * rpm-4.2.2.tar.gz missing

#### RPM 4.3 released (Jan 26 2004 ??) ####

 * rpm-4.3.tar.gz missing

#### RPM 4.2.1 released (Sep 25 2003 ??) ####

 * rpm-4.2.1.tar.gz missing

#### Red Hat Linux RPM Guide book published (May 23 2003) ####

#### RPM 4.2 released (Mar 19 2003 ??) ####

 * rpm-4.2.tar.gz missing

#### RPM 4.1 released (Sep 17 2002 ??) ####

 * [rpm-4.1.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-4.1.x/rpm-4.1.tar.gz)

#### RPM 4.0.4 released (Mar 14 2002 ??) ####

 * [rpm-4.0.4.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-4.0.x/rpm-4.0.4.tar.gz)

#### RPM 4.0.3 released (Dec 3 2001 ??) ####

 * [rpm-4.0.3.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-4.0.x/rpm-4.0.3.tar.gz)

#### RPM specified as the LSB packaging format (Jun 29 2001) ####
 * [Linux Standard Base 1.0](http://refspecs.linuxfoundation.org/LSB_1.0.0/gLSB/book1.html) included RPM as the standard packaging format.
   Unfortunately this only covered RPM v3 packages.

#### RPM 4.0.2 released (Mar 13 2001 ??) ####

 * [rpm-4.0.2.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-4.0.x/rpm-4.0.2.tar.gz)

#### RPM 4.0.1 released (Jan 18 2001 ??) ####

 * [rpm-4.0.1.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-4.0.x/rpm-4.0.1.tar.gz)

#### RPM 4.0 released (Sep 13 2000 ??) ####

 * [rpm-4.0.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-4.0.x/rpm-4.0.tar.gz)

#### RPM 3.0.6 released (Sep 13 2000 ??) ####

 * [rpm-3.0.6.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-3.0.x/rpm-3.0.6.tar.gz)

#### RPM 3.0.5 released (Jul 20 2000 ??) ####

 * [rpm-3.0.5.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-3.0.x/rpm-3.0.5.tar.gz)

#### RPM 3.0.4 released (Mar 16 2000 ??) ####

 * [rpm-3.0.4.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-3.0.x/rpm-3.0.4.tar.gz)

#### RPM renamed (Jan 17 2000) ####

 * Originally known as Red Hat Package Manager, RPM was renamed to the
   more generic recursive acronym of RPM Package Manager.

#### RPM 3.0.3 released (Oct 6 1999 ??) ####

 * [rpm-3.0.3.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-3.0.x/rpm-3.0.3.tar.gz)

#### RPM 3.0.2 released (Jul 7 1999 ??) ####

 * [rpm-3.0.2.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-3.0.x/rpm-3.0.2.tar.gz)

#### RPM 3.0.1 released (May 24 1999 ??) ####

 * [rpm-3.0.1.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-3.0.x/rpm-3.0.1.tar.gz)

#### RPM 3.0 released (Apr 19 1999 ??) ####

 * [rpm-3.0.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-3.0.x/rpm-3.0.tar.gz)

#### RPM 2.5.6 released (Dec 29 1998 ??) ####

 * [rpm-2.5.6.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.5.x/rpm-2.5.6.tar.gz)

#### RPM 2.5.5 released (Oct 15 1998 ??) ####

 * [rpm-2.5.5.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.5.x/rpm-2.5.5.tar.gz)

#### RPM 2.5.4 released (Sep 30 1998 ??) ####

 * [rpm-2.5.4.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.5.x/rpm-2.5.4.tar.gz)

#### RPM 2.5.3 released (Sep 5 1998 ??) ####

 * [rpm-2.5.3.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.5.x/rpm-2.5.3.tar.gz)

#### RPM 2.5.2 released (Jul 1 1998 ??) ####

 * [rpm-2.5.2.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.5.x/rpm-2.5.2.tar.gz)

#### RPM 2.5.1 released (May 28 1998 ??) ####

 * [rpm-2.5.1.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.5.x/rpm-2.5.1.tar.gz)

#### RPM 2.5 released (May 15 1998 ??) ####

 * [rpm-2.5.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.5.x/rpm-2.5.tar.gz)

#### RPM 2.4.12 released (Jan 8 1998 ??) ####

 * [rpm-2.4.12.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.4.x/rpm-2.4.12.tar.gz)

#### RPM 2.4.11 released (Dec 30 1997 ??) ####

 * [rpm-2.4.11.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.4.x/rpm-2.4.11.tar.gz)

#### RPM 2.4.10 released (Oct 31 1997 ??) ####

 * [rpm-2.4.10.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.4.x/rpm-2.4.10.tar.gz)

#### RPM 2.4.9 released (Oct 28 1997 ??) ####

 * [rpm-2.4.9.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.4.x/rpm-2.4.9.tar.gz)

#### RPM 2.4.8 released (Oct 10 1997 ??) ####

 * [rpm-2.4.8.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.4.x/rpm-2.4.8.tar.gz)

#### RPM 2.4.7 released (Sep 12 1997 ??) ####

 * [rpm-2.4.7.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.4.x/rpm-2.4.7.tar.gz)

#### RPM 2.4.6 released (Aug 29 1997 ??) ####

 * [rpm-2.4.6.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.4.x/rpm-2.4.6.tar.gz)

#### RPM 2.4.5 released (Aug 26 1997 ??) ####

 * [rpm-2.4.5.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.4.x/rpm-2.4.5.tar.gz)

#### RPM 2.4.4 released (Aug 21 1997 ??) ####

 * [rpm-2.4.4.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.4.x/rpm-2.4.4.tar.gz)

#### License change to dual GPL/LGPL (Aug 10th 1997) ####

 * RPM was originally GPL-only, but was [relicensed](https://github.com/rpm-software-management/rpm/commit/3a7e18a373b51458a1094bd6e3026ccea35efdc0)
   to GPL/LGPL early on.

#### Maximum RPM book published (Aug 6 1997) ####

#### RPM 2.4.3 released (Jul 16 1997 ??) ####

 * [rpm-2.4.3.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.4.x/rpm-2.4.3.tar.gz)

#### RPM 2.4.2 released (Jun 28 1997 ??) ####

 * [rpm-2.4.2.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.4.x/rpm-2.4.2.tar.gz)

#### RPM 2.4.1 released (May 27 1997 ??) ####

 * [rpm-2.4.1.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.4.x/rpm-2.4.1.tar.gz)

#### RPM 2.4 released (May 16 1997 ??) ####

 * [rpm-2.4.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.4.x/rpm-2.4.tar.gz)

#### RPM 2.3.11 released (Apr 24 1997 ??) ####

 * [rpm-2.3.11.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.3.x/rpm-2.3.11.tar.gz)

#### RPM 2.3.10 released (Apr 16 1997 ??) ####

 * [rpm-2.3.10.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.3.x/rpm-2.3.10.tar.gz)

#### RPM 2.3.9 released (Apr 8 1997 ??) ####

 * [rpm-2.3.9.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.3.x/rpm-2.3.9.tar.gz)

#### RPM 2.3.8 released (Mar 20 1997 ??) ####

 * [rpm-2.3.8.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.3.x/rpm-2.3.8.tar.gz)

#### RPM 2.3.7 released (Feb 20 1997 ??) ####

 * [rpm-2.3.7.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.3.x/rpm-2.3.7.tar.gz)

#### RPM 2.3.6 released (Feb 17 1997 ??) ####

 * [rpm-2.3.6.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.3.x/rpm-2.3.6.tar.gz)

#### RPM 2.3.5 released (Feb 14 1997 ??) ####

 * [rpm-2.3.5.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.3.x/rpm-2.3.5.tar.gz)

#### RPM 2.3.4 released (Jan 31 1997 ??) ####

 * [rpm-2.3.4.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.3.x/rpm-2.3.4.tar.gz)

#### RPM 2.3.3 released (Jan 24 1997 ??) ####

 * [rpm-2.3.3.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.3.x/rpm-2.3.3.tar.gz)

#### RPM 2.3.2 released (Jan 16 1997 ??) ####

 * [rpm-2.3.2.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.3.x/rpm-2.3.2.tar.gz)

#### RPM 2.3.1 released (Jan 15 1997 ??) ####

 * [rpm-2.3.1.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.3.x/rpm-2.3.1.tar.gz)

#### RPM 2.3 released (Dec 26 1996 ??) ####

 * [rpm-2.3.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.3.x/rpm-2.3.tar.gz)

#### RPM 2.2.11 released (Dec 20 1996 ??) ####

 * [rpm-2.2.11.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.2.x/rpm-2.2.11.tar.gz)

#### RPM 2.2.10 released (Dec 12 1996 ??) ####

 * [rpm-2.2.10.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.2.x/rpm-2.2.10.tar.gz)

#### RPM 2.2.9 released (Nov 22 1996 ??) ####

 * [rpm-2.2.9.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.2.x/rpm-2.2.9.tar.gz)

#### RPM 2.2.8 released (Oct 31 1996 ??) ####

 * [rpm-2.2.8.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.2.x/rpm-2.2.8.tar.gz)

#### RPM 2.2.7 released (Oct 17 1996 ??) ####

 * [rpm-2.2.7.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.2.x/rpm-2.2.7.tar.gz)

#### RPM 2.2.6 released (Sep 20 1996 ??) ####

 * [rpm-2.2.6.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.2.x/rpm-2.2.6.tar.gz)

#### RPM 2.2.5 released (Sep 02 1996 ??) ####

 * [rpm-2.2.5.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.2.x/rpm-2.2.5.tar.gz)

#### RPM 2.2.4 released (Aug 20 1996 ??) ####

 * [rpm-2.2.4.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.2.x/rpm-2.2.4.tar.gz)

#### RPM 2.2.3 released (Aug 08 1996 ??) ####

 * rpm-2.2.3.tar.gz missing

#### RPM 2.2.2 released (Jul 23 1996 ??) ####

 * [rpm-2.2.2.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.2.x/rpm-2.2.2.tar.gz)

#### RPM 2.2.1 released (Jul 17 1996 ??) ####

 * [rpm-2.2.1.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.2.x/rpm-2.2.1.tar.gz)

#### RPM 2.2 released (Jul 16 1996 ??) ####

 * [rpm-2.2.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.2.x/rpm-2.2.tar.gz)

#### RPM 2.1.2 released (Jul 12 1996 ??) ####

 * [rpm-2.1.2.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.1.x/rpm-2.1.2.tar.gz)

#### RPM 2.1.1 released (Jul 11 1996 ??) ####

 * [rpm-2.1.1.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.1.x/rpm-2.1.1.tar.gz)

#### RPM 2.1 released (Jul 10 1996 ??) ####

 * [rpm-2.1.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.1.x/rpm-2.1.tar.gz)

#### RPM 2.0.11 released (Jun 05 1996 ??) ####

 * [rpm-2.0.11.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.0.x/rpm-2.0.11.tar.gz)

#### RPM 2.0.10 released (Jun 04 1996 ??) ####

 * [rpm-2.0.10.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.0.x/rpm-2.0.10.tar.gz)

#### RPM 2.0.9 released (May 23 1996 ??) ####

 * [rpm-2.0.9.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.0.x/rpm-2.0.9.tar.gz)

#### RPM 2.0.8 released (May 07 1996 ??) ####

 * [rpm-2.0.8.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.0.x/rpm-2.0.8.tar.gz)

#### RPM 2.0.7 released (April 15 1996 ??) ####

 * [rpm-2.0.7.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.0.x/rpm-2.0.7.tar.gz)

#### RPM 2.0.6 released (April 08 1996 ??) ####

 * [rpm-2.0.6.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.0.x/rpm-2.0.6.tar.gz)

#### RPM 2.0.5 released (April 03 1996 ??) ####

 * [rpm-2.0.5.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.0.x/rpm-2.0.5.tar.gz)

#### RPM 2.0.4 released (Mar 30th 1996) ####

 * [rpm-2.0.4.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.0.x/rpm-2.0.4.tar.gz)

#### RPM 2.0.3 released (Mar 26th 1996) ####

 * [rpm-2.0.3.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.0.x/rpm-2.0.3.tar.gz)

#### RPM 2.0.2 released (Mar 15th 1996) ####

 * [rpm-2.0.2.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.0.x/rpm-2.0.2.tar.gz)

#### RPM 2.0.1 released (Mar 13th 1996) ####

 * [rpm-2.0.1.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.0.x/rpm-2.0.1.tar.gz)

#### RPM 2.0 released (Mar 5th 1996) ####

 * [rpm-2.0.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-2.0.x/rpm-2.0.tar.gz)
 * This is the first version entirely in C

#### RPM 1.4.7 released (Feb 8th 1996) ####

 * [rpm-1.4.7.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-1.x/rpm-1.4.7.tar.gz)

#### RPM 1.4.6 released (Dec 18th 1995) ####

 * [rpm-1.4.6.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-1.x/rpm-1.4.6.tar.gz)

#### RPM 1.4.5 released (Nov 30th 1995) ####

 * [rpm-1.4.5.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-1.x/rpm-1.4.5.tar.gz)

#### RPM 1.4.4 released (Nov 27th 1995) ####

 * [rpm-1.4.4.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-1.x/rpm-1.4.4.tar.gz)

#### First commit (Nov 27th 1995) ####

 * [The first commit of RPM in C](https://github.com/rpm-software-management/rpm/commit/7153c160969d70a083f791bf75f9b4d09d2f2a45)
   to what was a state-of-the art CVS repository back then. Whether this
   was done by Marc Ewing or Erik Troan is lost in history as the
   commit was done as root - those were the days...
#### RPM 1.4.2a released (Nov 24th 1995) ####

 * [rpm-1.4.2a.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-1.x/rpm-1.4.2a.tar.gz)

#### RPM 1.4.2 released (Nov 20th 1995) ####

 * [rpm-1.4.2.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-1.x/rpm-1.4.2.tar.gz)

#### RPM 1.4.1 released (Nov 3rd 1995) ####

 * [rpm-1.4.1.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-1.x/rpm-1.4.1.tar.gz)

#### RPM 1.4 released (Oct 24th 1995) ####

 * [rpm-1.4.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-1.x/rpm-1.4.tar.gz)

#### RPM 1.3.1 released (Oct 1995) ####

 * [rpm-1.3.1.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-1.x/rpm-1.3.1.tar.gz)

#### RPM 1.3 released (Oct 1995) ####

 * [rpm-1.3.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-1.x/rpm-1.3.tar.gz)

#### RPM 1.2 released (Sep 1995) ####

 * [rpm-1.2.tar.gz download](https://ftp.osuosl.org/pub/rpm/releases/historical/rpm-1.x/rpm-1.2.tar.gz)

