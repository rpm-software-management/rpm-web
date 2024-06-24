---
layout: default
title: rpm.org - Python RPM
---

# Python RPM

A showcase of the Python RPM on real-life examples.


## Querying a single package

Query a single installed package by its name. A Python equivalent for
`rpm -q hello`:

```
import rpm
ts = rpm.TransactionSet()
mi = ts.dbMatch("name", "hello")
hdr = next(mi, None)
if hdr:
    print(hdr[rpm.RPMTAG_NVRA])
```


## Querying a single package

Again, query a single package but this time print more information. A
Python equivalent for `rpm -qi hello`:


```python
import rpm
ts = rpm.TransactionSet()
mi = ts.dbMatch("name", "hello")
hdr = next(mi, None)
if hdr:
    print(
        f"Name        : {hdr[rpm.RPMTAG_NAME]}\n"
        f"Version     : {hdr[rpm.RPMTAG_VERSION]}\n"
        f"Release     : {hdr[rpm.RPMTAG_RELEASE]}\n"
        f"Architecture: {hdr[rpm.RPMTAG_ARCH]}\n"
        f"Install Date: {hdr[rpm.RPMTAG_INSTALLTIME]}\n"
        f"Group       : {hdr[rpm.RPMTAG_GROUP]}\n"
        f"Size        : {hdr[rpm.RPMTAG_SIZE]}\n"
        f"License     : {hdr[rpm.RPMTAG_LICENSE]}\n"
        f"Signature   : TODO\n"
        f"Source RPM  : {hdr[rpm.RPMTAG_SOURCERPM]}\n"
        f"Build Date  : {hdr[rpm.RPMTAG_BUILDTIME]}\n"
        f"Build Host  : {hdr[rpm.RPMTAG_BUILDHOST]}\n"
        f"Packager    : {hdr[rpm.RPMTAG_PACKAGER]}\n"
        f"Vendor      : {hdr[rpm.RPMTAG_VENDOR]}\n"
        f"URL         : {hdr[rpm.RPMTAG_URL]}\n"
        f"Bug URL     : {hdr[rpm.RPMTAG_BUGURL]}\n"
        f"Summary     : {hdr[rpm.RPMTAG_SUMMARY]}\n"
        f"Description :\n{hdr[rpm.RPMTAG_DESCRIPTION]}\n"
    )
```


## Querying all installed packages

A Python equivalent for `rpm -qa`:

```python
import rpm
ts = rpm.TransactionSet()
mi = ts.dbMatch()
for hdr in mi:
    print(hdr[rpm.RPMTAG_NVRA])
```


## Searching for packages

Query all packages that match part of their name with the searched
string. A Python equivalent for `rpm -qa kernel*`:


```python
import rpm
ts = rpm.TransactionSet()
mi = ts.dbMatch()
mi.pattern("name", rpm.RPMMIRE_GLOB, "kernel*")
for hdr in mi:
    print(hdr[rpm.RPMTAG_NVRA])
```


## Installing a package

Install a package stored on your system. A Python equivalent for
`rpm -i hello-2.12.1-4.fc40.x86_64.rpm`:

```python
import os
import rpm
ts = rpm.TransactionSet()
path = "/tmp/hello-2.12.1-4.fc40.x86_64.rpm"
with open(path, "r") as fp:
    filename = os.path.basename(path)
    hdr = ts.hdrFromFdno(fp.fileno())
    ts.addInstall(hdr, filename, "i")
ts.run(lambda *args: print(args), {})

# FIXME this snippet fails with
TypeError: 'NoneType' object cannot be interpreted as an integer
FATAL ERROR: python callback ??? failed, aborting!
```


## Erasing a package

Uninstall a package from the system. A Python equivalent for
`rpm -e hello`:

```python
import rpm
ts = rpm.TransactionSet()
ts.addErase("hello")
ts.run(lambda *args: print(args), {})
```
