---
layout: default
title: rpm.org - Python RPM
---

# Programming RPM with Python

## TL;DR

If you prefer learning from examples, see:

- [Searching packages][rpm-q]
- [Querying additional information about packages][rpm-qi]
- [Querying all packages][rpm-qa]
- [Installing packages][rpm-i]
- [Uninstalling packages][rpm-e]


## Summary
This chapter introduces the high-level RPM API for Python programming. You can
use this API from Python scripts to perform RPM functionality, just as you can
write C programs using the RPM C API covered in
[Chapter 15, Programming RPM with C][chapter-15].

In general, the Python API is simpler and requires fewer code statements than
the corresponding functionality in the C API.

Just about all of your work with the Python API requires a transaction set,
which you can get by calling `rpm.TransactionSet`.

To query the RPM database, call `dbMatch` on the transaction set object. To
install or upgrade packages, call `addInstall`, `check`, `order`, and `run` on
the transaction set.

See also [Chapter 17, Programming RPM with Perl][chapter-17]. With the rich set
of APIs, you can write your RPM programs in C, Python, Perl, or any language
that can call on code written in one of these languages.


## Setting Up a Python Development Environment

Setting up a Python development environment is much the same as setting up a C
programming environment. You need to install a set of packages for general
Python development, install a package that provides the Python API to the RPM
system, and choose a program for
editing your Python scripts.


## Installing the base Python packages

The base Python package needed for developing applications is `python`.

The Python package for RPM access is `python3-rpm`. Install these as you would
any other packages.

```
$ dnf install python python3-rpm
```


## Programming with the RPM Database

Compared to the RPM C API, discussed in
[Chapter 15, Programming RPM with C][chapter-15] , the Python API is much
simpler and requires many fewer programming statements to get your job done.
Just about every Python RPM script needs a transaction set. Create a transaction
set with `rpm.TransactionSet`:

```python
import rpm
ts = rpm.TransactionSet()
```

The transaction set will automatically open the RPM database if needed.


Note: The code examples in this chapter follow the Red Hat conventions for naming
variables, such as `ts` for a transaction set. This is to make it easier to read
the [Python examples in the RPM sources][rpm-examples], along with Red Hat
installer programs written in Python.

You will need a transaction set in just about every Python script that accesses
RPM functionality.


## Accessing the RPM database

Transaction sets provide a number of methods for working with the RPM database
at the database level. Use these methods if you need to interact with the
database as a whole, as opposed to accessing individual packages in the
database. For example, you can initialize or rebuild the RPM database with these
methods. You can also use a handy trick for accessing another RPM database
instead of the default system database.


## Setting the Database Location

A transaction set will open the RPM database assuming the default location. To
specify a different RPM database location, call addMacro, as shown following:

```python
rpm.addMacro("_dbpath", path_to_rpm_database)
```

You can work with more than one RPM database by setting the `_dbpath` macro,
creating a transaction set, and then removing the macro. After doing this, you
can create another transaction set for the default RPM database, allowing your
script to work with more than one database. For example:

```python
# Open the rpmdb-redhat database
rpm.addMacro("_dbpath", "/usr/lib/rpmdb/i386-redhat-linux/redhat")
solvets = rpm.TransactionSet()
solvets.openDB()
rpm.delMacro("_dbpath")

# Open default database
ts = rpm.TransactionSet()
```

The explicit call to `openDB` opens the RPM database. In most Python scripts,
though, you do not want to call `openDB`. Instead, a transaction set will open
the database as needed.  The call to `delMacro` removes the `_dbpath` macro,
allowing the next call to TransactionSet to use the default RPM database.

Note: Do not call `closeDB` on a transaction set. This method does indeed close
the RPM database, but it also disables the ability to automatically open the RPM
database as needed.


## Initializing, Rebuilding, and Verifying the Database

The transaction set provides an `initDB` method to initialize a new RPM database.

This acts like the rpm `--initdb` command.

```python
ts.initDB()
```

The `rebuildDB` method regenerates the RPM database indices, like the rpm
`--rebuilddb` command:

```python
ts.rebuildDB()
```

The `verifyDB` method checks that the RPM database and indices are readable by
the Berkeley DB library:

```python
ts.verifyDB()
```

Calling this method is the same as running the `db_verify` command on each of
the database files in `/var/lib/rpm`.

See [Chapter 4, Using the RPM Database][chapter-4] for more on initializing,
rebuilding, and verifying RPM databases.

Once you have a transaction set, you can start querying the RPM database.


## Querying the RPM database

Call `dbMatch` on a transaction set to create a match iterator. As with the C
API, a match iterator allows your code to iterate over the packages that match a
given criteria.

A call to `dbMatch` with no parameters means setting up a match iterator to go
over the entire set of installed packages. The basic format follows:

```python
import rpm
ts = rpm.TransactionSet()
mi = ts.dbMatch()
for h in mi:
    # Do something with header object...
    pass
```

In this example, the call to `dbMatch` returns a match iterator. The for loop
iterates over the match iterator, returning one header each time.

In addition to this syntax, you can call next on the match iterator to get the
next entry, a header object that represents one package. For example:

```python
import rpm
ts = rpm.TransactionSet()
mi = ts.dbMatch()
while True:
    try:
        h = next(mi)
        # Do something with the header object
        print(h)
    except StopIteration:
        break
```

For example, this script prints the name, version, and release information for
all installed packages.


