---
layout: default
title: rpm.org - Python RPM
---

# Programming RPM with Python

## Summary
This chapter introduces the high-level RPM API for Python programming. You can
use this API from Python scripts to perform RPM functionality, just as you can
write C programs using the RPM C API covered in Chapter 15, Programming RPM with
C.

In general, the Python API is simpler and requires fewer code statements than
the corresponding functionality in the C API.

Just about all of your work with the Python API requires a transaction set,
which you can get by calling rpm.TransactionSet.

To query the RPM database, call dbMatch on the transaction set object. To
install or upgrade packages, call addInstall, check, order, and run on the
transaction set.

The next chapter switches to another language for accessing the RPM system:
Perl. With the rich set of APIs, you can write your RPM programs in C, Python,
Perl, or any language that can call on code written in one of these languages.


## Setting Up a Python Development Environment

Setting up a Python development environment is much the same as setting up a C
programming environment. You need to install a set of packages for general
Python development, install a package that provides the Python API to the RPM
system, and choose a program for
editing your Python scripts.


## Installing the base Python packages

The base Python package needed for developing applications is python. For RPM
usage, you should install Python 2.2, not Python 1.5. That’s because the RPM
bindings for Python are moving to support only 2.2 and higher releases.

The Python package for RPM access is rpm-python. Install these as you would any
other packages.

Cross Reference
Chapter 3, Using RPM covers installing packages.


## Using Python for graphics

Python supports a number of different toolkits for creating graphical user
interfaces. You need one of these toolkits if you want to create Python
applications that sport a user interface instead of command-line tools. Among
the most popular toolkits are PyGKT, PyQt, and Tkinter.

*PyGTK is a binding between Python and the GTK+ toolkit used by the GNOME
desktop, one of two main desktop environments for Linux. (KDE is the other main
desktop environment.) The Red Hat redhat-config-packages program uses PyGTK and
sports a very good-looking user interface.

PyGTK provides full access to the GTK+ widgets such as menus, dialog windows,
and buttons. Install the pygtk2 module for PyGTK. For more on PyGTK, see
www.daa.com.au/~james/pygtk/.

*PyQt connects Python scripts to the Qt C++ user interface toolkit. Qt forms the
base library used by the KDE desktop environment and KDE applications. As with
PyGTK, PyQt allows you to access the rich widget set provided by the library.

Install the PyQt package for PyQt. For more on PyQt, see
www.riverbankcomputing.co.uk/pyqt/.

*Tkinter is considered a standard part of Python and is based on the Tk
(pronounced teekay) toolkit from the Tcl scripting language. The main advantages
of Tkinter are that it is considered part of Python, meaning users are more
likely to have it, and Tkinter works on multiple platforms, including Windows.

The main drawback of Tkinter is that the widget sets are not as rich as PyQt or
PyGTK. For more on Tkinter, see www.python.org/topics/tkinter/.

After you’ve set up your environment and installed all the necessary packages,
the next step is to start working with the Python API for RPM.


## Programming with the RPM Database

Compared to the RPM C API, discussed in Chapter 15, Programming RPM with C , the
Python API is much simpler and requires many fewer programming statements to get
your job done.  Just about every Python RPM script needs a transaction
set. Create a transaction set with rpm.TransactionSet:

```
import rpm
ts = rpm.TransactionSet()
```

The transaction set will automatically open the RPM database if needed.


Note: The code examples in this chapter follow the Red Hat conventions for naming
variables, such as ts for a transaction set. This is to make it easier to read
the Python examples in the RPM sources, along with Red Hat installer programs
written in Python.

You will need a transaction set in just about every Python
script that accesses RPM functionality.


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

You can work with more than one RPM database by setting the _dbpath macro,
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

This example uses the rpmdb-redhat package, which holds a database of all Red
Hat Linux packages. The explicit call to openDB opens the RPM database. In most
Python scripts, though, you do not want to call openDB. Instead, a transaction
set will open the database as needed.  The call to delMacro removes the _dbpath
macro, allowing the next call to TransactionSet to use the default RPM database.

