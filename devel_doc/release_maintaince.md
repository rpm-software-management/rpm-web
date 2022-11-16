---
layout: default
title: rpm.org - RPM Maintenance
---
TODO: Update according to modification/redesign of rpm.org

# RPM Maintenance

## Git branches

Rpm development takes place in the git master branch, but releases are created from stable branches, created when a development cycle is coming to an end. 
Alfa tarball is traditionally cut from master, but prior to beta release
the tree is branched and beta and later releases are *always* created
from a branch, not master.

* rpm-4.15.x branch from which all 4.15.x versions are cut from
* rpm-4.14.x branch from which all 4.14.x versions are cut from
* ...

When pulling fixes from git master to stable branches, always use -x to get the automatic cherry-pick commit marker. This way its easier to see which patches come from master, and which commit exactly. If a cherry-pick conflicts,
see if it's resolvable with a suitable upstream commit and if not, when
fixing manually change the "(cherry picked from commit ...)" message into
"Backported from commit ..." to mark the difference.

## Selecting commits

Crafting a stable release is inherently a manual process which starts by
selecting suitable commits from the master branch to cherry-pick or backport
into the respective stable branch.

While you can do this directly in git, it is recommended that you first create
a text file that lists all commits on the master branch since the last release
and mark those that you intend to pick.  This approach allows you to:

* Keep track of which commits you've reviewed so far

* Ensure that commits are always picked in chronological order

* Email the plan to the team to get feedback

* Tweak the plan easily, without having to (re)do any conflict resolution

* Use a shell script to automate the cherry-picking

* Try out different variants of the plan to see which apply cleanly

The rest of this section describes a workflow that involves such a text file,
one per stable branch, and a helper script.

### Installing the script

[Download](git-cherry-plan) the script, make it executable and put it into your
`$PATH`.

To allow the script to detect already applied commits, run:

```
$ git config --add cherryPlan.fromPatterns '^(cherry picked from commit \(.*\))$'
$ git config --add cherryPlan.fromPatterns '^Backported from commit \(.*\)$'
```

### Making a plan

First, generate a plan for the stable branch (e.g. rpm-4.15.x):

```
$ git checkout <stable>
$ git cherry-plan make master
```

This will create a file `<stable>.plan` in the current directory with a
chronological list of commits on master since the branching point, in a format
similar to that of `git rebase -i`, and mark with `noop` those that have been
cherry-picked or backported already.

To later pull new commits from master into the plan, use:

```
$ git cherry-plan pull master
```

For complete usage help, run:

```
$ git cherry-plan -h
```

### Editing a plan

The next step is to go through the unmarked commits and mark those that you
intend to include in the release with `pick`.  For each commit you review, ask
yourself:

* Does it change the ABI or API in an incompatible way?

    Generally adding entirely new APIs is okay, any other change is not, except
    of course to fix behavior bugs.

* Does it affect package building in an incompatible way?

    For example, adding new types of requires within stable releases is not a
    good idea (but provides are mostly harmless). New spec sanity checks may
    seem obvious, but unless its a crasher, chances are somebody is actually
    (ab)using it and will be unhappy if the package no longer builds. New
    warnings are generally okay, hard errors often are not.

    As a rule of thumb: If a package was buildable with rpm-X.Y.Z then it
    should also be buildable without changes on rpm-X.Y.Z+1, even if it relies
    on buggy behavior, except for security issues.

* Does it affect package installation in an incompatible way?

    Rpm is commonly used to install much older and also newer packages built
    with other versions than the running version, installation compatibility is
    hugely important always and even more so within stable branches.

    As a rule of thumb: If a package was installable with rpm-X.Y.Z then it
    should also be installable without changes on rpm-X.Y.Z+1, even if it
    relies on buggy behavior, except for security issues.

If the answer to any of the above is "yes" then it's almost certainly not
appropriate for a stable maintenance release.  Mark such a commit with `drop`.

The general priorities for stable branches are (descending order):