```python
#!/usr/bin/python
# Acts like rpm -qa and lists the names of all the installed packages.
# Usage:
# python rpmqa.py

import rpm

ts = rpm.TransactionSet()
mi = ts.dbMatch()
for h in mi:
    print("{0}-{1}-{2}".format(h["name"], h["version"], h["release"]))
```

When you call this script, you should see output like the following, truncated
for space:

```
$ python rpmqa.py
libbonoboui-2.0.1-2
attr-2.0.8-3
dhclient-3.0pl1-9
file-3.37-8
hdparm-5.2-1
ksymoops-2.4.5-1
imlib-1.9.13-9
logwatch-2.6-8
mtr-0.49-7
openssh-clients-3.4p1-2
pax-3.0-4
python-optik-1.3-2
dump-0.4b28-4
sendmail-8.12.5-7
sudo-1.6.6-1
mkbootdisk-1.4.8-1
telnet-0.17-23
usbutils-0.9-7
wvdial-1.53-7
docbook-dtds-1.0-14
urw-fonts-2.0-26
db4-utils-4.0.14-14
libogg-devel-1.0-1
```

Note: If you set the execute permission on this script

```
$ chmod +x rpmqa.py
```

you can skip the explicit call to the python command. For example:

```
$ ./rpmqa.py
```

## The hdr Class

You can access each entry in the header using Python's dictionary syntax. This
is much more convenient than calling `headerGetEntry` in C programs. The basic
syntax to access header entries follows:

```python
value = h["tag_name"]
```

For example, to get the package name, use the following code:

```python
name = h["name"]
```

You can also use a set of predefined `RPMTAG_` constants that match the C
API. These constants are defined in the `rpm` module. For example:

```python
name = h[rpm.RPMTAG_NAME]
```

Note: Using the rpm constants such as `rpm.RPMTAG_NAME` is faster than using the
strings such as `"name"`.

For header entries that hold an array of strings, such as the list of files in
the package, the data returned is a Python list. For example:

```python
print("Files:")
files = h["FILENAMES"]
for name in files:
    print(name)
```

You can use `files` API to achieve more compact code. For example:

```python
print("Files:")
for f in rpm.files(h):
    print(f.name)
```

The requires, provides, obsoletes, and conflicts information each appear as
three separate but related lists for each set of information, with three lists
for the requires information, three for the provides information, and so on. You
can extract this information using Python dependency sets using the simple code
following:

```python
rpm.ds(h, rpm.RPMTAG_PROVIDENAME)
rpm.ds(h, rpm.RPMTAG_REQUIRENAME)
rpm.ds(h, rpm.RPMTAG_OBSOLETENAME)
rpm.ds(h, rpm.RPMTAG_CONFLICTNAME)
```

See [Printing information on packages][printing-information-on-packages] to
understand how to print this information.


## Printing Header Information with format

In addition to using the Python dictionary syntax, you can use the `format`
method on a header to format data using a syntax exactly the same as the query
format tags supported by the rpm command.

See [Chapter 4, Using the RPM Database][chapter-4] which covers query formats.

The basic syntax is as follows:

```
h.format("%{tag_name}")
```

You can also use special formatting additions to the tag name. For example:

```
print("Header signature: ", h.format("%{RSAHEADER:pgpsig}"))
print("{0}-20s: {1}".format("Installed on", h.format("%{INSTALLTID:date}")))
```

You can combine this information into functions that print out header entries
with specific formatting. For example:

```python
def nvr(h):
    return h.format("%{NAME}-%{VERSION}-%{RELEASE}")
```

Note: This function is for illustration purposes. In real code, you can use
`h.format("%{NVR}")`.

Note that you only really need to use `h.format` when you need the format
modifiers, such as date on `%{INSTALLTID:date}`. In most other cases, Python’s
string-handling functions will work better.


## Querying for specific packages

When you call `dbMatch` on a transaction set object, passing no parameters means
to iterate over the entire set of installed packages in the RPM database. You
can also query for specific packages using `dbMatch`. To do so, you need to pass
the name of a tag in the header, as well as the value for that tag that you are
looking for. The basic syntax follows:

```python
mi = ts.dbMatch(tag_name, value)
```

For example, to query for all packages named sendmail, use code like the
following:

```
mi = ts.dbMatch("name", "sendmail")
```

The call to `dbMatch` returns an `rpmdbMatchIterator`. You can query on any of
the tags in the header, but by far the most common query is by name.

Note: Some matches are fast and some are much slower. If you try to match on a
tag that is indexed in the RPM database, the matches will perform much faster
than for those tags that are not indexes. To determine which tags are indexed,
look at the files in `/var/lib/rpm`.

This example Python script queries for a particular package name and then prints
out the name, version, and release for all matching packages.

```python
#!/usr/bin/python
# Acts like rpm -q and lists the N-V-R for installed
# packages that match a given name.
# Usage:
# python rpmq.py package_name

import sys
import rpm

ts = rpm.TransactionSet()
mi = ts.dbMatch("name", sys.argv[1])
for h in mi:
    print(h[rpm.RPMTAG_NVR])
```

When you call this script, you need to pass the name of a package to query,
which the python interpreter will store in `sys.argv[1]` in the call to
`dbMatch`. For example:

```
$ python rpmq.py ed
ed-1.20.2-2.fc41
```


## Printing information on packages