Note: Do not call closeDB on a transaction set. This method does indeed close
the RPM database, but it also disables the ability to automatically open the RPM
database as needed.


## Initializing, Rebuilding, and Verifying the Database

The transaction set provides an initDB method to initialize a new RPM
database. This acts like the rpm `--initdb` command.

```python
ts.initDB()
```

The rebuildDB method regenerates the RPM database indices, like the rpm
`--rebuilddb` command:

```python
ts.rebuildDB()
```

The rebuildDB method regenerates the RPM database indices, like the rpm
`--rebuilddb` command.

The verifyDB method checks that the RPM database and indices are readable by the
Berkeley DB library:

```python
ts.verifyDB()
```

Calling this method is the same as running the `db_verify` command on each of
the database files in `/var/lib/rpm`.

Cross Reference See Chapter 4, Using the RPM Database for more on initializing,
rebuilding, and verifying RPM databases.

Once you have a transaction set, you can start querying the RPM database.


## Querying the RPM database

Call dbMatch on a transaction set to create a match iterator. As with the C API,
a match iterator allows your code to iterate over the packages that match a
given criteria.

A call to dbMatch with no parameters means to set up a match iterator to go over
the entire set of installed packages. The basic format follows:

```python
import rpm
ts = rpm.TransactionSet()
mi = ts.dbMatch()
for h in mi:
    # Do something with header object...
```

In this example, the call to dbMatch returns a match iterator. The for loop
iterates over the match iterator, returning one header each time.

In addition to this syntax, you can call next on the match iterator to get the
next entry, a header object that represents one package. For example:

```python
import rpm
ts = rpm.TransactionSet()
mi = ts.dbMatch()
while mi:
    h = mi.next()
    # Do something with the header object
    pass
```

The explicit call to next on the match iterator will likely no longer be
supported in a future version of the RPM Python API, since the PEP-234 (Python
Enhancement Proposal) calls for one means or the other for iterating, but not
both.

For example, Listing 17-1 shows a Python script to print out the name, version,
and release information for all installed packages.

Listing 17-1: rpmqa.py

```python
#!/usr/bin/python
# Acts like rpm -qa and lists the names of all the installed packages.
# Usage:
# python rpmqa.py

import rpm

ts = rpm.TransactionSet()
mi = ts.dbMatch()
for h in mi:
    print "%s-%s-%s" % (h['name'], h['version'], h['release'])
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

Note: If you set the execute permission on this script, you can skip the
explicit call to the python command. For example:

```
$ ./rpmqa.py
```

## The hdr Class

You can access each entry in the header using Python's dictionary syntax. This
is much more convenient than calling headerGetEntry in C programs. The basic
syntax to access header entries follows:

```python
value = h['tag_name']
```

For example, to get the package name, use the following code:

```python
name = h['name']
```

You can also use a set of predefined `RPMTAG_` constants that match the C
API. These constants are defined in the `rpm` module. For example:

```python
name = h[rpm.RPMTAG_NAME]
```

Note: Using the rpm constants such as `rpm.RPMTAG_NAME` is faster than using the
strings such as `'name'`.

For header entries that hold an array of strings, such as the list of files in
the package, the data returned is a Python list. For example:

```python
print "Files:"
files = h['FILENAMES']
for name in files:
    print name
```

You can use file info sets to achieve more compact code. For example:

```python
print "Files:"
fi = h.fiFromHeader()
print fi
```

The requires, provides, obsoletes, and conflicts information each appear as
three separate but related lists for each set of information, with three lists
for the requires information, three for the provides information, and so on. You
can extract this information using Python dependency sets using the simple code
following:

```python
print h.dsFromHeader('providename')
print h.dsFromHeader('requirename')
print h.dsFromHeader('obsoletename')
print h.dsFromHeader('conflictname')
```

Cross Reference
The `rpminfo.py` script in Listing 17-3 shows how to print out this information.


## Printing Header Information with sprintf

In addition to using the Python dictionary syntax, you can use the sprintf
method on a header to format data using a syntax exactly the same as the query
format tags supported by the rpm command.

Cross Reference
Chapter 4, Using the RPM Database covers query formats.

The basic syntax is as follows:

```
h.sprintf("%{tag_name}")
```

You can also use special formatting additions to the tag name. For example:

```
print "Header signature: ", h.sprintf("%{DSAHEADER:pgpsig}")
print "%-20s: %s" % ('Installed on', h.sprintf("%{INSTALLTID:date}") )
```

You can combine this information into functions that print out header entries
with specific formatting. For example:

```python
def nvr(h):
    return h.sprintf("%{NAME}-%{VERSION}-%{RELEASE}")
