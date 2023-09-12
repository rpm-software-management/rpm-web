---
layout: default
title: rpm.org - Roadmap
---

# RPM Roadmap

## 2023
* Bugfix release for 4.18 (Q1)
* RPM 4.19 release (Q3)
  * Build infra modernization
    * CMake based build system
    * Replace fakechroot with better technology
  * Hands-free packaging
    * Dynamic spec generation
    * Declarative user/group handling
    * Resource management for parallel builds
  * Deprecate internal OpenPGP parser
  * Purge obsolete API
* RPM v6 scoping (ongoing)
* First [public draft of RPM v6 format](https://github.com/rpm-software-management/rpm/discussions/2374)
* Migrate away from SemaphoreCI Classic (Q3)

## 2024
* RPM 4.20 release (Q3)
  * Hands-free packaging
    * Dynamic spec generation continued
    * Declarative build system
  * RPM v6 readiness
    * Support for RPM v3 packages removed
    * Support for multi-arch packages
    * File trigger design review + adjustment
  * Finalize plugin API, make public
* RPM v6 specification

## 2025
* RPM 6.0 release (Q3)
  * Package format facelift
  * Hands-free packaging

For further information and feedback, head over to our [discussion forum.](https://github.com/rpm-software-management/rpm/discussions/2015)
