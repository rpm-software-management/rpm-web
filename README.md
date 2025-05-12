# RPM.org Website

This repository holds the [Jekyll](https://jekyllrb.com/) source files used to
generate the official [RPM website](https://rpm.org/).  The site is generated
using a GitHub Actions [workflow](.github/workflows/gh-pages.yml).

On the website, we publish RPM and POPT releases as well as other news related
to the project. It also links to the in-tree
[documentation](https://rpm-software-management.github.io/rpm/) which is
generated from the upstream RPM
[repository](https://github.com/rpm-software-management/rpm/).

## Development

To preview the site locally, install Jekyll (natively packaged on most distros)
and run the following command from the root directory of your git checkout:

    jekyll serve

This will print a localhost URL which you can open in your browser.

## Release metadata

RPM releases are represented as a Jekyll
[collection](https://jekyllrb.com/docs/collections/) in the `_releases/`
directory.  The collection is used to generate individual release notes pages
as well as release announcements on the Home page and entries on the Download
page.

Each document in the collection is named after the version it represents (e.g.
`4.20.1.md`) and contains a YAML front matter describing the release's
properties.  The body of the document, which is in
[flavoured](#markdown-flavour) Markdown format, starts with an optional
bulleted list of highlights (an "overview") followed by the release notes.

### Required fields

* `version` - RPM version (from CMake)
* `baseline` - Which RPM version the release notes compare against
* `checksum` - SHA256 checksum of the tarball
* `date` - Release date (`YYYY-MM-DD`)

### Optional fields

* `summary` - A brief summary (one or two sentences) of the release, without a
  period at the end
* `overview` - Whether the document has an overview section (default: `true`)
* `draft` - Whether the document is a draft (default: `false`)

### Drafts

We typically publish preliminary release notes for upcoming major releases in
advance.  These are marked as drafts (see above) which causes them to not have
an announcement generated on the Home page.

Drafts don't require a `checksum` field.  The semantics of the `date` field is
"last modified at".

### Prereleases

We also publish prereleases ("snapshots") for upcoming major releases.  These
are marked by setting the `snapshot` field to one of `alphaN`, `betaN` or `rcN`
(where `N` is the respin number, starting at `1`).  The `version` field is set
to the target version (e.g. `4.20.0`), not the one from CMake (e.g. `4.19.93`).

Snapshots don't have their own release notes, their documents are only used to
generate announcements and download entries.  Both of these link to the final
version's page which must exist and be a draft.  Thus, snapshots don't require
a `baseline` field.

Draft pages automatically inherit some of the metadata from the latest snapshot
with the same `version`, such as the title, tarball and checksum information.
This allows for only having one release notes page that's continuously updated
until the final release.

### Supported releases

The stable series (e.g. `4.19.x`) currently in support are configured in the
`_data/projects.yml` file.  This determines which releases are shown on the
Download pages.

### Markdown flavour

You can use the following extra syntax elements in the release documents:

* **GitHub ticket references** - Prefix the issue or PR number with a hash sign
  and put the whole in parentheses, for example: `(#1234)`.  These will be
  converted into clickable links.
* **Man page references** - Use italics for the man page name, followed by the
  section number in parentheses, for example: `*rpm*(8)`.  These will be
  converted to clickable links.  Note that only our
  [own](https://rpm-software-management.github.io/rpm/man/) man pages will be
  linked, though.

## News entries

For generic announcements, we use the
[default](https://jekyllrb.com/docs/posts/) collection in the `_posts/`
directory.  These entries are merged with the release announcements when
rendering the Home page.