```

Note that you only really need to use sprintf when you need the format
modifiers, such as date on `%{INSTALLTID:date}`. In most other cases, Python’s
string-handling functions will work better.


## Querying for specific packages

When you call dbMatch on a transaction set object, passing no parameters means
to iterate over the entire set of installed packages in the RPM database. You
can also query for specific packages using dbMatch. To do so, you need to pass
the name of a tag in the header, as well as the value for that tag that you are
looking for. The basic syntax follows:

```python
mi = ts.dbMatch(tag_name, value)
```

For example, to query for all packages named sendmail, use code like the
following:

```
mi = ts.dbMatch('name', 'sendmail')
```

The call to `dbMatch` returns an `rpmdbMatchIterator`. You can query on any of
the tags in the header, but by far the most common query is by name.

Note: Some matches are fast and some are much slower. If you try to match on a
tag that is indexed in the RPM database, the matches will perform much faster
than for those tags that are not indexes. To determine which tags are indexed,
look at the files in /var/lib/rpm. For example, Name and Requirename are files
in /var/lib/rpm. These tags are indexed and will therefore match quickly.

Listing 17-2 shows an example Python script which queries for a particular
package name and then prints out the name, version, and release for all matching
packages.

Listing 17-2: rpmq.py

```python
#!/usr/bin/python
# Acts like rpm -q and lists the N-V-R for installed
# packages that match a given name.
# Usage:
# python rpmq.py package_name
import sys

import rpm

ts = rpm.TransactionSet()
mi = ts.dbMatch( 'name', sys.argv[1] )
for h in mi:
    print "%s-%s-%s" % (h['name'], h['version'], h['release'])
```

When you call this script, you need to pass the name of a package to query,
which the python interpreter will store in sys,argv[1] in the call to
dbMatch. For example:

```
$ python rpmq.py sendmail
sendmail-8.12.5-7
```


## Printing information on packages

You can create the equivalent of the `rpm –qi` command with a small number of
Python commands. Listing 17-3 shows an example. This script queries for a
particular package name, as shown previously in Listing 17-2. Once a package is
found, though, rpminfo.py prints out a lot more information, similar to the
output from the `rpm –qi` command.

Listing 17-3: rpminfo.py

```python
#!/usr/bin/python
# Lists information on installed package listed on command line.
# Usage:
# python rpminfo.py package_name
import sys

import rpm

def printEntry(header, label, format, extra):
    value = header.sprintf(format).strip()
    print "%-20s: %s %s" % (label, value, extra)

def printHeader(h):
    if h[rpm.RPMTAG_SOURCEPACKAGE]:
        extra = " source package"
    else:
        extra = " binary package"
    printEntry(h, 'Package', "%{NAME}-%{VERSION}-%{RELEASE}", extra)
    printEntry(h, 'Group', "%{GROUP}", '')
    printEntry(h, 'Summary', "%{Summary}", '')
    printEntry(h, 'Arch-OS-Platform', "%{ARCH}-%{OS}-%{PLATFORM}", '')
    printEntry(h, 'Vendor', "%{Vendor}", '')
    printEntry(h, 'URL', "%{URL}", '')
    printEntry(h, 'Size', "%{Size}", '')
    printEntry(h, 'Installed on', "%{INSTALLTID:date}", '')
    print h['description']
    print "Files:"
    fi = h.fiFromHeader()
    print fi

    # Dependencies
    print "Provides:"
    print h.dsFromHeader('providename')

    print "Requires:"
    print h.dsFromHeader('requirename')

    if h.dsFromHeader('obsoletename'):
        print "Obsoletes:"
        print h.dsFromHeader('obsoletename')

    if h.dsFromHeader('conflictname'):
        print "Conflicts:"
        print h.dsFromHeader('conflictname')

