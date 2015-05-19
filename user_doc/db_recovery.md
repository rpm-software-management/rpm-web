---
layout: default
title: RPM Database Recovery
---
# RPM Database Recovery
This document provides an overview of how to deal with RPM database corruption.

## Removing stale locks

If an RPM command hangs, segfaults, or otherwise behaves abnormally during use then the first task is to check for stale lock files. This can be accomplished with -CA option to the rpmdb_stat command:
<pre>
# cd /var/lib/rpm
# /usr/lib/rpm/rpmdb_stat -CA
</pre>

Look at the output under the sections headed 'Locks grouped by lockers' and 'Locks grouped by object'. If no RPM command is executing, then there should be no entries. The RPM DB format allows many processes to be concurrently reading *AND* writing to the DB, so there is no safe way for an RPM command to identify & remove a stale lock. Stale locks are typically a result of a process being killed in an abnormal manner (power loss, kernel crash, 'kill' from an impatient admin). The locks are maintained in a handful of files named with two initial underscores.

Since there is generally no 100% reliable way to determine if an arbitrary application has a lock on the RPM db, the best time at which to clear the stale locks is while in single user mode. Thus to clean up stale lock files, the best course of action is to simply reboot the machine. If for some reason, it is not feasible to reboot the machine, then it is feasible to simply delete the files manually. Before doing this, one must ensure no application has any of the RPM database files open. This can be checked with the lsof command. For example, as root, ensure the following command shows no lines of output:
<pre>
# lsof | grep /var/lib/rpm
</pre>

## DB corruption recovery process
If after cleaning up stale lock files, problems are still experianced, then it is likely some level of database corruption is present. The file that usually requires rebuilding is master package metadata file /var/lib/rpm/Packages, and following that the indexes will also need to be re-generated. Before doing any potentially destructive action *ALWAYS* take a backup of the RPM DB.
<pre>
# cd /var/lib
# tar zcvf /var/preserve/rpmdb-`date +"%d%m%Y"`.tar.gz rpm
</pre>
Now verify the integrity of the Packages file:
<pre>
# cd /var/lib/rpm
# rm -f __db*      # to avoid stale locks
# /usr/lib/rpm/rpmdb_verify Packages
</pre>
If this reports any errors then a dump and load of the DB is required. After dumping, verify the integrity of the newly loaded Packages file:
<pre>
# mv Packages Packages.orig
# /usr/lib/rpm/rpmdb_dump Packages.orig | /usr/lib/rpm/rpmdb_load Packages
# /usr/lib/rpm/rpmdb_verify Packages
</pre>
If the Packages file now passes the verify step, then as an additional sanity check query all headers in the DB by doing, and watch for any messages sent to standard error (it helps to discard standard out when looking for this):
<pre>
# rpm -qa 1> /dev/null
</pre>
If this query passes without generating any messages to standard error, then it is time to rebuild the indexes by invoking:
<pre>
# rpm -v --rebuilddb
</pre>
At this point you should have a functioning RPM database again. If any of the recovery steps failed, then a bug should be reported. When creating the report, provide the tar.gz backup of the RPM DB as an attachment, along with any daily package list log files named /var/log/rpm*. 
