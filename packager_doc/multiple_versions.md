---
layout: default
title: Multiple Installed Versions
---
# Multiple Installed Versions

 It is often requested to allow rpm and tools above rpm to allow the same application to be installed multiple times with different versions. The idea is to allow the user/admin to use any of them b/c of specific features/bugs that they have or do not have.

This is often requested with regard to scripting/dynamic languages like python, ruby, perl, php, etc. Quirks or features in various versions are [ab]used by applications and/or external module compatibility is linked to a specific version. So a sysadmin will often need to provide, for example 4 different versions of php on a single system: php4, php5, php5.1 and php5.2 to maintain compatibility with some web application that their infrastructure wishes to run.

This page aims to document some of the pitfalls of building packages so that they work with the rpm and tools above rpm w/o seriously unexpected consequences. This document is not inclusive of all pitfalls but it tries to explain the major issues.

## The Problem(s)

rpm (the db and depsolver) doesn't care how many versions of anything you want to install. It really has no preference whatsoever. rpm does care about file conflicts (two or more packages owning the same file but those files not being identical (or multilib-related)) and package conflicts. rpm the command line client (/bin/rpm) does have some problems, though. It can install anything you want, but if you tell it to update a package and you have multiple versions of the same package_name installed, it will happily install the new one and remove ALL of the older ones. This is true for most of the package managers that operate above rpm (apt, smart, yum, etc).

All of the package management tools operate using certain keys to refer to packages/programs. Normally that key is package name or package name and package arch (ex: glibc or glibc.i686). So when you say to a package manager 'update glibc' it knows to update to the latest version of glibc and remove the older versions. But if you want to keep a number of versions around that requires very special knowledge inside the package manager AND it requires changes to the packages to accommodate the packages being installed at the same time and not having file conflicts.

Since every package a user may want to co-install with multiple other versions of itself will require packaging changes to facilitate this it makes more sense to change a lot about the packaging and let the existing policies of all of the package management tools function.

Note - many people will ask 'but we can install multiple kernels now, right?' the response to that is kernels are special in two ways:

1. all package managers have special logic for them 
2. the kernel packages are built specifically so they do not offer any conflicting files from one version of the kernel to the next. 

## Solutions

### name=pkgname+pkgversion

Since package managers key off of name or name+arch if we want multiple installed versions of certain applications/languages we need to modify what we normally name the package. For example instead of a package being named 'python' with a version of '2.6' we would name the package: 'python2.6' with a version of '2.6'. At first that seems redundant but it makes sense when we realize that 'python' is too generic in the namespace when you want to refer to python 2.6, 2.7, 3.0, 3.1, etc.

This lets the package managers know that python$version-2.6-1.i386 can update python$version-2.6-2.i386 but NOT python$version-2.5-1.i386 b/c they see the pkg name as python$version and do the version comparisons normally.

Now, these names-including-versions have to cascade down through Requires, Provides, Obsoletes and Conflicts, of course.

Note that a single meta-package can be created to provide better user experience. Let's take python packages in Fedora 16 as an example. The situation could look like this (the actual situation is different):

installed packages:
python2-2.7.3-3
python3-3.2.3-2
python-2.7.3-3 (Requires: python2-$version-$release)

After some time it is decided that Python 3 has become stable enough to be primary. The situation would change as follows:

installed packages:
python2-2.7.3-3
python3-3.2.3-2
python-3.2.3-2 (Requires: python3-$version-$release)

This handles the simple case of how the package managers interact with the packages. Now we have to work on how the packages interact with one another.

### file ownerships and versions

Packages installed on a system must not own the same files as any other package unless: 1. the files they own are identical 2. the files they own are multilib binaries and are allowed to supplant one another

Now, if we want to install a package like php5.1.2 and php5.2.1 on the same system you'll need to make sure all the files that each package owns are installed into version-specific paths. This also means that both versions will need to look for their modules, their libraries and in some cases their configuration in version-specific paths so they do not tread on one another in the packaging system nor in regular use. How to build the packages to facilitate this varies from language to language.

Note: break out links for languages here.

### module building

When modules for applications or languages are built/linked against a specific version and REQUIRE the version they were linked to then any modules you make into packages will need to understand the location differences and, if they can be built against any versions of any packages, should be able to be built for those - putting the module files into the appropriately versioned paths. This gets one step deeper if you require multiple versions of modules to be installed at the same time, too: ex: python-urgrabber-3.0 and python-urlgrabber-3.9.1 both built for python2.6 but also for python3.1

### alternatives

Where packages contain system wide files that need to be found without knowing and caring about the version (for example binaries in /usr/(s)bin/) alternatives can be used to switch the global default to different versions or implementations. See the [Fedora docs on using the alternatives systems](https://fedoraproject.org/wiki/Packaging:Alternatives).

### environment modules

Alternatives works if you need to install one or the other of conflicting or overlapping packages and have ONLY one of them work. When you need to have both (or all) of them work dependent on the user, you might consider [environment modules](https://fedoraproject.org/wiki/Packaging/EnvironmentModules) to help you.

## Notes

1. This page is not complete, if you know of something you think should be added here, please contact seth vidal or any rpm.org developer to help you. 
