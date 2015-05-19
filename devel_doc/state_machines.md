---
layout: default
title: Internal RPM State Machines (largely OBSOLETE)
---
# Internal RPM State Machines (largely OBSOLETE)
 When updating a system RPM walks through three state machines:

* TSM (Transaction State Machine)
* PSM (Package State Machine)
* FSM (File State Machine) 

These state machines are chained such that the TSM enters the PSM, and the PSM enters the FSM. The TSM is responsible for the overall transaction of packages, and calls the PSM to install/erase/repackage individual packages. In turn the PSM is responsible for managing the install/erasure/repackaging of individual packages and it calls the FSM to handle the files of an individual package.

## Transaction State Machine

As stated above the transaction state machine is responsible for the overall updating of the system via an rpm transaction. Each transaction (an rpmts) contains various install elements and erase elements (these are rpmte's in the source). Unlike the PSM and the FSM, the TSM does not have programatic states that it goes through (i.e. its not really coded as a state machine) but its very helpful to think of it in terms of state machine. The source files that comprise things relating to the TSM are:

* rpmte.c, rpmte.h - Defines methods and attributes of transaction elements.
* rpmts.c, rpmts.h - Defines methods and attributes of transactions.
* transaction.c - Defines high level actions that can be perfomed upon an rpmts/transaction. 

Depending on how you want to think about it, you can consider the transaction state machine as having several entry points that must be manually entered (rpmtsCheck(), rpmtsOrder(), rpmtsRun()) in order, or you can think of rpmtsCheck and rpmtsOrder as just setup for the entry of the TSM via rpmtsRun(). If you take the first approach, then state machine has a high level logic of:
<pre>
   Check Transaction For Dependency Satisfaction (rpmtsCheck())
   If success
      Order Transaction Elements based on dependencies (rpmtsOrder())
   if success
      Run Transaction (rpmtsRun())
</pre>
Either way you look at it the major work of the TSM is done in rpmtsRun, so below is pseudo code to document its flow:
<pre>
Not Done Yet
</pre>

## The Package State Machine

The PSM is called at various times by the TSM for one of three purposes:

* to install a package (a transaction element from the view point of the TSM).
* to erase a package.
* to repackage a package that will be erased. 

These "purposes" are seen by the PSM as an overall goal to achieve, which are defined by the following macros:

* PSM_PKGINSTALL - used to install a package.
* PSM_PKGERASE - used to erase a package.
* PSM_PKGSAVE - used to repackage a package. 

The PSM is thus entered with one of these three initial states, that then gets translated to the PSM goal. Whichever the goal the PSM at a high level looks like this:
<pre>
   PSM_INIT                             # Initialize package state machine for goal
   if success PSM_PRE                   # Pre package install/erase/repackage activites (e.g. %pre)
   if success PSM_PROCESS               # Deliver/Erase/Repackage Files (FSM is entered here).
   if success PSM_POST                  # Post package install/erase/repackage activities (e.g. %post)
   PSM_FINI                             # Clean up PSM
</pre>
To enter into the PSM, a call is made to rpmpsmStage() (this is found in psm.c) with the second argument being the state/stage you wish the PSM to transition too. The intial stage is, is one of the three states listed above (i.e. PSM_PKGINSTALL, PSM_PKGERASE, PSM_PKGSTAGE). After this initial entry the PSM transitions through the five major states listed above (i.e. PSM_INIT, PSM_PRE, PSM_PROCESS, PSM_POST, PSM_FINI). Beyond these major states, their are several sub states into which each of the major states can transition. They are listed below:

* PSM_COMMIT - NOT SURE
* PSM_CHROOT_IN - Enter chroot environment.
* PSM_CHROOT_OUT - Exit chroot environment.
* PSM_SCRIPT - Run a scriptlet.
* PSM_TRIGGERS - Run triggers that are set against this package.
* PSM_IMMED_TRIGGERS - Run triggers owned by this package.
* PSM_RPMIO_FLAGS - Setup rpmio flags.
* PSM_RPMDB_LOAD - Retrieves installed package header.
* PSM_RPMDB_ADD - Adds header from package to rpmdb.
* PSM_RPMDB_REMOVE - Removes package header from rpmdb. 

The following are in the PSM, but are no-ops presently (Jeff, Is there an explanation for these? Well, I know there is, but is this dead code, or code waiting to be implemented:

* PSM_PKGCOMMIT - Not used (Jeff could you elaborate on this?)
* PSM_UNDO - Not used (Jeff, ditto)
* PSM_CREATE - Not used.
* PSM_DESTROY - Not used.
* PSM_NOTIFY - Used by the PSM to notify consumers of librpm of package events. 

The remaining subsections will list the high level logic of the major states (PSM_INIT, PSM_PRE, PSM_PROCESS, PSM_POST, PSM_FINI).

## PSM_PKGINSTALL, PSM_PKGERASE, PSM_PKGSAVE
<pre>
set PSM goal
transition to PSM_INIT
if OK
   transition to PSM_PRE
if OK
   transition to PSM_PROCESS
if OK
   transition to PSM_POST
transition to PSM_FINI
</pre>

## PSM_INIT
<pre>
calculate pkg instance count
if goal PSM_PKGINSTALL
    increment pkg instance count
    Try to find matching NEVRAO header in rpmdb and save in PSM state.
    if JUSTDB  return
    if file count is <= 0 return
    strip PREFIX from files in old format relocatable packages?
    strip / from files in current format relocatable packages

if goal PSM_PKGERASE
    decrement pkg instance count
    retrieve pkg header from rpmdb
if goal PSM_PKGSAVE
   generate path to repackaged package
   open repackaged package for write

return
</pre>

## PSM_PRE
<pre>
if test return
transition to PSM_CHROOT_IN   # This will change into the chroot, if we are not 
already there; then it returns here
if goal PSM_PKGINSTALL
   # There is a place holder for future %triggerprein
   #
   # Run %pre script if allowed
   if %pre allowed
      setup PSM to to run %pre script
      transition to PSM_SCRIPT      # Will run %pre script
if goal PSM_PKGERASE
   #
   # Run %preuntrigger's if allowed
   if %preuntrigger allowed
      setup PSM to run %preuntriggers
      transition to PSM_IMMED_TRIGGERS  # runs %preuntriggers owned by this package
      transition to PSM_TRIGGERS               # runs %preuntriggers triggered by this package
   #
   # Run %pre if allowed
   if %preun allowed
      setup PSM to run %preun
      transition to PSM_SCRIPT                   # runs %pre and returns here
if goal PSM_PGKSAVE
   get package header from rpmdb
   transition to PSM_RPMIO_FLAGS
   write package lead into repackaged package
   write package signature into repackaged package
   # 
   # Set the REMOVETID of the header to the TID of the currently running transaction.
   # This will intentionally poison the repackaged packages signature
   add REMOVETID to header
   write header to repackaged package
</pre>

## PSM_PROCESS
<pre>
if test return 
if goal PSM_PKGINSTALL
   if justdb return
   if no files in package 
      synthesize notify callbacks       # Will result in progress hashes being printed
      return
   iterate over files in package 
      if user of file does not exit on the system 
         turn off SUID bit of file
         set user of file to 0
      if group of file does not exist on the system 
         turn off the SGID bit
         set group of file to 0
   transition to PSM_RPMIO_FLAGS   # sets compression type
   #
   # A check is made to make sure the package has a file descriptor associated with it.
   # This is probably due to the hack where one of the times rpm notify callback is called
   # the callback is required to re-open the package.  This maddness per Jeff is to deal with
   # things like switch media in anaconda.
   if fd for package does not exist return FAILURE
   # 
   # Jeff what is this cfd thing?
   if cfd for package does not exist return FAILURE
   enter FSM with goal of FSM_PKGINSTALL
   if FSM suceeded
      transition to PSM_COMMIT
   #
   # Notify consumer of 100% installation of files
   transition to PSM_NOTIFY with RPMCALLBACK_INST_PROGRESS
   if FSM failed
   transition to PSM_NOTIFY with RPMCALLBACK_INST_PROGRESS
   if FSM failed
      print RPM error
      transition to PSM_NOTIFY with RPMCALLBACK_UNPACK_ERROR
      return FAILURE
   return OK
if goal PSM_PKGERASE
   if justdb return OK
   if apply only return OK   # ???
   if no files to erase return OK
   transition to PSM_NOTIFY with RPMCALLBACK_UNINST_START
   enter FSM with goal of FSM_PKGERASE  # This will remove any files remaining owned only by this package
   transition to PSM_NOTIFY with RPMCALLBACK_UNINST_STOP
   return OK
if goal PSM_PKGSAVE
   set fileset action to FA_COPYOUT # ???
   set fileset actions to NULL
   if no fd for package return FAIL
   if no cfd for package return FAIL # ???
   enter FSM with goal of FSM_PKGBUILD
   transition to PSM_NOTIFY with RPMCALLBACK_INST_PROGRESS
   return OK
</pre>

## PSM_POST
<pre>
if test return OK
if goal PSM_PKGINSTALL
   calculate install time
   set RPMTAG_FILESTATES in header      # ???
   set RPMTAG_INSTALLTIME in header
   set RPMTAG_INSTALLCOLOR in header
   # 
   # Remove header with same NEVRA (color?)
   transition to PSM_RPMDB_REMOVE
   #
   # Add new header to rpm db
   transition to PSM_RPMDB_ADD
   if %post allowed
      transition to PSM_SCRIPT  # Run %post script
   if %triggerin allowed
      transition to PSM_TRIGGERS                # Run %triggerin in other packages
      transition to PSM_IMMED_TRIGGERS   # Run %triggerin in this package
   if not apply only
      mark replaced files  # ???
if goal PSM_PKGERASE
   # Special note:  %postun failures do not cause PSM to return an error???
   if %postun allowed
      transition to PSM_SCRIPT    # Run %postun
   if %triggerpostun allowed
      transition to PSM_TRIGGERS   # Run %triggerpostun in other packages
   if not apply only
      transition to PSM_RPMDB_REMOVE   # Remove header from db
#
# Exit chroot
transition to PSM_CHROOT_OUT
return OK
</pre>

## PSM_FINI
<pre>
#
# Exit chroot
transition to PSM_CHROOT_OUT
close any package fd
if PSM has had error
   display error message
   transition to PSM_NOTIFY with RPMCALLBACK_CPIO_ERROR
clean up
</pre>

## The File State Machine
RIP

## Acknowledgements

This information originally came from James Olin Oden's personal examination of the rpm source code. 

