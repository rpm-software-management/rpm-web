---
layout: default
title: RPM Maintenance
---
TODO: Update according to modification/redesign of rpm.org

# RPM Maintenance

## Git branches

Rpm development takes place in the git master branch, but no releases are created from the master. All releases are created from stable branches, created when a development cycle is coming to an end. All releases, including any alpha/beta/rc pre-releases, of this major version are cut from that branch: * rpm-4.12.x branch from which all 4.12.x versions are cut from * rpm-4.11.x branch from which all 4.11.x versions are cut from * ...

When pulling fixes from git master to stable branches, always use -x to get the automatic cherry-pick commit marker. This way its easier to see which patches come from master, and which commit exactly.

## Selecting commits for cherry-picking (or backporting) for maintenance updates

For each fix or other change you consider cherry-picking, ask yourself:

* Does it change the ABI or API in an incompatible way?

    Generally adding entirely new APIs is okay, any other change is not, except of course to fix behavior bugs.

* Does it affect package building in an incompatible way?

    For example, adding new types of requires within stable releases is not a good idea (but provides are mostly harmless). New spec sanity checks may seem obvious, but unless its a crasher, chances are somebody is actually (ab)using it and will be unhappy if the package no longer builds. New warnings are generally okay, hard errors often are not.

    As a rule of thumb: If a package was buildable with rpm-X.Y.Z then it should also be buildable without changes on rpm-X.Y.Z+1, even if it relies on buggy behavior.

* Does it affect package installation in an incompatible way?

    Rpm is commonly used to install much older and also newer packages built with other versions than the running version, installation compatibility is hugely important always and even more so within stable branches.

    As a rule of thumb: If a package was installable with rpm-X.Y.Z then it should also be installable without changes on rpm-X.Y.Z+1, even if it relies on buggy behavior.

If the answer to any of the above is "yes" then its almost certainly not appropriate for stable maintenance release.

## Cutting a release

1. Prepare preliminary release notes at http://rpm.org/wiki/Releases/X.Y.Z

2. Prepare the sources:

    Bump the version in configure.ac
    Bump rpm_version_info (ie library soname version info) in rpm.am, Basic libtool guidelines for maintenance updates to stable versions:
        always increment revision
        if new API's added, increment age
        if you think of updating current, you're doing something wrong unless its the first (beta) version of a new branch For details, consult the libtool manual: https://www.gnu.org/software/libtool/manual/html_node/Updating-version-info.html 
    Update translations from Transifex (optional)
    Update the sources for the above (Makefiles, .po regeneration and all): make -f Makefile.maint release
    Commit the changes from the previous step with something like 'Preparing for X.Y.Z' as message 

3. Generate the final release tarball:

    make -f Makefile.maint release

4. Check that the previous step does not introduce any new changes (eg 'git diff')

5. Unpack the tarball next to the previous version and inspect the differences (something like 'diff -uNr rpm-<X.Y.Z> rpm-<X.Y.Z+1>') and watch out for unexpected material. If you find any, STOP, figure it out and go back as many steps as required.

6. Tag the release. Something like:

    git tag -a -m "RPM X.Y.Z release" rpm-X.Y.Z-release

7. Push the tag. This is the point of no return for a given release.

    git push --tags

8. Upload the bz2 tarball to rpm.org to the appropriate per-branch directory in /srv/projects/rpm/web/releases/

9. Make the release official:

    add tarball checksum and download location to the release notes
    add a new item to http://rpm.org/wiki/News
    send an announcement mail to rpm-announce@lists.rpm.org and rpm-maint@lists.rpm.org (and why not rpm-list@lists.rpm.org too) 
