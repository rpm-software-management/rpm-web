---
layout: default
title: rpm.org - Roadmap
---

# RPM Roadmap

## 2023
* Bugfix release for 4.18 (Q1)
* RPM 4.19 release (Q3)
  * Build infra modernization
    * [CMake based build system](https://github.com/rpm-software-management/rpm/pull/2096)
    * [Replace fakechroot with better technology](https://github.com/rpm-software-management/rpm/issues/1580)
    * [Migrate away from SemaphoreCI Classic](https://github.com/rpm-software-management/rpm/issues/2569)
  * Hands-free packaging
    * [Dynamic spec generation](https://github.com/rpm-software-management/rpm/discussions/2032)
    * [Declarative user/group handling](https://github.com/rpm-software-management/rpm/issues/1032)
    * [Resource management for parallel builds](https://github.com/rpm-software-management/rpm/issues/804)
  * [Deprecate internal OpenPGP parser](https://github.com/rpm-software-management/rpm/issues/1935)
  * [Purge obsolete API](https://github.com/rpm-software-management/rpm/issues/1989)
* RPM v6 scoping (ongoing)
  * First [public draft of RPM v6 format](https://github.com/rpm-software-management/rpm/discussions/2374)

## 2024
* RPM 4.20 release (Q3)
  * Hands-free packaging
    * Dynamic spec generation continued
    * [Declarative build system](https://github.com/rpm-software-management/rpm/issues/1087)
  * RPM v6 readiness
    * [Support for RPM v3 packages removed](https://github.com/rpm-software-management/rpm/issues/1107)
    * [Support for multi-arch dependencies](https://github.com/rpm-software-management/rpm/issues/2197)
    * [File trigger design review + adjustment](https://github.com/rpm-software-management/rpm/issues/2655)
  * [Finalize plugin API, make public](https://github.com/rpm-software-management/rpm/issues/1536)
* RPM v6 specification

## 2025
* RPM 6.0 release (Q3)
  * Package format facelift
  * Hands-free packaging

For further information and feedback, head over to our [discussion forum.](https://github.com/rpm-software-management/rpm/discussions/2015)