You can create the equivalent of the `rpm –qi` command with a small number of
Python commands. This script queries for a particular package name, as shown
previously in
[Querying for specific packages][querying-for-specific-packages]

Once a package is found, though, `rpminfo.py` prints out a lot more information,
similar to the output from the `rpm –qi` command.

```python
#!/usr/bin/python
# Lists information on installed package listed on command line.
# Usage:
# python rpminfo.py package_name

import sys
import rpm


def print_dependency_set(title, ds):
    if not ds:
        return
    print(f"\n{title}:")
    for item in ds:
        print(item[0])


def print_header(h):
    print(
        f"Name        : {h[rpm.RPMTAG_NAME]}\n"
        f"Version     : {h[rpm.RPMTAG_VERSION]}\n"
        f"Release     : {h[rpm.RPMTAG_RELEASE]}\n"
        f"Architecture: {h[rpm.RPMTAG_ARCH]}\n"
        f"Install Date: {h[rpm.RPMTAG_INSTALLTIME]}\n"
        f"Group       : {h[rpm.RPMTAG_GROUP]}\n"
        f"Size        : {h[rpm.RPMTAG_SIZE]}\n"
        f"License     : {h[rpm.RPMTAG_LICENSE]}\n"
        f"Signature   : {h.format("%{rsaheader:pgpsig}")}\n"
        f"Source RPM  : {h[rpm.RPMTAG_SOURCERPM]}\n"
        f"Build Date  : {h[rpm.RPMTAG_BUILDTIME]}\n"
        f"Build Host  : {h[rpm.RPMTAG_BUILDHOST]}\n"
        f"Packager    : {h[rpm.RPMTAG_PACKAGER]}\n"
        f"Vendor      : {h[rpm.RPMTAG_VENDOR]}\n"
        f"URL         : {h[rpm.RPMTAG_URL]}\n"
        f"Bug URL     : {h[rpm.RPMTAG_BUGURL]}\n"
        f"Summary     : {h[rpm.RPMTAG_SUMMARY]}\n"
        f"Description : {h[rpm.RPMTAG_DESCRIPTION]}\n"
    )

    print("Files:")
    fi = h["FILENAMES"]
    for f in fi:
        print(f)

    provides = rpm.ds(h, rpm.RPMTAG_PROVIDENAME)
    print_dependency_set("Provides", provides)

    requires = rpm.ds(h, rpm.RPMTAG_REQUIRENAME)
    print_dependency_set("Requires", requires)

    obsoletes = rpm.ds(h, rpm.RPMTAG_OBSOLETENAME)
    print_dependency_set("Obsoletes", obsoletes)

    conflicts = rpm.ds(h, rpm.RPMTAG_CONFLICTNAME)
    print_dependency_set("Conflicts", conflicts)


ts = rpm.TransactionSet()
mi = ts.dbMatch("name", sys.argv[1])
for h in mi:
    print_header(h)
```

When you run this script, you need to pass the name of a package. You'll see
output like the following (truncated):

```
$ python rpminfo.py ed
Name        : ed
Version     : 1.20.2
Release     : 2.fc41
Architecture: x86_64
Install Date: 1729781706
Group       : Unspecified
Size        : 150378
License     : GPL-2.0-only AND GFDL-1.3-no-invariants-or-later
Signature   : RSA/SHA256, Thu Jul 18 07:02:27 2024, Key ID d0622462e99d6ad1
Source RPM  : ed-1.20.2-2.fc41.src.rpm
Build Date  : 1721252985
Build Host  : buildvm-x86-22.iad2.fedoraproject.org
Packager    : Fedora Project
Vendor      : Fedora Project
URL         : https://www.gnu.org/software/ed/
Bug URL     : https://bugz.fedoraproject.org/ed
Summary     : The GNU line editor
Description : ed is a line-oriented text editor, used to create, display, and modify text
files (both interactively and via shell scripts). For most purposes, ed has been
replaced in normal usage by full-screen editors (emacs and vi, for example).

Files:
/usr/bin/ed
/usr/bin/red
/usr/lib/.build-id
...

Provides:
P ed = 1.20.2-2.fc41
P ed(x86-64) = 1.20.2-2.fc41

Requires:
R /usr/bin/sh
R libc.so.6()(64bit)
R libc.so.6(GLIBC_2.11)(64bit)
R libc.so.6(GLIBC_2.14)(64bit)
R libc.so.6(GLIBC_2.2.5)(64bit)
...
```


## Refining queries

The `pattern` method on a match iterator allows you to refine a query. This
narrows an existing iterator to only show the packages you desire. The basic
syntax follows:

```python
mi.pattern(tag_name, mode, pattern)
```

The two main uses of the pattern method are to query on more than one tag, such
as the `version` and `name`, or to narrow the results of a query, using the rich
set of pattern modes. The mode parameter names the type of pattern used, which
can be one of those listed in the following table.

| Type                  | Meaning                                                      |
|-----------------------|--------------------------------------------------------------|
| `rpm.RPMMIRE_DEFAULT` | Same as regular expressions, but with \., .*, and ^..$ added |
| `rpm.RPMMIRE_GLOB`    | Glob-style patterns using fnmatch                            |
| `rpm.RPMMIRE_REGEX`   | Regular expressions using regcomp                            |
| `rpm.RPMMIRE_STRCMP`  | String comparisons using strcmp                              |

