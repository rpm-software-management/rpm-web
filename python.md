---
layout: default
title: rpm.org - Python RPM
---

# Python RPM

Searching, querying, installing, and removing RPM packages through Python API.


## Presentations

* [RPM Python][slides-paul-nasrat] slideset / tutorial by Paul Nasrat (2004)
* [Programming RPM with Python][slides-rpm-guide] from Fedora RPM Guide


## Examples

Please see the Python API [examples in the RPM repository][examples].


### Querying a single package

- A Python equivalent for `rpm -q`
- Code: [rpm-q.py][rpm-q]
- Output:

```
$ python python/examples/rpm-q.py ed
ed-1.20.2-1.fc40.x86_64
```


### More information about a package

- A Python equivalent for `rpm -qi`
- Code: [rpm-qi.py][rpm-qi]
- Output:

```
$ python python/examples/rpm-qi.py ed
Name        : ed
Version     : 1.20.2
Release     : 1.fc40
Architecture: x86_64
Install Date: 1716566271
Group       : Unspecified
Size        : 150386
License     : GPL-2.0-only AND GFDL-1.3-no-invariants-or-later
Signature   : RSA/SHA256, Wed Apr 24 17:47:49 2024, Key ID 0727707ea15b79cc
Source RPM  : ed-1.20.2-1.fc40.src.rpm
Build Date  : 1713973301
Build Host  : buildvm-x86-07.iad2.fedoraproject.org
Packager    : Fedora Project
Vendor      : Fedora Project
URL         : https://www.gnu.org/software/ed/
Bug URL     : https://bugz.fedoraproject.org/ed
Summary     : The GNU line editor
Description :
ed is a line-oriented text editor, used to create, display, and modify text
files (both interactively and via shell scripts). For most purposes, ed has been
replaced in normal usage by full-screen editors (emacs and vi, for example).
```


### Searching packages

- A Python equivalent for `rpm -qa`
- Code: [rpm-qa.py][rpm-qa]
- Output:

```
$ python python/examples/rpm-qa.py kernel* |tail
kernel-core-6.10.8-200.fc40.x86_64
kernel-modules-6.10.8-200.fc40.x86_64
kernel-devel-6.10.8-200.fc40.x86_64
kernel-modules-extra-6.10.8-200.fc40.x86_64
kernel-modules-core-6.10.9-200.fc40.x86_64
kernel-core-6.10.9-200.fc40.x86_64
kernel-modules-6.10.9-200.fc40.x86_64
kernel-devel-6.10.9-200.fc40.x86_64
kernel-devel-matched-6.10.9-200.fc40.x86_64
kernel-modules-extra-6.10.9-200.fc40.x86_64
```

Or listing all installed packages:

```
$ python python/examples/rpm-qa.py |tail
golang-1.22.7-1.fc40.x86_64
fakeroot-libs-1.36-1.fc40.x86_64
fakeroot-1.36-1.fc40.x86_64
packit-0.101.0-1.fc40.noarch
google-chrome-stable-129.0.6668.58-1.x86_64
python3-sqlalchemy1.4-1.4.54-1.fc40.x86_64
microcode_ctl-2.1-61.3.fc40.x86_64
ibus-m17n-1.4.32-1.fc40.x86_64
csdiff-3.5.0-1.fc40.x86_64
cargo2rpm-0.1.17-1.fc40.noarch
```

### Installing a package

- A Python equivalent for `rpm -i`
- Code: [rpm-i.py][rpm-i]
- Output:

```
$ sudo python/examples/rpm-i.py hello-2.12.1-4.fc40.x86_64.rpm
$ hello
Hello, world!
```


### Erasing a package


- A Python equivalent for `rpm -e hello`
- Code: [rpm-e.py][rpm-e]
- Output:

```
$ sudo python/examples/rpm-e.py hello
```



[slides-paul-nasrat]: https://web.archive.org/web/20050320013335/http://www.ukuug.org/events/linux2004/programme/paper-PNasrat-1/rpm-python-slides/frames.html
[slides-rpm-guide]: https://web.archive.org/web/20220628164331/docs.fedoraproject.org/en-US/Fedora_Draft_Documentation/0.1/html//RPM_Guide/ch-rpm-programming-python.html
[rpm-examples]: https://github.com/rpm-software-management/rpm/tree/master/python/examples
[rpm-q]: https://github.com/rpm-software-management/rpm/blob/master/python/examples/rpm-q.py
[rpm-qi]: https://github.com/rpm-software-management/rpm/blob/master/python/examples/rpm-qi.py
[rpm-qa]: https://github.com/rpm-software-management/rpm/blob/master/python/examples/rpm-qa.py
[rpm-i]: https://github.com/rpm-software-management/rpm/blob/master/python/examples/rpm-i.py
[rpm-e]: https://github.com/rpm-software-management/rpm/blob/master/python/examples/rpm-e.py
