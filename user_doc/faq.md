---
layout: default
title: rpm.org - RPM Frequently asked questions (FAQ)
---
# RPM Frequently asked questions (FAQ)

## General

#### I have /usr/local mounted on NFS on 1500 systems and this causes upgrades to break occasionally
You can tell RPM about unwritable network mounts with %_netsharedpath macro.
For example to have RPM leave NFS-mounted /home and /usr/local alone:

```
# echo "%_netsharedpath /home:/usr/local" > /etc/rpm/macros.netshared
```

#### My rpmdb is corrupted! I'm getting errors about "Thread/process died in Berkeley DB library" telling me to run database recovery
Chances are the database is not really corrupted, it was just uncleanly shut
down and often doing `rm -f /var/lib/rpm/__db.*` is enough to clear
the situation. However unless you're certain that the error appeared
on a read-only access, backing up the database and doing 'rpmdb --rebuilddb'
is in order.

However if you didn't manually issue `kill -9` on rpm
(or other process accessing the rpmdb) and are (frequently) getting this
error, something is wrong, and tracking down the cause is important as it
is likely to be a bug of some kind somewhere, possibly in seemingly unrelated
software. It can be tricky though: the error means that a former process got
forcefully killed (or crashed) in middle of accessing the rpmdb, and there's
no way to for you or the developers to know what happened at the time you
actually see this error.

On modern Linux, the audit subsystem can lend a hand here:

On systemd-era hosts (on recent Fedora versions syscall auditing is disabled
by default, the sed is needed to re-enable it):
```
# echo "-w /var/lib/rpm/Packages -p war -k rpmdb" > /etc/audit/rules.d/rpmdb.rules
# sed -ie "/-a task,never/s/^/#/g" /etc/audit/rules.d/audit.rules
# systemctl restart auditd.service
```

On sysvinit-era hosts:
```
# echo "-w /var/lib/rpm/Packages -p war -k rpmdb" >> /etc/audit/audit.rules
# service auditd restart
```

The next time you get the "Thread/process [pid/tid] died..." message, you can
look up the process causing this failure from the audit records, just
replace <pid> with the [pid] part of the error message:

```
# ausearch -k rpmdb --pid <pid>
```

Once the originating program is known, its time to file a bug.


## Packaging

#### How can I make a package C require one of two packages (ie Requires: A or B)
Or-dependencies are not supported in existing RPM versions. This can be
achieved by having a common virtual provide in A and B, and having C require
that.

Since rpm version 4.13 you can also use [Boolean Dependencies](user_doc/boolean_dependencies.html). So you can directly use:

```
Requires: ( pkgA >= 1.2.3 or pkgB )
```

#### How can I replace a directory with a symlink or vice-versa?

You dont. If you are desperate, it can be achieved with a %pretrans
scriptlet written with the embedded Lua interpreter, but this is fragile at
best. The Fedora project has [examples and further guidance](https://docs.fedoraproject.org/en-US/packaging-guidelines/Directory_Replacement/) you
might be helpful.

#### /var/tmp/rpm-tmp.XXXXXX: line NN: fg: no job control
I get the above error message while installing or removing a package. What does it mean?

Looks like a scriptlet contains a % character - probably from an undefined
and though unexpanded macro. The shell (by default /bin/sh) executing the
scriptlet is not happy with that. Check your scriptlets with rpm -q --scripts
pkgname and fix the scriptlet or bug the original packager. 

#### How can I add a file with a space in the name?

You can't just type the space within the name as it is used in the spec as
delimiter. One way to deal with this is match the file with a glob expression
that does not contain the space. Another way is to surround the path with
double-quotes. Unfortunately this will prevent globs to be expanded. So you
need to stick to one of the methods and can't use both in the same entry.