For more on these patterns, see the manual pages for `fnmatch(3)`, `glob(7)`,
`regcomp(3)`, `regex(7)`, and `strcmp(3)`. The pattern method calls
`rpmdbSetIteratorRE` from the C API, covered in the "Database Iterators" section
in [Chapter 15, Programming RPM with C][chapter-15].

To query for all packages starting with `"py"`, for example, you can use code
like the following:

```python
import rpm
ts = rpm.TransactionSet()
mi = ts.dbMatch()
mi.pattern("name", rpm.RPMMIRE_GLOB, "py*" )
for h in mi:
    # Do something with the header...
    pass
```

A full example can look like this:

```python
#!/usr/bin/python
# Acts like rpm -q and lists the N-V-R for installed packages
# that match a given name using a glob-like syntax
#
# Usage:
# python rpmglob.py "package_fragment*"

import sys
import rpm

ts = rpm.TransactionSet()
mi = ts.dbMatch()
if not mi:
    print("No packages found.")
    sys.exit(1)

mi.pattern("name", rpm.RPMMIRE_GLOB, sys.argv[1])
for h in mi:
    print(h[rpm.RPMTAG_NVR])
```

When you run this script, you’ll see output like the following:

```
$ python rpmglob.py "py*"
python-pip-wheel-24.2-1.fc41
python3-dbus-1.3.2-8.fc41
python3-gobject-base-3.48.2-3.fc41
python3-libselinux-3.7-5.fc41
python3-systemd-235-11.fc41
python3-distro-1.9.0-5.fc41
python3-pyudev-0.24.3-3.fc41
...
```

In addition to working with the RPM database, the Python API also provides
access to RPM files.


## Reading Package Files

As you would expect, the Python API includes methods for working with RPM
package files in addition to installed RPM packages. Most of these methods
require a header object, which you can read from an RPM package file.


## Reading headers from package files

Like the C function `rpmReadPackageFile`, the Python API provides a convenient
way to read a header object from an RPM package file. The `hdrFromFdno`
method reads an RPM header from an open file descriptor. The basic syntax is:

```python
h = ts.hdrFromFdno(fdno)
```

Note: The `hdrFromFdno` method uses Python’s low-level file descriptors instead
of the higher-level Python file objects. In the RPM C library, an `FD_t` is a
`FILE**`. This could be bound to a Python class, but that is outside the scope
of this chapter.

The following example shows a function that opens a file, reads in the RPM
header, and then closes the file:

```python
import os
import rpm

def read_rpm_header(ts, filename):
    fd = os.open(filename, os.O_RDONLY)
    h = ts.hdrFromFdno(fd)
    os.close(fd)
    return h

ts = rpm.TransactionSet()
h = read_rpm_header(ts, "n-v-r.rpm")
```

The `hdrFromFdno` method raises a number of exceptions based on issues detected
with the package files. The following example shows these exceptions:

```python
import os
import rpm

def read_rpm_header(ts, filename):
    fd = os.open(filename, os.O_RDONLY)
    h = None
    try:
        h = ts.hdrFromFdno(fd)
    except rpm.error as ex:
        error = str(ex)
        if error == "public key not available":
            print(error)
        if error == "public key not trusted":
            print(error)
        if error == "error reading package header":
            print(error)
    finally:
        os.close(fd)
    return h

ts = rpm.TransactionSet()
h = read_rpm_header(ts, "n-v-r.rpm")
```

You can decide in your code whether the exceptions should stop processing or
not.


## Setting the verification flags

Starting with rpm 4.1, package files are verified automatically, which can cause
problems, especially if you are working with older packages, or packages without
proper digital signatures.

In most cases, the automatic verification is an advantage, since you can have
greater confidence in the package files. However, you can call `setVSFlags` on a
transaction set to change the default behavior.

```python
ts.setVSFlags(flags)
```

For example, if you have problems with old packages that do not have proper
signatures, you can use code like the following to ignore such checks:

```python
# Set to not verify DSA signatures.
ts.setVSFlags(rpm.RPMVSF_NODSA)
```

The following table lists the flags you can pass to `setVSFlags` on a
transaction set. These flags are bitmasks. You can "or" them together for more
than one setting. You must do a binary "or". Do not use the Python `or` keyword,
use `|` instead, for a binary "or" operation.

| Flag                       | Meaning                                                          |
|----------------------------|------------------------------------------------------------------|
| `rpm.RPMVSF_NEEDPAYLOAD`   | Leave the file handle positions at the beginning of the payload. |
| `rpm.RPMVSF_NOHDRCHK`      | Don’t check the RPM database header.                             |
| `rpm.RPMVSF_ NODSA`        | Don’t check the header and payload DSA signatures.               |
| `rpm.RPMVSF_ NODSAHEADER`  | Don’t check the header DSA signature.                            |
| `rpm.RPMVSF_ NOMD5`        | Don’t check the header and payload MD5 digests.                  |
| `rpm.RPMVSF_ NORSA`        | Don’t check the header and payload RSA signatures.               |
| `rpm.RPMVSF_ NOSHA1HEADER` | Don’t check the header SHA1 digest.                              |
| `rpm._RPMVSF_NODIGESTS`    | Convenience to not check digests.                                |
| `rpm._RPMVSF_NOSIGNATURES` | Convenience to not check signatures.                             |

To turn off all checks, you can pass `–1` to `setVSFlags`:

```python
ts.setVSFlags(-1)
```


## Dependency Comparisons

FIXME code examples in this chapter are outdated