ts = rpm.TransactionSet()
mi = ts.dbMatch( 'name', sys.argv[1] )
for h in mi:
    printHeader(h)
```

Note: You should be able to simplify this script. The extensive use of the
sprintf method is for illustration more than efficiency. You generally only need
to call sprintf when you need a format modifier for a tag. In the rpminfo.py
script, sprintf was also used to ensure that all entries are text, which allows
for calling strip.

The `printEntry` function takes in a header `sprintf` tag value in the format of
`"%{NAME}"`. You can also pass in more complex values with multiple header
entries, such as `"%{NAME}-%{VERSION}"`.

When you run this script, you need to pass the name of a package. You'll see
output like the following:

```
$ python rpminfo.py jikes
Package : jikes-1.18-1 binary package
Group : Development/Languages
Summary : java source to bytecode compiler
Arch-OS-Platform : i386-Linux-(none)
Vendor : (none)
URL : http://ibm.com/developerworks/opensource/jikes
Size : 2853672
Installed on : Mon Dec 2 20:10:13 2002
The IBM Jikes compiler translates Java source files to bytecode. It
also supports incremental compilation and automatic makefile
generation,and is maintained by the Jikes Project:
http://ibm.com/developerworks/opensource/jikes/
Files:
/usr/bin/jikes
/usr/doc/jikes-1.18/license.htm
/usr/man/man1/jikes.1.gz
Provides:
P jikes
P jikes = 1.18-1
Requires:
R ld-linux.so.2
R libc.so.6
R libc.so.6(GLIBC_2.0)
R libc.so.6(GLIBC_2.1)
R libc.so.6(GLIBC_2.1.3)
R libm.so.6
R libstdc++-libc6.2-2.so.3
```


## Refining queries

The pattern method on a match iterator allows you to refine a query. This
narrows an existing iterator to only show the packages you desire. The basic
syntax follows:

```python
mi.pattern(tag_name, mode, pattern)
```

The two main uses of the pattern method are to query on more than one tag, such
as the version and name, or to narrow the results of a query, using the rich set
of pattern modes. The mode parameter names the type of pattern used, which can
be one of those listed in Table 17-2.

Table 17-2 Pattern modes for the pattern method

| Type                  | Meaning                                                      |
|-----------------------|--------------------------------------------------------------|
| `rpm.RPMMIRE_DEFAULT` | Same as regular expressions, but with \., .*, and ^..$ added |
| `rpm.RPMMIRE_GLOB`    | Glob-style patterns using fnmatch                            |
| `rpm.RPMMIRE_REGEX`   | Regular expressions using regcomp                            |
| `rpm.RPMMIRE_STRCMP`  | String comparisons using strcmp                              |

Cross Reference
For more on these patterns, see the online manual pages for fnmatch(3), glob(7),
regcomp(3), regex(7), and strcmp(3). The pattern method calls rpmdbSetIteratorRE
from the C API, covered in the “Database Iterators” section in Chapter 15,
Programming RPM with C .

To query for all packages starting with py, for example, you can use code like
the following:

```python
import rpm
ts = rpm.TransactionSet()
mi = ts.dbMatch()
mi.pattern('name', rpm.RPMMIRE_GLOB, 'py*' )
for h in mi:
    # Do something with the header...
    pass
```

Listing 17-4 shows an example for glob-based querying.
Listing 17-4: rpmglob.py

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
    print "No packages found."
else:
    mi.pattern('name', rpm.RPMMIRE_GLOB, sys.argv[1] )
    for h in mi:
        print "%s-%s-%s" % (h['name'], h['version'], h['release'])
```

When you run this script, you’ll see output like the following:

```
$ python rpmglob.py "py*"
pyxf86config-0.3.1-2
python-devel-2.2.1-17
pygtk2-devel-1.99.12-7
pygtk2-libglade-1.99.12-7
pygtk2-1.99.12-7
pyOpenSSL-0.5.0.91-1
python-optik-1.3-2
python-docs-2.2.1-17
python-2.2.1-17
python-tools-2.2.1-17
```

