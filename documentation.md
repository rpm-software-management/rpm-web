---
layout: default
title: Documentation
---
# Documentation
This page attempts to track the various relevant documentation that exists for RPM.

## User Documentation
* [RPM Tutorial](http://fedoranews.org/alex/tutorial/rpm/)
* [Fedora RPM Guide](http://docs.fedoraproject.org/en-US/Fedora_Draft_Documentation/0.1/html/RPM_Guide/index.html)
* In wiki:
  * [RPM Frequently asked questions (FAQ)](user_doc/faq.html)
  * [RPM Database Recovery](user_doc/db_recovery.html)
  * [RPM Query Formats](user_doc/query_format.html) 

## Packager Documentation
* [Fedora RPM Guide](http://docs.fedoraproject.org/en-US/Fedora_Draft_Documentation/0.1/html/RPM_Guide/index.html)
* In wiki:
  * [Conditional Builds (rpmbuild &#8211;&#8211;with/&#8211;&#8211;without)](packager_doc/conditional_builds.html)
  * [Dependencies](packager_doc/dependencies.html)
  * [More on Dependencies](packager_doc/more_dependencies.html)
  * [Dependency Generators](packager_doc/dependency_generators.html) (new in 4.9)
  * [Automated, VCS integrated patch application](packager_doc/autosetup.html) (new in 4.11)
  * [Macros](packager_doc/macros.html)
  * [Embedded Lua interpreter](packager_doc/lua.html)
  * [Runtime scriptlet expansion (new in 4.9)](packager_doc/scriptlet_expansion.html)
  * [Building Packages so that multiple versions of the same package can co-install](packager_doc/multiple_versions.html)

## RPM Language Bindings Documentation
* [RPM Python](http://www.ukuug.org/events/linux2004/programme/paper-PNasrat-1/rpm-python-slides/frames.html) slideset / tutorial
* [Programming RPM with Python](http://docs.fedoraproject.org/en-US/Fedora_Draft_Documentation/0.1/html/RPM_Guide/ch-rpm-programming-python.html) from Fedora RPM Guide
* [Programming RPM with Perl](http://docs.fedoraproject.org/en-US/Fedora_Draft_Documentation/0.1/html/RPM_Guide/ch-programming-perl.html) from Fedora RPM Guide 

## Developer Documentation
* [Programming RPM with C](http://docs.fedoraproject.org/en-US/Fedora_Draft_Documentation/0.1/html/RPM_Guide/ch-programming-c.html) from Fedora RPM Guide

* [Plugin Interface (RPM >= 4.12)](devel_doc/plugins.html)
* [Release maintaince](devel_doc/release_maintaince.html)

* Miscellaneous docs in wiki:
  * [How to ensure Large File Support for tools using the rpm API](devel_doc/large_files.html)
  * [Description of RPM internal state machines](devel_doc/state_machines.html)
  * [Description of RPM file format](devel_doc/file_format.html)

## Books
The following books have been published regarding RPM:

* **Maximum RPM** A book written by Ed Bailey. It is available in hardback (442 pages), and has recently been re-printed by Sams in soft-cover (450 pages - ISBN: 0672311054). The hardcover edition includes a quick reference card. An on-line version of the original book is also available, and a more up to date, work in progress version can be found [here](max-rpm-snapshot). 
* **Red Hat RPM** Guide A more recent book by Eric Foster-Johnson, this has recently been released under the Open Publication License and a draft close to the published version is available on-line as [Fedora RPM Guide](http://docs.fedoraproject.org/en-US/Fedora_Draft_Documentation/0.1/html/RPM_Guide/index.html). This book covers everything from basic usage to advanced tricks, package creation and API programming. Participation in updating the Guide can be done via the [Fedora Documentation Project](http://fedoraproject.org/wiki/DocsProject). Discussions about moving this content and work upstream to rpm.org can occur on [fedora-docs-list](http://www.redhat.com/mailman/listinfo/fedora-docs-list). 

## Other Resources
* [Software related to rpm](software.html)
