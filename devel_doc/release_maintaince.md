---
layout: default
title: rpm.org - RPM Maintenance
---

# RPM Maintenance

## Git branches

RPM development takes place in the git master branch, but releases are created
from stable branches when a development cycle is coming to an end.  The alpha
tarball is traditionally cut from master, but prior to the beta release the
tree is branched and the beta and later releases are *always* created from a
branch, not master.

The stable branches follow a common naming scheme:

* `rpm-4.19.x`: all 4.19.x versions are cut from this branch
* `rpm-4.18.x`: all 4.18.x versions are cut from this branch
* ...

When pulling fixes from git master to stable branches, always use `-x` to get
the automatic cherry-pick commit marker.  This way it's easier to see which
patches come from master, and which commit exactly.  If a cherry-pick
conflicts, see if it's resolvable with a suitable upstream commit and if not,
fix it manually and change the "(cherry picked from commit ...)" message into
"(backported from commit ...)" to mark the difference.

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

* Track the plan in a git repo

The rest of this section describes a workflow that involves such a text file,
one per stable branch, and helper scripts.

### Installing the scripts

Download the following utilities, put them into your `$PATH` and make them
executable:

* [git-cherry-plan](git-cherry-plan)
* [git-changelog](git-changelog)

Also download the following file and place it alongside the above utilities:

* [common.py](common.py)

### Configuring the scripts

Download the default [configuration file](gitconfig) and apply it to your git
checkout as follows:

```
git config include.path /path/to/gitconfig
```