In addition to working with the RPM database, the Python API also provides
access to RPM files.


## Reading Package Files

As you would expect, the Python API includes methods for working with RPM
package files in addition to installed RPM packages. Most of these methods
require a header object, which you can read from an RPM package file.


## Reading headers from package files

Like the C function rpmReadPackageFile, the Python API provides a convenient way
to read in a header object from an RPM package file. The hdrFromFdno method
reads an RPM header from an open file descriptor. The basic syntax is:

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
def readRpmHeader(ts, filename):
    """ Read an rpm header. """
    fd = os.open(filename, os.O_RDONLY)
    h = ts.hdrFromFdno(fd)
    os.close(fd)
    return h

ts = rpm.TransactionSet()
h = readRpmHeader( ts, 'n-v-r.rpm' )
```

The `hdrFromFdno` method raises a number of exceptions based on issues detected
with the package files. The following example shows these exceptions:

```python
def readRpmHeader(ts, filename):
    """ Read an rpm header. """
    fd = os.open(filename, os.O_RDONLY)
    h = None
    try:
        h = ts.hdrFromFdno(fd)
    except rpm.error, e:
        if str(e) == "public key not available":
            print str(e)
        if str(e) == "public key not trusted":
            print str(e)
        if str(e) == "error reading package header":
            print str(e)
        h = None
    finally:
        os.close(fd)
    return h

ts = rpm.TransactionSet()
h = readRpmHeader( ts, 'n-v-r.rpm' )
```

You can decide in your code whether the exceptions should stop processing or
not.


## Setting the verification flags

Starting with rpm 4.1, package files are verified automatically, which can cause
problems, especially if you are working with older packages, or packages without
proper digital signatures.

In most cases, the automatic verification is an advantage, since you can have
greater confidence in the package files. However, you can call setVSFlags on a
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

Table 17-3 lists the flags you can pass to setVSFlags on a transaction
set. These flags are bitmasks. You can or them together for more than one
setting. You must do a binary or. Do not use the Python or keyword. Use |
instead, for a binary or operation.

Table 17-3 Flags for setVSFlags

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

To turn off all checks, you can pass –1 to setVSFlags:

```python
ts.setVSFlasgs(-1)
```


## Dependency Comparisons

Dependency sets, first introduced in Chapter 15, Programming RPM with C on C
programming, allow you to compare the dependencies between two packages. One of
the most common uses for this is to compare a package file against a version on
disk to see if the package file holds a newer version of a package than the one
installed.

You can call dsOfHeader on a header object to get the default dependency set for
the header. Armed with dependency sets from two headers, you can compare the
sets to see which package is newer using simple code like the following:

```python
file_h = ts.hdrFromFdno(fd)
file_ds = file_h.dsOfHeader()
inst_ds = inst_h.dsOfHeader()
if file_ds.EVR() >= inst_ds.EVR():
    print "Package file is same or newer, OK to upgrade."
else:
    print "Package file is older than installed version."
```

Pulling this all together, Listing 17-5 provides a Python script that compares a
package file against an installed package, reporting on which is newer.

Listing 17-5: vercompare.py

```python
#!/usr/bin/python
# Reads in package header, compares to installed package.
# Usage:
# python vercompare.py rpm_file.rpm
#
import os
import sys

import rpm
def readRpmHeader(ts, filename):
    """ Read an rpm header. """
    fd = os.open(filename, os.O_RDONLY)
    try:
        h = ts.hdrFromFdno(fd)
    finally:
        os.close(fd)
    return h

ts = rpm.TransactionSet()
h = readRpmHeader( ts, sys.argv[1] )
pkg_ds = h.dsOfHeader()
for inst_h in ts.dbMatch('name', h['name']):
    inst_ds = inst_h.dsOfHeader()
    if pkg_ds.EVR() >= inst_ds.EVR():
        print "Package file is same or newer, OK to upgrade."
    else:
        print "Package file is older than installed version."
