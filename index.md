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

#### RPM 6.0.0 ALPHA released (Apr 08 2025)
* See [release notes](releases/6.0.0) for details and download information
* Highlights include:
    * RPM defaults to enforcing signature checking ([#1573](https://github.com/rpm-software-management/rpm/issues/1573))
    * RPM uses the full key ID or fingerprint to identify OpenPGP keys everywhere ([#2403](https://github.com/rpm-software-management/rpm/issues/2403))
    * Support for multiple OpenPGP signatures per package ([#3385](https://github.com/rpm-software-management/rpm/issues/3385))
    * Support for updating previously imported keys ([#2577](https://github.com/rpm-software-management/rpm/issues/2577))
    * Support for both RPM v4 and v6 packages
    * Support for installing RPM v3 packages has been removed ([#1107](https://github.com/rpm-software-management/rpm/issues/1107))
    * By default, RPM no longer verifies obsolete crypto (MD5, SHA1, DSA) ([#1292](https://github.com/rpm-software-management/rpm/issues/1292))
    * Man page overhaul (work in progress as of 6.0 alpha)
    * Pristine and verifiable release tarballs ([#3565](https://github.com/rpm-software-management/rpm/issues/3565)) ([#2702](https://github.com/rpm-software-management/rpm/issues/2702))

#### RPM 4.20.1 released (Feb 19 2025)
* This is primarily a bugfix release addressing a handful of regressions in RPM 4.20.0 as well as various other issues.
* See [release notes](wiki/Releases/4.20.1) for details and download information
* Highlights include:
    * Support for fully locked user accounts in `sysusers.d(5)` files
    * Filter Lua deprecation warnings based on the originating RPM version
    * Fix regressions in `rpmsign(8)`, `rpmspec(8)`, `%debug_package` and more
    * Fix unmodified `%config` (and possibly other) files being removed in case of unpack failure
    * Fix IMA plugin causing transaction failures in rootless containers
    * Fix sqlite rpmdb growing over time

#### RPM 4.20.0 released (Oct 07 2024)
* See [release notes](wiki/Releases/4.20.0) for details and download information
* Highlights include:
    * [Declarative build system](https://rpm-software-management.github.io/rpm/manual/buildsystem.html) support
    * [Dynamic spec](https://rpm-software-management.github.io/rpm/manual/dynamic_specs.html) improvements
    * Guaranteed, RPM-controlled per-build directory
    * Support for [spec-local](https://rpm-software-management.github.io/rpm/manual/dependency_generators.html#using-file-attributes-in-their-own-package) file attributes and generators
    * Support for group membership in `sysusers.d(5)` files
    * Proper distro-agnostic debuginfo support
    * Sanitized spec comments and indentation syntax
    * Sanitized `--build-in-place` mode
    * New `unshare` plugin for scriptlet isolation
    * Plugin API made public

#### RPM 4.20.0 RC2 released (Sep 10 2024)
* See [draft release notes](wiki/Releases/4.20.0) for details and download information
* This release makes `%autosetup -C` also work with zip/7zip archives, fixes a
  long-standing bug in `%transfiletriggerpostun` where it only matched against
  the first listed prefix, and includes a handful of other small fixes

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

For older news, head over to [RPM timeline](timeline.html).
