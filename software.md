---
layout: default
title: Related Sofware
---
## Software related to RPM

Here you can find links to software related to RPM such as frontends, packaging tools etc.

### RPM Frontends / Depsolvers

* [YUM](http://yum.baseurl.org/) is an RPM frontend written in Python.
* [libzypp/zypper](http://en.opensuse.org/Libzypp) is an RPM frontend written in C/C++ (used by openSUSE, SLES and Ark Linux). It uses [SAT solver](https://github.com/openSUSE/libsolv) for dependency solving.
* [DNF](https://github.com/akozumpl/dnf) is an RPM frontend written in Python. It uses [SAT solver](https://github.com/openSUSE/libsolv) for the hard work.
* [Urpmi](http://gitweb.mageia.org/software/rpm/urpmi/) is an RPM frontend written in Perl (used by Mageia and Mandriva)
* [APT-RPM](http://apt-rpm.org/) is an RPM port of the Debian APT package management tool written in C++.
* [SmartPM](http://labix.org/smart) is another frontend for RPM (also works with DEB, Slackware etc packaging formats) written mostly in Python
* [Poldek](http://poldek.pld-linux.org/) is another frontend for RPM, primarily used by the PLD distribution. 

### Packager tools
* [rpmlint](http://rpmlint.zarb.org/) is a tool for checking for common errors in RPM packaging.
* [rpmdevtools](https://hosted.fedoraproject.org/projects/rpmdevtools) contains scripts and (X)Emacs support files to aid in RPM packaging.
* [cpan2rpm](http://search.cpan.org/~ecalder/cpan2rpm/) generates RPM packages from Perl CPAN modules.
* [cpanspec](http://cpanspec.sourceforge.net/) is another tool for creating RPM packages from Perl CPAN modules.
* [rpmrebuild](http://rpmrebuild.sourceforge.net/) is a tool that can generate a spec from an already installed RPM (useful when you don't have access to real source rpm, eg with packages of proprietary software)
* [Specfile Editor](http://www.eclipse.org/linuxtools/projectPages/specfile/) is a spec file editor plugin for Eclipse.
* [RPM Stubby](http://www.eclipse.org/linuxtools/projectPages/rpmstubby/) is a spec file generator plugin for Eclipse. 

### Build tools 
* [Open Build Service](http://openbuildservice.org/) is a generic build- and distribution system.
* [Copr](https://fedorahosted.org/copr/) is a lightweight build- and distribution system.
* [Koji](https://fedorahosted.org/koji/) is a package build and tracking system.
* [Mock](https://hosted.fedoraproject.org/projects/mock/) is a 'simple' chroot build environment manager for building RPMs.
* [Mach](http://thomas.apestaart.org/projects/mach/) is a more generic chroot environment manager that can also be used for building RPMs.
* [Mezzanine](http://beta.kainx.org/wiki/view/Mezzanine) is a set of tools which simplify the management of software packages and collections of software packages. 

### Other tools
* [DeltaRPM](http://gitorious.org/deltarpm/) contais tools for creating and applying change deltas of RPM packages
* [rpm2html](http://www.nongnu.org/rpm2html/) generates web pages that describe a set of RPM packages.
* [rpmreaper](https://fedorahosted.org/rpmreaper/) is a ncurses-based application for finding unnecessary packages in the system.
* [libsolv](https://github.com/openSUSE/libsolv) is library for package dependency resolution. 

### Language bindings
* [perl-RPM2](http://search.cpan.org/dist/RPM2/) provides an object-oriented interface to RPM facilities for Perl.
* [RPM-Specfile](http://search.cpan.org/dist/RPM-Specfile/) is a Perl extension for creating RPM specfiles.
* [Ruby-RPM](http://rubyforge.org/projects/ruby-rpm/) provides Ruby bindings to RPM.
* Python bindings for RPM are distributed as part of [RPM releases](https://github.com/lkardos/rpm/wiki/Download-source).
* [JRPM](http://jrpm.sourceforge.net/) is a java library to manipule and create RPM archives.
* [Redline](http://www.introspectrum.com/oss/) is a pure Java library for manipulating RPM Package Manager packages.
* [phprpm](http://cekirdek.uludag.org.tr/~meren/php_rpm/) provides some basic functionality for accessing RPM files from PHP programs.
* [perl-URPM](http://gitweb.mageia.org/software/rpm/perl-URPM/) is a Perl extension for manipulating rpm headers and packages.
* [libsolv](https://github.com/openSUSE/libsolv) has bindings for Perl, Python and Ruby. 


