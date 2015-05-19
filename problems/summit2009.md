---
layout: default
title: RPM Summit at openSUSE Conference 2009
---
One level up: [Contribute](../contribute.html)

## RPM Summit
Rough list of ideas and topics that could be brought up on the RPM Summit:

### Talk: What's up in RPM developent
Talk by Florian Festi. Probably Friday morning (see conf schedule)

### General discussion about direction of RPM
* Major pain points
* What is upstream planning/considering?
* ... 

### File triggers
This feature is still under construction - Panu is working on it.

File triggers (name still subject to change) are scripts that take care of special file types. Scripts are only part of the package handling the file type (like glibc for all *.so files, fontconfig for all font files) but are invoked for all files that match a given criteria (file name reqex?).

###Soft requires
Tags for soft requires are still not upstream. May be work out a precise definition so other tools (yum comes to mind) can reimplement them in a compatible way. (see [http://en.opensuse.org/Software_Management/Dependencies](http://en.opensuse.org/Software_Management/Dependencies))

Seth Vidal would like to join the discussion by phone/VoIP. Technical details still to be figured out.

### libsatsolver, libzypp
* Current status
 * Compatibility (multilib)? 
* Possible base for yum (in the long term)?
 * Language bindings (Python)? 

### DeltaRPM
* Connection to RPM's codebase
 * new RPM features like file hashes, compression algorithms, ... 
* Binary diff algorithm for better compression? 

### update scriptlets
When a package is updated, rpm first runs the pre/postinstall scriptlets of the new package and afterwards the pre/postuninstall scriptlets of the old packages. This has the following disadvantages:

* inexperienced packagers don't expect it
* you have to add clumsy $0 tests to your scriptlets
* there's no way to fix bugs in the uninstall scriptlets 

We propose to add a new type of scriplets, called update scriptlets. If a package doesn't define an update scriptlet, the install/uninstall scriptlets will be run like before. If it defines a scriptlet and an old package gets replaced with a new package, the update scriptlets are called instead of the install scriptlets, and the uninstall scriptlets of the old package are not run.

TBD: called when? called with what argument?

TBD: I am not sure, whether not calling anything from the old instance is a good idea. It complicates the upgrade process in many cases - the new scriptlet may need file lists of all old versions. Also migration from %post/%postun to %postupgrade would be more complicated. Maybe %preup, %postup, %prenew, %postnew, %prerm, %postrm should be called in a similar way than the old scripts, but would be simpler to use and package-rename-wise. Blocking old scripts may be an independent feature.

### virtual triggers
Currently triggers only work with package names. We propose to change the code so that they also work with provides (a patch to rpm already exists). Using virtual triggers together with find-provides allows us to replace many scriptlets with trigger calls, removing a source of many packaging errors.

### package renaming
Currently rpm only counts the number of packages with the same name when it calculates the argument for scriptlets. This leads to problems when a package is renamed, because the scriptlets are told that the package is installed for the first time. Also, downgrading back to the old name doesn't work correctly as "Obsoletes" are evaluated in only one way.

### scriptlet arguments
Add a convenient way for scriptlet authors to find out which version of the package was installed before/obsoleted. Idea: put headerids in some ENV var, query with --querybynumber.

### Using tilde (~) in version
Michael suggested to use the tilde (~) in version numbers. Versions 1.3~foo comes just before 1.3. This feature could be (mis)used as a version separator in kernel packages. That solves the problem that 2.6.31_8.1.3 is newer than 2.6.31.1_8.1.3 (whereas 2.6.31~8.1.3 is older than 2.6.31.1~8.1.3). There is already a ticket for that: [http://rpm.org/ticket/56](http://rpm.org/ticket/56)

Also see [https://bugzilla.novell.com/show_bug.cgi?id=540558](https://bugzilla.novell.com/show_bug.cgi?id=540558), [https://bugzilla.novell.com/show_bug.cgi?id=466994](https://bugzilla.novell.com/show_bug.cgi?id=466994) 