Dependency sets, first introduced in
[Chapter 15, Programming RPM with C][chapter-15],
allow you to compare the dependencies between two packages. One of the most
common uses for this is to compare a package file against a version on disk to
see if the package file holds a newer version of a package than the one
installed.

You can call `dsOfHeader` on a header object to get the default dependency set
for the header. Armed with dependency sets from two headers, you can compare the
sets to see which package is newer using simple code like the following:

```python
file_h = ts.hdrFromFdno(fd)
file_ds = file_h.dsOfHeader()
inst_ds = inst_h.dsOfHeader()
if file_ds.EVR() >= inst_ds.EVR():
    print("Package file is same or newer, OK to upgrade.")
else:
    print("Package file is older than installed version.")
```

Pulling this all together, Listing 17-5 provides a Python script that compares a
package file against an installed package, reporting on which is newer.


```python
#!/usr/bin/python
# Reads in package header, compares to installed package.
# Usage:
# python vercompare.py rpm_file.rpm
#
import os
import sys
import rpm

def read_rpm_header(ts, filename):
    fd = os.open(filename, os.O_RDONLY)
    try:
        h = ts.hdrFromFdno(fd)
    finally:
        os.close(fd)
    return h

ts = rpm.TransactionSet()
h = read_rpm_header( ts, sys.argv[1] )
pkg_ds = h.dsOfHeader()

for inst_h in ts.dbMatch('name', h['name']):
    inst_ds = inst_h.dsOfHeader()
    if pkg_ds.EVR() >= inst_ds.EVR():
        print("Package file is same or newer, OK to upgrade.")
    else:
        print("Package file is older than installed version.")
```

This script takes in a package file name on the command line, loads in the
header for that package, and looks up all packages of the same name installed in
the RPM database. For each match, this script compares the packages to see which
is newer.

You can modify this script, for example, to print out a message if a package
isn't installed.


## Installing and Upgrading Packages

With the RPM system, you have a lot of choices. You can install or upgrade
packages with the rpm command. You can install or upgrade packages with special
programs you write using the C API. And you can install or upgrade packages
using the Python API. If you are writing a special program to install or upgrade
packages, the Python API makes this task much easier. As with the C API, most of
your work needs to be part of a transaction set.

To install or upgrade a package, you need to create a transaction set, build up
the transaction with packages, which are stored as transaction elements within
the transaction set, check for unresolved dependencies, reorder the transaction
set based on the dependencies, and then run the transaction set. Running the
transaction set installs or upgrades the packages. The following sections cover
these steps.


## Building up the transaction set

Package installs and upgrades need to be performed within the context of a
transaction set. To install or upgrade a set of packages, you need to call
`addInstall` with the package headers to install or upgrade. The basic syntax
follows:

```python
ts.addInstall(header, key_data, mode)
```

When you call `addInstall`, you pass the header object along with arbitrary
callback key data and a mode flag. The mode flag should be `'i'` to install a
package, `'u'` to upgrade a package, or `'a'` as a special code to make a
package available for transaction checks but not install or upgrade the
package. The `'a'` flag is rarely used. In most cases, you should use `'u'`,
just as in most cases, you should install packages with `rpm –U` instead of
`rpm –i`.

The `key_data` parameter will get passed to the transaction set run callback,
covered in the “Running the Transaction” section later in this chapter.

Note: To remove packages instead of install or upgrade, call `addErase` instead
of `addInstall`:

```python
ts.addErase(package_name)
```

To set up a package to be upgraded or installed, you can use code like the
following:

```python
h = read_rpm_header(ts, sys.argv[1])
ts.addInstall(h, sys.argv[1], "u")
```

This example expects a package file name on the command line (accessed with
`sys.argv[1]`), and reads in the package header using the `readRpmHeader`
function introduced previously.

The call to `addInstall` adds the header object (and the associated RPM package
file) for an upgrade with the `'u'` mode flag. The name of the package file,
from `sys.argv[1]`, is passed as the arbitrary data for the transaction set run
callback function.


## Transaction elements

Transaction sets are made up of transaction elements. A transaction element
makes up one part of a transaction and holds one package per operation (install
or remove) in each transaction set. That is, there is one transaction element
per package per operation in the transaction set. You can iterate over a
transaction set to get each transaction element. Once you have a transaction
element, you can call methods on each element to check entries in the header as
well as get dependency sets for the package.

The following table lists the informational methods you can call on a
transaction element. Most of the listed methods return a single value.

Table 17-4 Informational methods on transaction sets

| Method | Returns                                            |
|--------|----------------------------------------------------|
| `A`    | Returns package architecture                       |
| `E`    | Returns package epoch                              |
| `O`    | Returns package operating system                   |
| `R`    | Returns package release number                     |
| `V`    | Returns package version                            |
| `N`    | Returns package name                               |
| `NEVR` | Returns package name-epoch-version-release         |
| `DS`   | Returns the package dependency set for a given tag |
| `FI`   | Returns the file info set for the package          |

For more complex checking, the DS method returns the package dependency set for
a given tag:

```python
ds = te.DS(tag_name)
```

Pass one of `'Providename'`, `'Requirename'`, `'Obsoletename'`, or
`'Conflictname'` for the tag name. For example:

```python
ds = te.DS('Requirename')
```

The `Files` method returns the file info set for the package:

```python
for f in te.Files(tag_name):
    print(f.name)
```

This example shows how to iterate through a transaction set to get transaction
elements.

