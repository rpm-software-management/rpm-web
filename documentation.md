---
layout: default
title: rpm.org - Documentation
---
# Documentation
This page attempts to track the various relevant documentation that exists for RPM.

## General Use
* [RPM Tutorial](http://fedoranews.org/alex/tutorial/rpm/)
* [Fedora RPM Guide](http://docs.fedoraproject.org/en-US/Fedora_Draft_Documentation/0.1/html/RPM_Guide/index.html)
* On rpm.org:
  * [RPM Frequently asked questions (FAQ)](user_doc/faq.html)
  * [RPM Database Recovery](user_doc/db_recovery.html)
  * [RPM Query Formats](user_doc/query_format.html) 

## Packager Documentation
* [Fedora RPM Guide](http://docs.fedoraproject.org/en-US/Fedora_Draft_Documentation/0.1/html/RPM_Guide/index.html)
* On rpm.org:
  * [Conditional Builds (rpmbuild &#8211;&#8211;with/&#8211;&#8211;without)](user_doc/conditional_builds.html)
  * [Dependencies](user_doc/dependencies.html)
  * [More on Dependencies](user_doc/more_dependencies.html)
  * [Dependency Generators](user_doc/dependency_generators.html) (new in 4.9)
  * [Automated, VCS integrated patch application](user_doc/autosetup.html) (new in 4.11)
  * [Macros](user_doc/macros.html)
  * [Embedded Lua interpreter](user_doc/lua.html)
  * [Runtime scriptlet expansion (new in 4.9)](user_doc/scriptlet_expansion.html)
  * [Building Packages so that multiple versions of the same package can co-install](user_doc/multiple_versions.html)

## RPM API
* [Plugin Interface (RPM >= 4.12)](devel_doc/plugins.html)
* [Programming RPM with C](http://docs.fedoraproject.org/en-US/Fedora_Draft_Documentation/0.1/html/RPM_Guide/ch-programming-c.html) from Fedora RPM Guide
* [How to ensure Large File Support for tools using the rpm API](devel_doc/large_files.html)

## RPM Language Bindings
* [RPM Python](http://www.ukuug.org/events/linux2004/programme/paper-PNasrat-1/rpm-python-slides/frames.html) slideset / tutorial
* [Programming RPM with Python](http://docs.fedoraproject.org/en-US/Fedora_Draft_Documentation/0.1/html/RPM_Guide/ch-rpm-programming-python.html) from Fedora RPM Guide
* [Programming RPM with Perl](http://docs.fedoraproject.org/en-US/Fedora_Draft_Documentation/0.1/html/RPM_Guide/ch-programming-perl.html) from Fedora RPM Guide 


## Miscellaneous Developer Docs:
  * [Release maintaince](devel_doc/release_maintaince.html)
  * [Description of RPM internal state machines](devel_doc/state_machines.html)
  * [Description of RPM file format](devel_doc/file_format.html)

## Books
The following books have been published regarding RPM:

* **Maximum RPM** A book written by Ed Bailey. It is available in hardback (442 pages), and has recently been re-printed by Sams in soft-cover (450 pages - ISBN: 0672311054). The hardcover edition includes a quick reference card. An on-line version of the original book is also available, and a more up to date, work in progress version can be found [here](max-rpm-snapshot). 
* **Red Hat RPM** Guide A more recent book by Eric Foster-Johnson, this has recently been released under the Open Publication License and a draft close to the published version is available on-line as [Fedora RPM Guide](http://docs.fedoraproject.org/en-US/Fedora_Draft_Documentation/0.1/html/RPM_Guide/index.html). This book covers everything from basic usage to advanced tricks, package creation and API programming. Participation in updating the Guide can be done via the [Fedora Documentation Project](http://fedoraproject.org/wiki/DocsProject). Discussions about moving this content and work upstream to rpm.org can occur on [fedora-docs-list](http://www.redhat.com/mailman/listinfo/fedora-docs-list). 

## Other Resources
* [Software related to rpm](software.html)
