---
layout: default
title: Problems of RPM Database
---
One level up: [Contribute](../contribute.html)

# Problems of RPM Database


## Locking

There are several locking mechanisms on the RPM Database (rpmdb). Requirements for the locking are:

* Make sure only one transaction is run at a time.
* ACID would be nice - at least some of the letters...
* There are readers who do not have permission to write to any files (non root users). Though locking mechanisms depending writing to disk won't work.
* Other processes are allowed to read the rpmdb while there are packages installed or removed.
* Scriptlets may access the rpmdb (is this supported?)
* Allow avoiding too many fsync calls 

Right now there are the following locking mechanisms:

### rpmtsAcquireLock()

Write lock of rpmdb. Details implemented in lib/rpmts.c and lib/rpmlock.[ch]. fcntl write lock on /var/lib/rpm/.rpm.lock

Protects: rpmtsRun(), rpmtsInitDB(), rpmtsRebuildDB(), rpmtsVerifyDB()

Problems:
* Is not persistent. No way to detect if db is not in consistent state
* Does not check if db was altered between rpmtsCheck() and rpmtsRun() -> racy 

Solutions:
* The ts should get the revision of the rpmdb on creation and check that it is unchanged after acquiring this lock. 
   * TODO: Check if this is sufficient for the GUI tools that run the tscheck as user and aqcuire root privilidges later.

* Introduce a new lock implementation that actually creates a file on disk that is deletes if the ts was successful (or a similar mechanism) 

### dbiFlock()

Fcntl read or write lock on /var/lib/rpm/Packages in dbiOpen() (lib/backend/db3.c) which is used indirectly by all rpmdb operations. Like rpmtsOpenDB(), rpmtsInitIterator(), rpmtsImportPubkey(), ...

TODO: Code path analysis

Problems:
* Code looks like a lock on any dbi but is actually only used for Packages
* Code broken since 2001: Write locks never happen! -> non root readers access rpmdb without any protection
* If those locks work a user can block the rpmdb. Right now there is no code to force in a write lock after a time out. 

SUSE has patch to make the locks work . It unlocks the db while scriptlets run. It is probably better to acquire the write lock only during rpmdbAdd() and rpmdbRemove().

### DB_INIT_CDB

Berkeley DB Concurrent Data Store does single write multiple readers locking for the DB4 environment and the associated databases. It is used whenever the environment can be opened - so basically for root access only.

Problems:
* Does not protect inbetween adding the header and updating the indexes -> db4 transactions would be needed
* Does not protect non root users (readers)
* Db4 environment is a hassle
    * Creation is racy right now
    * Making it non racy requires a lot of additional effort - like sending signals to processes to reopen a broken environment if it is stale. 

SUSE always uses a private environment, so this does not apply to them. A working dbiFlock() implementation removes the need for the whole CDB and though a global environment.

### Related Patches

SUSE:

* db.diff, dbfsync.diff: fsync per index - patches db4
* dbprivate.diff: alway use private environment
* dbrointerruptable.diff: allow interrupt when db is opend ro. Probably requires other patches to work flawlessly
* suspendlock.diff: drop write lock while scriptlets run
* waitlock.diff: fix dbiFlock() 

Mandriva:

[http://svn.mandriva.com/svn/packages/cooker/rpm/current/SOURCES/rpm-4.6.0-rc1-protect-against-non-robust-futex.patch](http://svn.mandriva.com/svn/packages/cooker/rpm/current/SOURCES/rpm-4.6.0-rc1-protect-against-non-robust-futex.patch)

Uses fcntl locks on /var/lib/rpm/__db.001 (the first file of the db4 environment) to decide whether the environment can be deleted after use. This works around some unsolved stale lock issue within the environment.

## Performance

### Fsync calls

As all DB files should be written to disk after every package there are a lot of fsync call. On a typical hard disk based system this uses up a large amount of time. Typical values are 40 to 70% of the overall time needed for the whole run. Switching of dbsync in the config can though speed up RPM by a factor around 2 to 3 depending on the size of the rpmdb (see below). But switching off the dbsync can lead to inconsistent indexes in case of an accident. RPM is currently lacking a mechanism to detect this case and tell the user to fix the indexes with rpm --rebuilddb

On ext3 (as of on Fedora 11) it is needed to also increase the db4 cache size to about 64MB to (me guessing) hide the trashing of the read buffers.

### Quadratic behavior of Indexes

The indexes consist of key and an array of integers for the entries. To add or remove an entry to the index the whole array is read, modified and then written to disk. In cases where some keys are common (fixed percentage of the data) this leads to quadratic behavior. Typical example is Basenames which has some very poular entries like LICENSE, AUTHORS, README, ...