```python
#!/usr/bin/python
# Adds all package files on command line to a transaction
# and prints out the transaction elements.
# Usage:
# python te.py rpm_file1.rpm rpm_file2.rpm ...

import os
import sys
import rpm

def read_rpm_header(ts, filename):
    fd = os.open(filename, os.O_RDONLY)
    try:
        h = ts.hdrFromFdno(fd)
    finally:
        os.close(fd)
    return h

ts = rpm.TransactionSet()

# Set to not verify DSA signatures.
ts.setVSFlags(rpm._RPMVSF_NOSIGNATURES)

for filename in sys.argv[1:]:
    h = read_rpm_header(ts, filename)
    print("Installing {0}".format(h[rpm.RPMTAG_NVR]))
    ts.addInstall(h, filename, 'i')

print("This will install:")
for te in ts:
    print("{0}-{1}-{2}".format(te.N(), te.V(), te.R()))

ts.check()
ts.order()

print("This will install:")
for te in ts:
    print("{0}-{1}-{2}".format(te.N(), te.V(), te.R()))
```

The `te.py` script sets up a transaction and then prints out the elements, never
completing the transaction. The purpose here is just to show what is in the
transaction. The second set of printed output shows the results of the check and
order methods, covered in the following section.


## Checking and reordering the transaction elements

After you have called `addInstall` or `addErase` for each of the packages you
want to install, upgrade, or remove, you need to call two methods to verify the
transaction set and order all the elements properly. These two methods are
`check` and `order`.


## Checking the Dependencies

The check method checks the dependencies in a transaction set.

```python
unresolved_dependencies = ts.check()
```

It returns `None` if all dependencies are resolved, or a complex tuple for each
unresolved dependency. In general, if the check method returns anything but
`None`, you cannot perform the transaction.

On a dependency failure, check returns a complex tuple of the dependency
information in the following format:

```
((N,V,R), (reqN, reqV), needsFlags, suggestedPackage, sense)
```

The first element is a tuple of the name, version, and release of the package
you are trying to install. The next tuple holds the required name and required
version or conflicting name and version. The version will be `None` if the
dependency is a shared library or other file.

The `needsFlags` tells you about the requirement or conflict. The value is a
bitmask that can contain the following bit settings: `rpm.RPMSENSE_EQUAL`,
`rpm.RPMSENSE_GREATER`, and `rpm.RPMSENSE_LESS`. This tells you if the
dependency is for a version of a package greater than 4.1, for example.

The `suggestedPackage` names a package that solves the dependency. The
considered packages are those for which you call `addInstall` with a flag of
`'a'`. This value will be `None` if there is no known package to solve this
dependency.

You can tell whether the dependency is a conflict or a requirement based on the
sense value, one of `rpm.RPMSENSE_CONFLICTS` or `rpm.RPMSENSE_REQUIRES`.

For example, the following tuple shows a required package:

```
(('eruby-devel', '0.9.8', '2'), ('eruby-libs', '0.9.8'), 8, None, 0)
```

The following tuple shows a required shared library:

```
(('jpilot', '0.97', '1'), ('libpisock.so.3', None), 0, None, 0)
```

Note: This tuple format will likely change in future versions of RPM. This
example shows the format in RPM 4.1. With each RPM release, check the online
documentation on the Python API to look for changes.


## Transaction Check Method Callbacks

You can pass an optional callback function to the call to check. This callback
gets called for each unresolved dependency in the transaction set. You can use
this callback to try to automatically bring in required packages, for example.

The basic syntax for the transaction check callback is:

```python
def check_callback(ts, TagN, N, EVR, Flags):
    # Do something...
    pass
```

Such a callback can be used like this:

```python
ts = rpm.TransactionSet()
...
unresolved_dependencies = ts.check(check_callback)
```

A full example:

```python
def check_callback(ts, TagN, N, EVR, Flags):
    if TagN == rpm.RPMTAG_REQUIRENAME:
        prev = ""
    Nh = None

    if N[0] == "/":
        dbitag = "basenames"
    else:
        dbitag = "providename"

    # What do you need to do.
    if EVR:
        print("Must find package [", N, "-", EVR, "]")
    else:
        print("Must find file [", N, "]")

    # FIXME
    # if resolved:
    #     # ts.addIntall(h, h, 'i')
    #     return -1

    return 1
```

Depending on the values passed to the callback, your code must either find a
package itself or a package that provides a given file or capability to resolve
the dependency. If you have another RPM database to look at, such as the
`rpmdb-redhat` database, you can use `dbMatch` to find the necessary packages in
that database. If, however, you are working with a directory of RPM files, you
need to build up file names from the package name, version, and release.


## Reordering the Transaction Set

You can add packages to a transaction set in any order. The `order` method
reorders the transaction set to ensure that packages get installed or removed in
the right order. The order method orders by a topological sort using the
dependencies relations between objects with dependency comparisons.

Note: You must call `check` prior to `order`.


## Running the transaction

After setting up the transaction set, perform the transaction by calling
run. You need to provide two parameters:

```python
ts.run(callback, client_data)
```

The `callback` parameter must be a Python function. The `client_data` is any
data you want to pass to the callback. There may be more than one package in the
transaction set, so this data should not be specific to a particular package.

Warning: You must not pass `None` as the `client_data` or you will get a Python
error.


## Transaction run Method Callbacks

