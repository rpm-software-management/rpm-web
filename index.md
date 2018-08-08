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
