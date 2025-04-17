---
layout: default
title: rpm.org - Roadmap
---

# RPM Roadmap

## 2025
* RPM 6.0 release (Q3)
  * Introducing [RPM v6](https://github.com/rpm-software-management/rpm/discussions/2919) package format
  * Compatibility
    * v6 format is widely compatible with modern rpm 4.x versions
    * Can produce both v4 and v6 packages
    * Full support for v4 and v6 packages
    * Support for v3 format is dropped
  * Security
    * [Enforced signature-checking by default](https://github.com/rpm-software-management/rpm/issues/1573)
    * Legacy crypto algorithms disabled by default
    * Use full OpenPGP key fingerprints everywhere
    * Support for multiple signatures per package
  * Hand-free packaging
    * Automatic signing on package build
  * [Compiled with C++](https://github.com/rpm-software-management/rpm/discussions/2983)
    * Gradual transition towards C++ internally
    * C API will remain

## 2026
* RPM 6.1 release (Q3)
  * Hands-free packaging
    * Safe handling of internal soname dependencies
  * Transaction robustness
    * Restartable transactions
    * Improved ordering, delayed scriptlet execution
  * Containers
    * rpmdb rebuild on overlayfs

## 2027
* RPM 6.2 release (Q3)
  * Hands-free packaging
    * File-classifier based actions
  * Containers
    * Container-friendly alternative rpmdb format
  * First public C++ API (alongside the trad. C API)

For further information and feedback, head over to our [discussion forum.](https://github.com/rpm-software-management/rpm/discussions/2982)