The callback you pass to the run method on a transaction set is essential. Your
callback must work properly, or the transaction will fail. You must provide a
callback.

Your callback will get called a number of times, mostly as a means to report
progress. If you are writing a graphical user interface, for example, you can
use the progress callbacks to update a visual progress meter.

The basic syntax for the transaction set run callback is:

```python
def run_callback(reason, amount, total, key, client_data):
    # Do your stuff...
    pass
```

The `key` is the data you provided in the call to the `addInstall` method. The
`client_data` is the data you passed to the `run` method.

Each time your callback is called, the transaction set will provide a reason
flag. The following table lists the values for the reason parameter.

| Value                              | Reason                             |
|------------------------------------|------------------------------------|
| rpm.RPMCALLBACK_UNKNOWN            | Unknown problem                    |
| rpm.RPMCALLBACK_INST_PROGRESS      | Progress for installation          |
| rpm.RPMCALLBACK_INST_START         | Start of installation              |
| rpm.RPMCALLBACK_INST_OPEN_FILE     | Callback should open package file  |
| rpm.RPMCALLBACK_INST_CLOSE_FILE    | Callback should close package file |
| rpm.RPMCALLBACK_TRANS_PROGRESS     | Transaction progress               |
| rpm.RPMCALLBACK_TRANS_START        | Transaction start                  |
| rpm.RPMCALLBACK_TRANS_STOP         | Transaction stop                   |
| rpm.RPMCALLBACK_UNINST_PROGRESS    | Uninstallation progress            |
| rpm.RPMCALLBACK_UNINST_START       | Uninstallation start               |
| rpm.RPMCALLBACK_UNINST_STOP        | Uninstallation stop                |
| rpm.RPMCALLBACK_REPACKAGE_PROGRESS | Repackaging progress               |
| rpm.RPMCALLBACK_REPACKAGE_START    | Repackaging start                  |
| rpm.RPMCALLBACK_REPACKAGE_STOP     | Repackaging stop                   |
| rpm.RPMCALLBACK_UNPACK_ERROR       | Error unpacking package file       |
| rpm.RPMCALLBACK_CPIO_ERROR         | cpio error getting package payload |

Your callback must handle at least two cases - a reason value of
`rpm.RPMCALLBACK_INST_OPEN_FILE` and `rpm.RPMCALLBACK_INST_CLOSE_FILE.`

With the reason of `rpm.RPMCALLBACK_INST_OPEN_FILE`, you must open the RPM
package file and return a file descriptor for the file. You need to keep this
file descriptor in a global-scope or otherwise-accessible variable, because with
the reason of `rpm.RPMCALLBACK_INST_CLOSE_FILE`, you must close this file.


## Coding A Sample Callback

The following code shows a valid sample callback for upgrading and installing
packages.

```python
# Global file descriptor for the callback.
rpmtsCallback_fd = None

def run_callback(reason, amount, total, key, client_data):
    global rpmtsCallback_fd
    if reason == rpm.RPMCALLBACK_INST_OPEN_FILE:
        print("Opening file. ", reason, amount, total, key, client_data)
        rpmtsCallback_fd = os.open(key, os.O_RDONLY)
        return rpmtsCallback_fd
    elif reason == rpm.RPMCALLBACK_INST_START:
        print("Closing file. ", reason, amount, total, key, client_data)
        os.close(rpmtsCallback_fd)
```

This callback assumes that the call to `addInstall` passed client data of the
package file name. This callback ignores the `client_data` passed to the run
method, but this is a perfect slot for passing an object. You can use this, for
example, to avoid having a global variable for the file descriptor.


## Upgrading A Package

This example shows a simple Python script to upgrade or install a package.

```python
#!/usr/bin/python
# Upgrades packages passed on the command line.
# Usage:
# python rpmupgrade.py rpm_file1.rpm rpm_file2.rpm ...
#

import os
import sys
import rpm

# Global file descriptor for the callback.
rpmtsCallback_fd = None


def run_callback(reason, amount, total, key, client_data):
    global rpmtsCallback_fd
    if reason == rpm.RPMCALLBACK_INST_OPEN_FILE:
        print("Opening file. ", reason, amount, total, key, client_data)
        rpmtsCallback_fd = os.open(key, os.O_RDONLY)
        return rpmtsCallback_fd
    elif reason == rpm.RPMCALLBACK_INST_START:
        print("Closing file. ", reason, amount, total, key, client_data)
        os.close(rpmtsCallback_fd)


def check_callback(ts, TagN, N, EVR, Flags):
    if TagN == rpm.RPMTAG_REQUIRENAME:
        prev = ""
    Nh = None

    if N[0] == "/":
        dbitag = "basenames"
    else:
        dbitag = "providename"

    # What do you need to do.
    if EVR:
        print("Must find package [", N, "-", EVR, "]")
    else:
        print("Must find file [", N, "]")

    # FIXME
    # if resolved:
    #     # ts.addIntall(h, h, 'i')
    #     return -1

    return 1


def read_rpm_header(ts, filename):
    fd = os.open(filename, os.O_RDONLY)
    try:
        h = ts.hdrFromFdno(fd)
    finally:
        os.close(fd)
    return h


ts = rpm.TransactionSet()

# Set to not verify DSA signatures.
ts.setVSFlags(-1)

for filename in sys.argv[1:]:
    h = read_rpm_header(ts, filename)
    print("Upgrading {0}".format(h[rpm.RPMTAG_NVR]))
    ts.addInstall(h, filename, "u")

unresolved_dependencies = ts.check(check_callback)

if not unresolved_dependencies:
    ts.order()

    print("This upgrade will install:")
    for te in ts:
        print("{0}-{1}-{2}".format(te.N(), te.V(), te.R()))

    print("Running transaction (final step)...")
    ts.run(run_callback, 1)
else:
    print("Error: Unresolved dependencies, transaction failed.")
    print(unresolved_dependencies)
```