```

Cross-Reference
The Python script in Listing 17-5 is essentially the same as the longer C
program vercompare.c in Listing 16-4 in Chapter 15, Programming RPM with C .

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
addInstall with the package headers to install or upgrade. The basic syntax
follows:

```python
ts.addInstall(header, key_data, mode)
```

When you call addInstall, you pass the header object along with arbitrary
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
h = readRpmHeader( ts, sys.argv[1] )
ts.addInstall(h, sys.argv[1], 'u')
```

This example expects a package file name on the command line (accessed with
sys.argv[1]), and reads in the package header using the readRpmHeader function
introduced previously.

The call to addInstall adds the header object (and the associated RPM package
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

Table 17-4 lists the informational methods you can call on a transaction
element. Most of the methods listed in Table 17-4 return a single value.

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

The `FI` method returns the file info set for the package:

```python
fi = te.FI(tag_name)
```

For the `FI` method, you must pass a tag name of `'Basenames'`.

As an example, Listing 17-6 shows how to iterate through a transaction set to
get transaction elements.

Listing 17-6: te.py

```python
#!/usr/bin/python
# Adds all package files on command line to a transaction
# and prints out the transaction elements.
# Usage:
# python te.py rpm_file1.rpm rpm_file2.rpm ...
#

import os
import sys

import rpm

def readRpmHeader(ts, filename):
    """ Read an rpm header. """
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
    h = readRpmHeader(ts, filename)
    print "Installing %s-%s-%s" % (h['name'], h['version'], h['release'])
    ts.addInstall(h, filename, 'i')

print "This will install:"
for te in ts:
    print "%s-%s-%s" % (te.N(), te.V(), te.R() )

ts.check()
ts.order()

print "This will install:"
for te in ts:
    print "%s-%s-%s" % (te.N(), te.V(), te.R() )
```

The `te.py` script sets up a transaction and then prints out the elements, never
completing the transaction. The purpose here is just to show what is in the
transaction. The second set of printed output shows the results of the check and
order methods, covered in the following section.


## Checking and reordering the transaction elements

After you have called addInstall or addErase for each of the packages you want
to install, upgrade, or remove, you need to call two methods to verify the
transaction set and order all the elements properly. These two methods are check
and order.


## Checking the Dependencies

The check method checks the dependencies in a transaction set.

```python
unresolved_dependencies = ts.check()
```

It returns None if all dependencies are resolved, or a complex tuple for each
unresolved dependency. In general, if the check method returns anything but
None, you cannot perform the transaction.

On a dependency failure, check returns a complex tuple of the dependency
information in the following format:

```
((N,V,R), (reqN, reqV), needsFlags, suggestedPackage, sense)
```

The first element is a tuple of the name, version, and release of the package
you are trying to install. The next tuple holds the required name and required
version or conflicting name and version. The version will be None if the
dependency is a shared library or other file.

The needs flags tell you about the requirement or conflict. The value is a
bitmask that can contain the following bit settings: `rpm.RPMSENSE_EQUAL`,
`rpm.RPMSENSE_GREATER`, and `rpm.RPMSENSE_LESS`. This tells you if the
dependency is for a version of a package greater than 4.1, for example.

The suggested package names a package that solves the dependency. The packages
considered are those for which you call addInstall with a flag of 'a'. This
value will be None if there is no known package to solve this dependency.

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

```
def checkCallback(ts, TagN, N, EVR, Flags):
    # Do something...
    pass
```

You can use a check callback to automatically bring in packages that are
required into a transaction set. You can bring in packages from the Red Hat RPM
database package, which contains a database of all Red Hat packages, the
rpmdb-redhat package. You can open the database from this package by using the
trick described previously for opening transactions to more than one RPM
database at a time. Simply set the _dbpath macro to
"/usr/lib/rpmdb/i386-redhat-linux/redhat", or the location of your rpmdb-redhat
database, and create a transaction set. Your check callback can then search this
extra database and add packages from that database into the current, real RPM
database.

Your check callback can also attempt to find package files to resolve
dependencies, from a disk directory or network archive for example. The
following code shows a stub check callback that you can fill in to try to
resolve dependencies. This callback sets up a format for finding unresolved
packages in another RPM database, or elsewhere. You need to fill in the skeleton
with the algorithm you want to actually resolve the dependencies.

```python
def checkCallback(ts, TagN, N, EVR, Flags):
    if TagN == rpm.RPMTAG_REQUIRENAME:
        prev = ""
    Nh = None

    if N[0] == '/':
        dbitag = 'basenames'
    else:
        dbitag = 'providename'

    # What do you need to do.
    if EVR:
        print "Must find package [", N, "-", EVR, "]"
    else:
        print "Must find file [", N, "]"

    if resolved:
        # ts.addIntall(h, h, 'i')
        return -1

    return 1
```

Depending on the values passed to the callback, your code must either find a
package itself or a package that provides a given file or capability to resolve
the dependency. If you have another RPM database to look at, such as the
rpmdb-redhat database, you can use dbMatch to find the necessary packages in
that database. If, however, you are working with a directory of RPM files, you
need to build up file names from the package name, version, and release.


## Reordering the Transaction Set

You can add packages to a transaction set in any order. The order method
reorders the transaction set to ensure that packages get installed or removed in
the right order. The order method orders by a topological sort using the
dependencies relations between objects with dependency comparisons.

Note: You must call check prior to order.


## Running the transaction

After setting up the transaction set, perform the transaction by calling
run. You need to provide two parameters:

```python
ts.run(callback, client_data)
```

The callback parameter must be a Python function. The client_data is any data
you want to pass to the callback. There may be more than one package in the
transaction set, so this data should not be specific to a particular package.

Warning: You must not pass None as the client_data or you will get a Python
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
def runCallback(reason, amount, total, key, client_data):
    # Do your stuff...
    pass
```

The key is the data you provided in the call to the addInstall method. The
client_data is the data you passed to the run method.

Each time your callback is called, the transaction set will provide a reason
flag. Table 17-5 lists the values for the reason parameter.

Table 17-5 Transaction set run callback reason values

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

Your callback must handle at least two cases: a reason value of
`rpm.RPMCALLBACK_INST_OPEN_FILE` and `rpm.RPMCALLBACK_INST_CLOSE_FILE.`

With the reason of `rpm.RPMCALLBACK_INST_OPEN_FILE`, you must open the RPM package
file and return a file descriptor for the file. You need to keep this file
descriptor in a global-scope or otherwise-accessible variable, because with the
reason of `rpm.RPMCALLBACK_INST_CLOSE_FILE`, you must close this file.


## Coding A Sample Callback

The following code shows a valid sample callback for upgrading and installing
packages.

```python
# Global file descriptor for the callback.
rpmtsCallback_fd = None

def runCallback(reason, amount, total, key, client_data):
    global rpmtsCallback_fd
    if reason == rpm.RPMCALLBACK_INST_OPEN_FILE:
        print "Opening file. ", reason, amount, total, key, client_data
        rpmtsCallback_fd = os.open(client_data, os.O_RDONLY)
        return rpmtsCallback_fd
    elif reason == rpm.RPMCALLBACK_INST_START:
        print "Closing file. ", reason, amount, total, key, client_data
        os.close(rpmtsCallback_fd)
```

This callback assumes that the call to addInstall passed client data of the
package file name. This callback ignores the client_data passed to the run
method, but this is a perfect slot for passing an object. You can use this, for
example, to avoid having a global variable for the file descriptor.


## Upgrading A Package

Listing 17-7 shows a simple Python script to upgrade or install a package.
Listing 17-7: rpmupgrade.py

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

def runCallback(reason, amount, total, key, client_data):
    global rpmtsCallback_fd
    if reason == rpm.RPMCALLBACK_INST_OPEN_FILE:
        print "Opening file. ", reason, amount, total, key, client_data
        rpmtsCallback_fd = os.open(key, os.O_RDONLY)
        return rpmtsCallback_fd
    elif reason == rpm.RPMCALLBACK_INST_START:
        print "Closing file. ", reason, amount, total, key, client_data
        os.close(rpmtsCallback_fd)

def checkCallback(ts, TagN, N, EVR, Flags):
    if TagN == rpm.RPMTAG_REQUIRENAME:
        prev = ""
    Nh = None

    if N[0] == '/':
        dbitag = 'basenames'
    else:
        dbitag = 'providename'

    # What do you need to do.
    if EVR:
        print "Must find package [", N, "-", EVR, "]"
    else:
        print "Must find file [", N, "]"

    if resolved:
        # ts.addIntall(h, h, 'i')
        return -1

    return 1

def readRpmHeader(ts, filename):
    """ Read an rpm header. """
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
    h = readRpmHeader(ts, filename)
    print "Upgrading %s-%s-%s" % (h['name'], h['version'], h['release'])
    ts.addInstall(h, filename, 'u')

unresolved_dependencies = ts.check(checkCallback)

if not unresolved_dependencies:
    ts.order()

    print "This upgrade will install:"
    for te in ts:
        print "%s-%s-%s" % (te.N(), te.V(), te.R())

    print "Running transaction (final step)..."
    ts.run(runCallback, 1)
else:
    print "Error: Unresolved dependencies, transaction failed."
    print unresolved_dependencies
```

This script expects the name of an RPM package file on the command line, and
attempts to upgrade the package. (This will also install new packages.)
When you run the `rpmupgrade.py` script, you should see output like the
following:

```
# rpm -q jikes
jikes-1.17-1

# python rpmupgrade.py jikes-1.18-1.i386.rpm
Upgrading jikes-1.18-1
This upgrade will install:
jikes-1.18-1
jikes-1.17-1
Running transaction (final step)...
Opening file. 4 0 0 jikes-1.18-1.i386.rpm 1
Closing file. 2 0 2854204 jikes-1.18-1.i386.rpm 1

# rpm -q jikes
jikes-1.18-1
```

This example shows that the package was upgraded after running the rpmupgrade.py
script. Note that with an upgrade, the original package, jikes-1.17-1 in this
case, is also added to the transaction set. With an install, this is not the
case. That’s because the original package is removed as part of the transaction.

If you run this script as a non-root user, you will likely see an error like the
following:

```
$ python rpmupgrade.py jikes-1.18-1.i386.rpm
Upgrading jikes-1.18-1
This upgrade will install:
jikes-1.18-1
jikes-1.17-1
Running transaction (final step)...
error: cannot get exclusive lock on /var/lib/rpm/Packages
error: cannot open Packages index using db3 - Operation not permitted (1)
error: cannot open Packages database in /var/lib/rpm
```

If a package has a dependency on a file such as a shared library, you will see
output like the following:

```
# python rpmupgrade.py jikes-1.17-glibc2.2-1.i386.rpm jpilot-0_97-1_i386.rpm
Upgrading jikes-1.17-1
Upgrading jpilot-0.97-1
Must find file [ libpisock.so.3 ]
Error: Unresolved dependencies, transaction failed.
(('jpilot', '0.97', '1'), ('libpisock.so.3', None), 0, None, 0)
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

The RPM bindings for Python are documented along with the C programming API. On
a Red Hat Linux system, look in the file
/usr/share/doc/rpm-devel-4.1/apidocs/html/group__python.html to see the start of
the Python-specific documentation.

Note that much of this online documentation covers the C functions that provide
the Python bindings, not the Python API itself. But, if you examine the online
information on objects listed as classes, such as rpmts, you can find the
Python-specific documentation.

Furthermore, if you look into the .c files that make up the Python bindings, you
can find PyMethodDef structure tables. These tables provide useful glimpses into
the Python API.

To learn more about programming in Python, install the python-docs package. The
python-docs package has a large set of online documentation for Python,
including the official Python Tutorial. With Red Hat Linux, start at
/usr/share/doc/python-docs-2.2.1/html/tut/tut.html.

Cross Reference
Other tutorials are available at http://diveintopython.org for the Dive Into
Python tutorial for experienced programmers, and at
http://py.vaults.ca/parnassus/apyllo.py/935043691.636055170 for the Vaults of
Parnassus listing of tutorials.


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
