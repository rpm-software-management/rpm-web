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
* [git-changeset](git-changeset)
* [git-changelog](git-changelog)

### Configuring the scripts

Download the default [configuration file](gitconfig) and apply it to your git
checkout as follows:

```
cat gitconfig >> .git/config
```

You will also need the [GitHub CLI utility](https://cli.github.com/) which is
required by `git-changeset`.  On Fedora, get it with:

```
dnf install gh
```

Then, run `gh auth login` to authenticate with GitHub.

### Making a plan

First, generate a plan for the stable branch (e.g. `rpm-4.19.x`):

```
git checkout <stable>
git cherry-plan make master
```

This will create a file `<stable>.plan` in the current directory with a
chronological list of commits on master since the branching point, in a format
similar to that of `git rebase -i`, and mark with `noop` those that have been
cherry-picked already.

If the `git-changeset` utility is installed, commits will be grouped by their
originating GitHub pull requests.  This may take a while on the first run since
the script needs to fetch the PR data from GitHub.  The data is then cached
locally in the `.git/changeset/` directory and reused on next runs.

For complete usage help, run:

```
git cherry-plan -h
```

### Updating a plan

To later pull new commits from master into the plan, use:

```
git cherry-plan pull master
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
commit.

Once you've chosen your starting point, either delete the lines above it or
bookmark the place by inserting an empty line(s) or comment.  It's handy to
keep the previous commits, though, in case some of them turn out to be needed
to resolve a conflict.

For a newly created plan, if you choose to keep the previous commits, make sure
to mark them with `drop`, for example (replace `<linenum>` with the last line
to mark):

```
sed -i '1,<linenum> s/^     /drop /' <stable>.plan
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
grep '^pick ' <stable>.plan | wc -l
```

#### VIM config

If you use VIM, you can add [this](plan.vim) snippet into your `~/.vimrc` to
cycle through markers on the current line with the `C-a` key and do a `git
show` of the current commit with the `Enter` key.

If you also install the `git changeset` script mentioned above, you can type
`gx` to open the current commit's PR in your default browser.

### Sharing a plan

Once you're satisfied with your picks, send the plan as a plain-text email to
the team and ask for feedback.  That way, people can reply directly to the
individual commits inline.  Feel free to strip the old commits from the email
to keep it short.

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

## Cutting a release

RPM 4.19 has moved to CMake as the build system.  Prior releases (4.18 and
older) use Automake, though, so the following text will list instructions for
both build systems for the time being, until 4.18 goes out of support.

In the following text, the `X.Y.Z` string denotes the version number that
you're preparing, for example `4.19.0`.

1. Check the GitHub milestone:

    1. Go to our GitHub repository, open the Issues tab and filter by the
       expression `is:issue is:open milestone:X.Y.Z`.
    1. Verify that there are no matches, otherwise make sure to close any open
       issues in that milestone before proceeding further.

1. Prepare the sources:

    1. CMake:

        * Make sure your build is configured with the `-D WITH_IMAEVM=ON`
          option (this is needed for the `rpm-plugin-ima.8` man page to be
          generated, a current limitation of the build system, to be fixed).
        * Bump `VERSION` in `project()` in CMakeLists.txt
        * Bump `RPM_SOVERSION` and `RPM_LIBVERSION` in CMakeLists.txt:
            * Consult the associated comment block in CMakeLists.txt for
              instructions.
            * soname bumps can only occur at the first version of a new branch
              (i.e. alpha/beta).
        * Update the translations:
            ```
            git submodule update --init
            cd po/
            git pull origin master
            ```

    1. Automake:

        * Bump the version in `configure.ac`
        * Bump `rpm_version_info` (i.e. library soname version info) in the
          `rpm.am` file.  Basic libtool guidelines for maintenance updates to
          stable versions apply:
            * Consult the [libtool manual](https://www.gnu.org/software/libtool/manual/html_node/Updating-version-info.html)
            * soname bumps can only occur at the first version of a new branch
              (i.e. alpha/beta)
        * Update the sources for the above (Makefiles, `.po` regeneration and
          all): `make dist`

    3. Commit the changes from the previous step with something like "Preparing
       for X.Y.Z" as the message

1. Generate the final release tarball:

    * CMake: `make dist`
    * Automake: `make distcheck`

1. Automake only: Check that the previous step does not introduce any new
   changes (e.g. `git diff`).

1. Unpack the tarball next to the previous version and inspect the differences,
   watching out for unexpected material.  If you find any, STOP, figure it out
   and go back as many steps as required.  Note that the `docs/` directory may
   be omitted in most cases since it typically contains a lot of unimportant,
   automatically generated changes.  To inspect the differences, you can use
   the following command:

    `diff --color=always -uNr -x docs rpm-X.Y.Z-1 rpm-X.Y.Z | less -R`

1. Submit the whole lot as a pull request to the branch in question:

    * In case of maintenance releases, leave it up for commenting for at least
      a week to allow for community feedback
    * Review needs a different mindset than new code: look for compatibility
      and stability issues in particular, as per "Selecting commits" above

1. Tag the release:

    `git tag -am "RPM X.Y.Z release" rpm-X.Y.Z-release`

1. Push the tag.  This is the point of no return for a given release:

    `git push rpm-X.Y.Z-release`

1. Upload the bz2 tarball:

    1. `scp` it to `rpm@ftp-osl.osuosl.org` into the appropriate per-branch
       directory in `~/ftp/releases/`
    1. Run the `./trigger-rpm` script in the home directory to start mirror
       process

1. Create the release notes for [rpm.org](https://rpm.org/)

    1. Generate a changelog: `git changelog -m rpm-X.Y.Z-release >
       changelog.md` (see `git changelog -h` for more details)
    1. Clone the [rpm-web](https://github.com/rpm-software-management/rpm-web)
       repository (if not cloned yet) and enter it
    1. Make a copy of the `wiki/Releases/skeleton.md` file and name it
       `wiki/Releases/X.Y.Z.md`
    1. Fill in the blanks, use the contents of `changelog.md` for the "Summary
       of changes" section
    1. Add an entry to the `index.md` file announcing the release (see the
       existing entries for inspiration), copy the Highlights section from
       `changelog.md`
    1. Copy the entry into the `timeline.md` file
    1. Add an entry to the `download.md` file
    1. Commit the whole lot with a commit message such as "Release X.Y.Z"

1. Make the release official:

    1. Push the above commit to the remote (this will automatically regenerate
       the pages)
    2. Send out an announcement mail, typically like this:
        ```
        To: rpm-announce@lists.rpm.org, rpm-maint@lists.rpm.org, rpm-list@lists.rpm.org
        Subject: RPM X.Y.Z released!

        [some intro followed by the output of "git changelog"]

        For a complete list of changes, visit:

            https://rpm.org/wiki/Releases/X.Y.Z
        ```
    3. Open a new [GitHub
       discussion](https://github.com/rpm-software-management/rpm/discussions)
       with the content that's similar to the email and pin it.

1. Party!