This script expects the name of an RPM package file on the command line, and
attempts to upgrade the package. (This will also install new packages.)
When you run the `rpmupgrade.py` script as root, you should see output like the
following:

```
# rpm -q neovim
neovim-0.10.2-1.fc41.x86_64

# python rpmupgrade.py neovim-0.10.4-1.fc41.x86_64.rpm
Upgrading neovim-0.10.4-1.fc41
This upgrade will install:
neovim-0.10.4-1.fc41
neovim-0.10.2-1.fc41
Running transaction (final step)...
Opening file.  4 0 0 neovim-0.10.4-1.fc41.x86_64.rpm 1
Opening file.  4 0 0 neovim-0.10.4-1.fc41.x86_64.rpm 1
Closing file.  2 0 30870644 neovim-0.10.4-1.fc41.x86_64.rpm 1

# rpm -q neovim
neovim-0.10.4-1.fc41.x86_64
```

This example shows that the package was upgraded after running the
`rpmupgrade.py` script. Note that with an upgrade, the original package,
`neovim-0.10.2-1` in this case, is also added to the transaction set. With an
install, this is not the case. That’s because the original package is removed as
part of the transaction.

If you run this script as a non-root user, you will likely see an error like the
following:

```
$ python rpmupgrade.py neovim-0.10.4-1.fc41.x86_64.rpm
Upgrading neovim-0.10.4-1.fc41
This upgrade will install:
neovim-0.10.4-1.fc41
neovim-0.10.2-1.fc41
Running transaction (final step)...
error: can't create transaction lock on /usr/lib/sysimage/rpm/.rpm.lock (Permission denied)
```

If a package has a dependency on a file such as a shared library, you will see
output like the following:

```
# python rpmupgrade.py neovim-0.10.4-1.fc41.x86_64.rpm
Upgrading neovim-0.10.4-1.fc41
Must find file [ libluv.so.1()(64bit) ]
Error: Unresolved dependencies, transaction failed.
[(('neovim', '0.10.4', '1.fc41'), ('libluv.so.1()(64bit)', ''), 0, None, 0)]
```

If a package has a dependency on another package, you will see output like the
following:

```
# python rpmupgrade.py eruby-devel-0.9.8-2.i386.rpm
Upgrading eruby-devel-0.9.8-2
Must find package [ eruby-libs - 0.9.8 ]
Error: Unresolved dependencies, transaction failed.
(('eruby-devel', '0.9.8', '2'), ('eruby-libs', '0.9.8'), 8, None, 0)
```

## Where to Go from Here

The RPM bindings for Python are documented along with the C programming API. You
can find the documentation at <http://ftp.rpm.org/api/>.

Note that much of this online documentation covers the C functions that provide
the Python bindings, not the Python API itself. But, if you examine the online
information on objects listed as classes, such as rpmts, you can find the
Python-specific documentation.

Furthermore, if you look into the `.c` files that make up the Python bindings,
you can find `PyMethodDef` structure tables. These tables provide useful
glimpses into the Python API.


## Resources

- [RPM Python][slides-paul-nasrat] slideset / tutorial by Paul Nasrat (2004)
- [Programming RPM with Python][slides-rpm-guide] from Fedora RPM Guide



[slides-paul-nasrat]: https://web.archive.org/web/20170608211215/http://www.ukuug.org/events/linux2004/programme/paper-PNasrat-1/rpm-python-slides/frames.html
[slides-rpm-guide]: https://web.archive.org/web/20170608211215/docs.fedoraproject.org/en-US/Fedora_Draft_Documentation/0.1/html//RPM_Guide/ch-rpm-programming-python.html
[rpm-examples]: https://github.com/rpm-software-management/rpm/tree/master/python/examples
[rpm-q]: https://github.com/rpm-software-management/rpm/blob/master/python/examples/rpm-q.py
[rpm-qi]: https://github.com/rpm-software-management/rpm/blob/master/python/examples/rpm-qi.py
[rpm-qa]: https://github.com/rpm-software-management/rpm/blob/master/python/examples/rpm-qa.py
[rpm-i]: https://github.com/rpm-software-management/rpm/blob/master/python/examples/rpm-i.py
[rpm-e]: https://github.com/rpm-software-management/rpm/blob/master/python/examples/rpm-e.py

[chapter-4]: https://web.archive.org/web/20170608211215/https://docs.fedoraproject.org/en-US/Fedora_Draft_Documentation/0.1/html/RPM_Guide/ch-using-rpm-db.html
[chapter-15]: https://web.archive.org/web/20170608211215/https://docs.fedoraproject.org/en-US/Fedora_Draft_Documentation/0.1/html/RPM_Guide/ch-programming-c.html
[chapter-17]: https://web.archive.org/web/20170608211215/https://docs.fedoraproject.org/en-US/Fedora_Draft_Documentation/0.1/html/RPM_Guide/ch-programming-perl.html

[printing-information-on-packages]: #printing-information-on-packages