1. Regression, crash and security fixes
2. User visible breakage with no workarounds
3. User visible breakage with major impact
4. Other major impact stuff (if [budget](#choosing-a-commit-budget) allows)

#### Choosing a starting point

You may want to skip any commits that were already reviewed in the last release
(if any).  For a newly created plan, the last `noop` commit is a good
indication of where the review stopped, but it's a good idea to look a bit
further back, in case some otherwise suitable commits were omitted due to
[budget](#choosing-a-commit-budget) constraints and such.  In particular,
regression or security updates (e.g. rpm-4.15.1.1) tend to include very
specific cherry-picks, leaving gaps behind that may contain useful material for
the next stable release.

Otherwise, when editing an existing plan, simply start at the first unmarked
commit.

Once you've chosen your starting point, either delete the lines above it or
bookmark the place by inserting an empty line(s) or comment.  It's handy to
keep the previous commits, though, in case some of them turn out to be needed
to resolve a conflict.

For a newly created plan, if you choose to keep the previous commits, make sure
to mark them with `drop`, for example (replace `<linenum>` with the last line
to mark):

```
$ sed -i '1,<linenum> s/^     /drop /' <stable>.plan
```

#### Choosing a commit budget

A useful tool to help you pick and, in particular, *not* pick stuff, is a
"commit budget".  For stable releases, 30 is a good ballpark figure, but of
course, feel free to tweak it as needed.

Generally speaking, the budget is for code changes *only*, so any test and
documentation additions or updates do *not* count and should always be picked
if possible.

You can check the number of picks so far by running:

```
$ grep '^pick ' <stable>.plan | wc -l
```

#### VIM config

If you use VIM, you can add [this](plan.vim) snippet into your `~/.vimrc` to
cycle through markers on the current line with the `C-a` key and do a `git
show` with the `Enter` key.

### Sharing a plan

Once you're satisfied with your picks, send the plan as a plain-text email to
the team and ask for feedback.  That way, people can reply directly to the
individual commits inline.  Feel free to strip the old commits from the email
to keep it short.

### Applying a plan

Once the plan is ready, make a copy of the plan and create a topic branch for
the release (e.g. rpm-4.15.1):

```
$ cp <stable>.plan <release>.plan
$ git checkout -b <release>
```

Then, apply the plan:

```
$ git cherry-plan apply
```

This will go through each `pick` commit and run `git cherry-pick -x` on it.

In case a commit doesn't apply cleanly, the process will stop and a message
will be printed.  At that point, proceed with conflict resolution as usual and
when committing the changes, make sure to replace the line "(cherry picked from
commit ...)" with "Backported from commit ...", then run:

```
$ git cherry-plan mark
```

This will update the `noop` markers in the plan copy so that they reflect the
actual branch, i.e. any cherry-picks that were applied successfully above.
Continue the process by re-running `git cherry-plan apply`.  If another
conflict occurs, repeat the same process until the plan is applied completely.

While preparing the plan, it can be handy to try this out on a throwaway branch
every now and then, to make sure you're not missing some pre-requisite
commit(s).

## Cutting a release

1. Prepare preliminary release notes at https://rpm.org/wiki/Releases/X.Y.Z

    * Not every commit needs a corresponding release notes entry, eg
      internal refactoring and cleanup should not be detailed, and 
      often a new feature consists of multiple commits that deserve exactly
      on entry in the notes
    * Follow common style in the text, git commit messages are rarely good
      as-is. Start with what it does: add/fix/remove/change/optimize,
      followed by concise description. Group and sort by types of change.
    * Not all releases need the same exact subtitle groups, use common sense.
    * Upstream GH tickets can use #ticketno shortcut, references to external
      bugzillas follow naming conventions: RhBug:bugno, SuseBug:bugno,
      MgaBug:bugno (optimally make these actual links)

2. Prepare the sources:

    * Bump the version in configure.ac
    * Bump rpm_version_info (ie library soname version info) in rpm.am. Basic libtool guidelines for maintenance updates to stable versions:
        * consult the [libtool manual](https://www.gnu.org/software/libtool/manual/html_node/Updating-version-info.html)
        * soname bumps can only occur at the first version of a new branch (ie alpha/beta)

    * Update the sources for the above (Makefiles, .po regeneration and all): ```make dist```
    * Commit the changes from the previous step with something like 'Preparing for X.Y.Z' as message 

3. Generate the final release tarball:

    ```make distcheck```

4. Check that the previous step does not introduce any new changes (eg 'git diff')

5. Unpack the tarball next to the previous version and inspect the differences (something like 'diff -uNr rpm-<X.Y.Z> rpm-<X.Y.Z+1>') and watch out for unexpected material. If you find any, STOP, figure it out and go back as many steps as required.

6. Submit the whole lot as a pull-request to the branch in question

    * In case of maintenance releases, leave it up for commenting for at
      least a week to allow for community feedback
    * Review needs a different mindset than new code: look for compatibility
      and stability issues in particular, as per "selecting commits"
      above

7. Tag the release. Something like:

    git tag -a -m "RPM X.Y.Z release" rpm-X.Y.Z-release

8. Push the tag. This is the point of no return for a given release.

    git push --tags

9. Upload the bz2 tarball
   * scp to rpm@ftp-osl.osuosl.org to the appropriate per-branch directory in ~/ftp/releases/
   * run ./trigger-rpm script in the rpm home directory to start mirror process

9. Make the release official:

    * add tarball checksum and download location to the release notes
    * add a new item to https://rpm.org/wiki/News and https://rpm.org/timeline
    * send an announcement mail to rpm-announce@lists.rpm.org and rpm-maint@lists.rpm.org (and why not rpm-list@lists.rpm.org too) 
