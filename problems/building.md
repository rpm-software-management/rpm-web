---
layout: default
title: Problems of building
---
One level up: [Contribute](../contribute.html)

# Problems of building

When building packages and writing spec files, packager often meet with spec file or rpm limits.

## Conflicting packages

RPM is not able to create two conflicting packages from a single spec file. It is sometimes useful for creating of two similar packages.

Why:
: Only one build root can be specified.

Work-arounds:
: More nearly equal spec files.

Proposed solutions:
: Evaluate BuildRoot? tag for subpackages.

## Rule based subpackages

Rule based subpackages could save a lot of packagers time while splitting packages and prevent inconsistencies.

Examples:
: Make possible rule based splitting of -devel packages, -doc package, splitting -lang subpackages per-language). 

Why:
: Static definition of subpackages need a lot of manual work and does not allow simple change of rules.

Work-arounds:
: * Do everything manually.
  * Do this using helpers on top of large intermediate binary packages. 

Proposed solution:
: * Design a method for rule based definition of subpackages:

  * Allow to define directories and patterns, which should be packaged into subpackage (e. g.: %{_includedir}/* => %{name}-devel, %{datadir}/gtk-doc/html/* => %{name}-develdoc) 

  * Allow to define directories and patterns, where each file or fileset should be packaged as a separate subpackage (e. g. %{_libdir}/gstreamer-0.10/libgst{pattern}.so => gstreamer_0-10-plugin-{pattern}). 

  * Allow to define summary, description and possible rule exceptions for upper mentioned rules. 

  * Such rules exist for example in OpenEmbedded build system (docs).

## Directory ownership

RPM has a concept of a directory ownership by a package. If the package is going to be removed, owned directory should disappear. But it does not work as expected.

Examples:
: Any package providing directorie for third party additions.

Why:
: There is no way to enforce this concept. Package can be removed, even if owned directory is not empty and there are no other owners of this directory.

Work-arounds:
: Keeping orphans. Adding crazy logic into %postun scripts. SuSE QA scripts (far from being complete).

Proposed solution:
: RPM AutoReqProv changes with introduction of Requires(files) (optional stronger than Requires, but less stronger than PreReq? - packages which need to be present to perform placing of new files) and a lot of QA.

## No easy way to add generated provides/requires

There is no easy way to add auto-generated provides.

Why:
: One needs to redefine standard __find_provides and __find_requires.

Proposed solution:
: Small modification of supporting scripts, which would allow to make simple additions or exclusion from the standard AutoReqProv.

# Generated preamble values

There is no way to auto generate preamble values (e.g. BuildRequires, Summary, %description). Even if build result could cleanly indicate the change needed it provides no way, how to incorporate it back to the spec file.

Why:
: Many current tools provide a clean way to identify missing package (pkg-config, embedded spec file).

Work-arounds:
: * Manual editing 

  * Ugly %(bzcat %{S:0} ... ) constructs 

Proposed solution:
: Design a way, how build process can provide preamble changes


