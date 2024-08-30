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

#### RPM 4.20.0 RC1 released (Aug 30 2024)
* See [draft release notes](wiki/Releases/4.20.0) for details and download information
* This release is about the finishing touches for the major features and
  various other fixes, mostly regarding the declarative buildsystem,
  `--build-in-place` compatibility with the new build directory layout,
  debuginfo generation and error reporting

#### RPM 4.20.0 BETA1 released (Jun 24 2024)
* See [draft release notes](wiki/Releases/4.20.0) for details and download information
* This is all about bugs, alpha regressions and spec backwards compatibility,
  in particular regarding the new debuginfo enablement and %builddir
  related issues

#### RPM 4.20.0 ALPHA2 released (May 20 2024)
* This is another alpha snapshot that addresses a couple of bugs found in the first one, most notably the faulty interaction between the scriptlet [prepend/append](https://rpm-software-management.github.io/rpm/manual/spec.html#build-scriptlets) options and the `BuildSystem` tag ([#3024](https://github.com/rpm-software-management/rpm/issues/3024)) which affected the users test-driving the new [Declarative buildsystem](https://rpm-software-management.github.io/rpm/manual/buildsystem.html) feature.
* Two new features are also being introduced in this snapshot:
    * Proper, built-in debuginfo enablement logic ([#2204](https://github.com/rpm-software-management/rpm/issues/2204))
    * Support for a [timestamp handling policy](https://rpm-software-management.github.io/rpm/manual/buildprocess.html#reproducability), exposed via the new `%build_mtime_policy` macro
* See [draft release notes](wiki/Releases/4.20.0) for details and download information

#### RPM 4.20.0 ALPHA released (Apr 05 2024)
* See [draft release notes](wiki/Releases/4.20.0) for details and download information
* Highlights include:
    * [Declarative buildsystem](https://rpm-software-management.github.io/rpm/manual/buildsystem.html) support ([#1087](https://github.com/rpm-software-management/rpm/issues/1087))
    * Dynamic SPEC generation extended
    * Guaranteed per-build directory ([#2078](https://github.com/rpm-software-management/rpm/issues/2078))
    * Support for [SPEC-local](https://rpm-software-management.github.io/rpm/manual/dependency_generators.html#using-file-attributes-in-their-own-package) file attributes and generators ([#782](https://github.com/rpm-software-management/rpm/issues/782))
    * New prepend and append [modes](https://rpm-software-management.github.io/rpm/manual/spec.html#build-scriptlets) for build scriptlets
    * Python bindings have been ported to the stable ABI ([#2345](https://github.com/rpm-software-management/rpm/issues/2345))
    * Plugin API is now public ([#1536](https://github.com/rpm-software-management/rpm/issues/1536))
    * Increased isolation of install scriptlets on Linux via a new plugin ([#2632](https://github.com/rpm-software-management/rpm/issues/2632), [#2665](https://github.com/rpm-software-management/rpm/issues/2665))
    * File trigger scripts now also receive package count arguments ([#2755](https://github.com/rpm-software-management/rpm/issues/2755))
    * Perl dependency generators have been split out ([#2873](https://github.com/rpm-software-management/rpm/issues/2873))
    * Internal OpenPGP parser has been removed ([#2414](https://github.com/rpm-software-management/rpm/issues/2414))

#### RPM 4.19.1.1 released (Feb 07 2024)
* This is a bug fix only release addressing a number of regressions, memory
  leaks and build system issues.
* See [release notes](wiki/Releases/4.19.1.1) for details and download information

#### RPM 4.19.1 released (Dec 12 2023)
* This is a bug fix release with a few minor enhancements.
* See [release notes](wiki/Releases/4.19.1) for details and download information
* Highlights include:
    * Add `%_iconsdir` macro ([#2729](https://github.com/rpm-software-management/rpm/pull/2729))
    * Add a Provides generator for rpm lua modules ([#2659](https://github.com/rpm-software-management/rpm/pull/2659))
    * Allow `SOURCE_DATE_EPOCH=0` again ([#2756](https://github.com/rpm-software-management/rpm/pull/2756))
    * Bunch of `sysusers.d` handling fixes ([#2745](https://github.com/rpm-software-management/rpm/pull/2745))
    * Fix integer overflow in memory calculations on 32bit systems ([#2770](https://github.com/rpm-software-management/rpm/pull/2770))

#### RPM 4.18.2 released (Nov 13 2023)
* This is a bug fix release with a few minor enhancements.
* See [release notes](wiki/Releases/4.18.2) for details and download information
* Highlights include:
    * New `%{rpmversion}` and `%{_iconsdir}` macros
    * New `rpmspec(8)` aliases for weak dependency queries
    * Add libmagic exceptions for HTML, SVG and PNG
    * Fix `SOURCE_DATE_EPOCH=0` regression
    * Fix various `rpm2archive(8)` issues
    * Fix various Lua interface issues
    * Various regression fixes
    * Numerous documentation fixes and improvements

#### RPM 4.19.0 released (Sep 19 2023)
* See [release notes](wiki/Releases/4.19.0) for details and download information
* Highlights include:
    * New spec snippet [support](https://rpm-software-management.github.io/rpm/manual/dynamic_specs.html) for dynamic spec generation
    * New `sysusers.d(5)` [integration](https://rpm-software-management.github.io/rpm/manual/users_and_groups.html) for automated user and group handling
    * Proper shell-like globbing and escaping in `%files` and CLI
    * Memory and address-space aware build resource allocation
    * Platform detection fixes and improvements for x86 CPUs
    * Chroot handling fixes
    * New CMake build system
    * Export of RPM libraries for CMake's `find_package()`
    * Adoption of Linux containers in the test-suite, replacing `fakechroot(1)`
    * New Python binding usage examples
    * Translations [split off](https://github.com/rpm-software-management/rpm-l10n/)
    * Removal of various deprecated and/or unused APIs
    * Various internal code cleanups

#### RPM 4.19.0 RC1 released (Sep 04 2023)
* This is a release candidate with minor enhancements and bug fixes since BETA.
* See [draft release notes](wiki/Releases/4.19.0) for details and download information
* Highlights include:
    * New `rpmspec` aliases for weak dependency queries
    * More consistent behavior with `%optflags` and noarch builds
    * Test-suite fixes and tweaks to the new container-based backend
    * Export our libraries as a CMake `find_package()` config
    * Default to C.UTF-8 locale in CMake
    * Other CMake fixes and tweaks

#### CI migrated from SemaphoreCI Classic to GitHub Actions (Aug 03 2023)
* Due to the planned [discontinuation](https://semaphoreci.com/blog/semaphore-classic-deprecation)
  of SemaphoreCI Classic starting in early September 2023, we have moved to
  GitHub Actions for our CI needs
  (see [#2569](https://github.com/rpm-software-management/rpm/issues/2569) for more details).

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

For older news, head over to [RPM timeline](timeline.html).
