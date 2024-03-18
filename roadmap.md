---
layout: default
title: rpm.org - Roadmap
---

# RPM Roadmap

## 2024
* RPM 4.20 release (Q3)
  * Hands-free packaging
    * [Declarative build system](https://github.com/rpm-software-management/rpm/issues/1087)
    * Dynamic spec generation extended
    * [File trigger scriptlet arguments](https://github.com/rpm-software-management/rpm/issues/2655)
    * [Support for spec local dependency generators](https://github.com/rpm-software-management/rpm/issues/782)
  * [Public plugin API](https://github.com/rpm-software-management/rpm/issues/1536)
  * Security
    * Increased build and install scriptlet isolation
* RPM 4.19 bugfix release
* RPM v6 specification

## 2025
* RPM 6.0 release (Q3)
  * Introducing [RPM v6](https://github.com/rpm-software-management/rpm/discussions/2919) package format
  * Compatibility with 4.x
    * v6 format is widely compatible with modern rpm 4.x versions
    * Can produce both v4 and v6 packages
    * Full support for v4 and v6 packages
  * Security
    * [Enforced signature-checking by default](https://github.com/rpm-software-management/rpm/issues/1573)
    * Legacy crypto algorithms disabled by default
    * Use full OpenPGP key fingerprints everywhere
  * Hand-free packaging
    * Automatic signing on package build
  * Compiled with C++
    * Gradual transition towards C++ internally
    * C API will remain

## 2026
* RPM 6.1 release (Q3)
  * Hands-free packaging
    * Safe handling of internal soname dependencies
    * AI based file classification alternative
  * Improved transaction robustness
    * Restartable transactions
    * Improved ordering, delayed scriptlet execution
  * Containers
    * rpmdb rebuild on overlayfs

## 2027
* RPM 6.2 release (Q3)
  * Hands-free packaging
    * File-classifier based actions
  * Containers
  * First public C++ API (alongside the trad. C API)

For further information and feedback, head over to our [discussion forum.](https://github.com/rpm-software-management/rpm/discussions/)