You will also need the [GitHub CLI utility](https://cli.github.com/) which is
required for commit grouping.  On Fedora, get it with:

```
dnf install gh
```

Then, run `gh auth login` to authenticate with GitHub.

### Making a plan

First, generate a plan for the stable branch (e.g. `rpm-4.19.x`):

```
git checkout <stable>
git cherry-plan make
```

This will create a file `<stable>.plan` in the current directory with a
chronological list of commits on master since the branching point, in a format
similar to that of `git rebase -i`, and mark with `noop` those that have been
cherry-picked already.

By default, commits will be grouped by their originating GitHub pull requests.
This may take a while on the first run since the script needs to fetch the PR
data from GitHub.  The data is then cached locally in the `.git/changeset/`
directory and reused on next runs.  This feature can be disabled with the `-s0`
switch.

For complete usage help, run:

```
git cherry-plan -h
```

### Updating a plan

To later pull new commits from master into the plan, use:

```
git cherry-plan pull
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
regression or security updates (e.g. rpm-4.19.1.1) tend to include very
specific cherry-picks, leaving gaps behind that may contain useful material for
the next stable release.

Otherwise, when editing an existing plan, simply start at the first unmarked
commit.  In either case, it can be handy to keep the previous commits in the
plan in case some of them turn out to be needed to resolve a conflict.

Once you've chosen your starting point, "cut" the plan in half with the
following command:

```
git cherry-plan cut <commit>
```

This will insert a "scissors" line below `<commit>` to mark the starting point
and automatically mark any unreviewed commits above that line with `drop`.

If you leave out the `<commit>` argument, the first unmarked commit will be
chosen as the "cutting" point.

#### Choosing a commit budget

A useful tool to help you pick and, in particular, *not* pick stuff, is a
"commit budget".  For stable releases, 30 is a good ballpark figure, but of
course, feel free to tweak it as needed.

Generally speaking, the budget is for code changes *only*, so any test and
documentation additions or updates do *not* count and should always be picked
if possible.  In fact, `git cherry-plan` is already configured to automatically
pick such commits when generating a plan, based on GitHub PR labels (see the
[config](gitconfig) file for the list).

The following command will print a summary of the plan (the number of picks
etc.) *below* the scissors line:

```
git cherry-plan status
```

#### VIM config

If you use VIM, you can add [this](plan.vim) snippet into your `~/.vimrc` to
cycle through markers on the current line with the `CTRL+SPACE` key and do a
`git show` of the current commit with the `Enter` key.

If you install the [git-changeset](git-changeset) script into your `$PATH`, you
can type `gx` to open the current commit's PR in your default browser.

Lastly, you can [check](#checking-a-plan) if the plan applies cleanly by
pressing `F8`.  This will also move the cursor to the line with the conflicting
commit (if any).

### Checking a plan

While working on a plan, it may be handy to quickly check whether the current
selection of commits would apply cleanly to the stable branch.  To do that,
run:

```
git cherry-plan check
```

This will create a temporary clone of the current checkout,
[apply](#applying-a-plan) the plan to it and print a "success" message or the
conflicting commit otherwise.

### Sharing a plan

Once you're satisfied with your picks, send the plan as a plain-text email to
the team and ask for feedback.  That way, people can reply directly to the
individual commits inline.

In most cases, you may only want to include the lines relevant to this review
session.  You can use the following command that prints the plan to standard
output, with everything above the scissors line cut off:

```
git cherry-plan dump > email.txt
```

### Applying a plan

Once the plan is ready, make a copy of the plan and create a topic branch for
the release (e.g. rpm-4.19.1):

```
cp <stable>.plan <release>.plan
git checkout -b <release>
```

Then, apply the plan:

```
git cherry-plan apply
```

This will go through each `pick` commit and run `git cherry-pick -x` on it.

In case a commit doesn't apply cleanly, the process will stop and a message
will be printed.  At that point, proceed with conflict resolution as usual and
when committing the changes, make sure to replace the line "(cherry picked from
commit ...)" with "(backported from commit ...)", then run:

```
git cherry-plan update
```

This will update the `noop` markers in the plan copy so that they reflect the
actual branch, i.e. any cherry-picks that were applied successfully above.
Continue the process by re-running `git cherry-plan apply`.  If another
conflict occurs, repeat the same process until the plan is applied completely.

While preparing the plan, it can be handy to try this out on a throwaway branch
every now and then, to make sure you're not missing some pre-requisite
commit(s).

### Publishing a plan

Now it's time to publish the final selection in the form of a pull request from
your fork's `<release>` branch into the `<stable>` branch.

* In case of maintenance releases, leave it up for commenting for at least a
  week to allow for community feedback

* Review needs a different mindset than new code: look for compatibility and
  stability issues in particular, as per "Selecting commits" above

Make sure the PR is merged before continuing below.

## Must-have content

The following items should be completed before proceeding to release cutting:

1. All GitHub tickets set to the milestone `X.Y.Z` are completed.  You can
   check that with the following search query: `is:issue is:open
   milestone:X.Y.Z`.  If there are some left, make sure they're handled and
   then go back as many steps as needed.

1. Translations are up-to-date.  If they weren't recently updated, do that with
   the below commands, then commit and push to master (use the commit message
   "Update translation submodule for new translations") and finally cherry-pick
   them onto the stable branch.

    ```
    git submodule update --init
    cd po/
    git pull origin master
    ```

## Cutting a release

1. Determine the version metadata (to be used in the next steps):

    1. `NUMBER` - RPM version number, as shown in the `rpm --version` output,
       e.g. `6.0.0` or `5.99.92`
    1. `VERSION` - RPM version number when final, e.g. `6.0.0` (equivalent to
       `NUMBER` if final)
    1. `LABEL` - release label, e.g. `beta1` (if prerelease) or `release` (if
       final)

1. Make a release commit:

    1. Set `project(VERSION ...)` in CMakeLists.txt to `NUMBER`
    1. Bump `RPM_SOVERSION` and `RPM_LIBVERSION` in CMakeLists.txt:
        * Consult the associated comment block in CMakeLists.txt for
          instructions.
        * soname bumps can only occur at the first version of a new branch
          (i.e. alpha/beta).
    1. Update the output of "pinned" tests: `make pinned`
    1. Commit the changes from the previous step with "Preparing for `VERSION
    LABEL`" as the message

1. Tag the release:

    `git tag -am "RPM VERSION LABEL" rpm-VERSION-LABEL`

1. Push the tag:

    `git push rpm-VERSION-LABEL`

1. Generate a tarball on GitHub:

    1. Create a GitHub release for the new tag:

        ```
        gh release create --title "RPM VERSION LABEL" \
                          --notes "Visit https://rpm.org/releases/NUMBER for the release notes and download information." \
                          [--prerelease] rpm-VERSION-LABEL
        ```

    1. This will trigger a GitHub Actions workflow that generates a `tar.bz2`
       and `CHECKSUM` file, and attaches both to the newly created release,
       under "Assets". This may take a few minutes.

1. Upload the tarball to [ftp.osuosl.org](https://ftp.osuosl.org/):

    1. Download the `tar.bz2` and `CHECKSUM` files from the new release to your
       current directory
    1. Verify the tarball's checksum:

       `sha512sum -c CHECKSUM`

    1. `scp` the tarball to `rpm@ftp-osl.osuosl.org` into the appropriate
       per-branch directory in `~/ftp/releases/`. Use the `testing/`
       subdirectory if this is a prerelease.
    1. Run the `./trigger-rpm` script in the `rpm` user's home directory on the
       server to start the mirroring process

1. Publish the release on [rpm.org](https://rpm.org/):

    1. Clone the
       [rpm-web](https://github.com/rpm-software-management/rpm-web.git)
       repository (if not cloned already)
    1. Add a new release page to the `_releases/` directory and name it
       `NUMBER.md`
    1. Write the release notes and fill out the top `---` block ("front
       matter") according to the README file provided in the repo
    1. Update the release notes draft for the final release (if this is a
       prerelease) accordingly
    1. Commit and push

1. Compose an announcement mail. See the previous
   [announcements](https://lists.rpm.org/pipermail/rpm-announce/) for
   inspiration. When ready, send it to the following mailing lists:

    `rpm-announce@lists.rpm.org, rpm-maint@lists.rpm.org, rpm-list@lists.rpm.org`

1. Open a discussion on GitHub:

    1. [Start](https://github.com/rpm-software-management/rpm/discussions/new?category=announcements)
       a new discussion topic in the "Announcements" category
    1. Use the contents of the announcement mail from above
    1. Submit and pin the discussion

1. Party!
