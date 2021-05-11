---
layout: default
title: rpm.org - RPM Database Recovery
---
# RPM Database Recovery
This document provides an overview of how to deal with RPM database corruption.

## Introduction

Since version 4.16.0 RPM supports two new database backends: One based on `sqlite` and one native implementation called `ndb`. Both are much more stable and resilient than the traditional Berkley DB based backend (`bdb`).

The backend rpm is supposed to use can be found out by executing

```
rpm -E "%{_db_backend}"
```

To be sure one should look into the database directory. The location can be queried by:

```
rpm -E "%{_dbpath}
```

but typically is `/var/lib/rpm`.

* The `sqlite` backend has files beginning with `rpmdb.sqlite` in the dbpath.
* The `ndb` backend has a `Packages.db` file.
* BDB backend has many files named after RPM tags like
  * `Dirnames`
  * `Group`
  * `Name`
  * `Providename`
  * ...
  * `Packages` - which holds all the headers and is the primary data source
  * optionally `__db.001`, `__db.002`, ... - BDB environment files

# Sqlite and NDB Backend

In case something goes wrong with these databases create a backup first:

```
# cd /var/lib
# tar zcvf /var/preserve/rpmdb-`date +"%d%m%Y"`.tar.gz rpm
```

Most problems can then be solved by running

```
rpmdb --rebuilddb
```

which creates the database structure from the RPM headers that are also stored in the database. If this fails you may try the sqlite tools for saving the database or at least rescue the `Packages` table.

The ndb backend offers an more involved rescue process with

```
rpmdb --salvagedb
```

# BDB Backend

## Removing stale locks

If an RPM command hangs, segfaults, or otherwise behaves abnormally during use then the first task is to check for stale lock files. This can be accomplished with -CA option to the rpmdb_stat command:

```
# cd /var/lib/rpm
# /usr/lib/rpm/rpmdb_stat -CA
```

Look at the output under the sections headed 'Locks grouped by lockers' and 'Locks grouped by object'. If no RPM command is executing, then there should be no entries. The RPM DB format allows many processes to be concurrently reading *AND* writing to the DB, so there is no safe way for an RPM command to identify & remove a stale lock. Stale locks are typically a result of a process being killed in an abnormal manner (power loss, kernel crash, 'kill' from an impatient admin). The locks are maintained in a handful of files named with two initial underscores.

Since there is generally no 100% reliable way to determine if an arbitrary application has a lock on the RPM db, the best time at which to clear the stale locks is while in single user mode. Thus to clean up stale lock files, the best course of action is to simply reboot the machine. If for some reason, it is not feasible to reboot the machine, then it is feasible to simply delete the files manually. Before doing this, one must ensure no application has any of the RPM database files open. This can be checked with the lsof command. For example, as root, ensure the following command shows no lines of output:

```
# lsof | grep /var/lib/rpm
```

## DB corruption recovery process
If after cleaning up stale lock files, problems are still experianced, then it is likely some level of database corruption is present. The file that usually requires rebuilding is master package metadata file /var/lib/rpm/Packages, and following that the indexes will also need to be re-generated. Before doing any potentially destructive action *ALWAYS* take a backup of the RPM DB.

```
# cd /var/lib
# tar zcvf /var/preserve/rpmdb-`date +"%d%m%Y"`.tar.gz rpm
```

Now verify the integrity of the Packages file:

```
# cd /var/lib/rpm
# rm -f __db*      # to avoid stale locks
# /usr/lib/rpm/rpmdb_verify Packages
```

If this reports any errors then a dump and load of the DB is required. After dumping, verify the integrity of the newly loaded Packages file:

```
# mv Packages Packages.orig
# /usr/lib/rpm/rpmdb_dump Packages.orig | /usr/lib/rpm/rpmdb_load Packages
# /usr/lib/rpm/rpmdb_verify Packages
```

If the Packages file now passes the verify step, then as an additional sanity check query all headers in the DB by doing, and watch for any messages sent to standard error (it helps to discard standard out when looking for this):

```
# rpm -qa 1> /dev/null
```

If this query passes without generating any messages to standard error, then it is time to rebuild the indexes by invoking:

```
# rpmdb -v --rebuilddb
```

At this point you should have a functioning RPM database again.


# If all fails


If the recovery failed, then a bug should be reported. Note that this is a rare event and it is possible that your system took more damage than just the rpm database.

When creating the bug report, provide the tar.gz backup of the RPM DB as an attachment. If available also provide the list of installed packages. First try

```
# rpm -qa 1> /dev/null
```

If this does not work or the result is suspiciously short you can look into `/var/log/rpm*`. RPM comes with a cron script to back up the list of installed packages daily there but it may not be installed on the system.

Another place to look for the list of installed packages may be the logs of a higher level installer/updater that may still be undamaged.

If you have the list of packages available it may be easier to re-create the rpmdb than reparing it. Run

```
rpm -i --justdb PACKAGES
```

or reinstalling all packages completely after moving the broken database out of the way.
