---
layout: default
title: RPM Log
---
One level up: [Contribute](../contribute.html)

# RPM Log

 ***This document is still a draft. Please feel free to add comments***

Currently RPM doesn't keep it's own log of what happened. This has led to upper layer tools (yum, zypper) implementing their own logging facilities. This has the disadvantage that all operations done by other tools (including the rpm command line) are missing in these logs. Main problem for an implementation within rpm itself is that the set of information that needs to be stored differs between the upper level tools and pieces of information are not known to rpm itself (marked with (X) below). So there are new functions needed to attach this information to both the transaction and the transaction elements.

This feature is not intended to allow to continue or repair a broken transaction but only see what operations have been run in the past. So more fine grained information is intentionally left out. For recovering broken transactions another log might be added in the future.

## Design

Format should be readable to both humans and machines. "Classic" log file in /var/log/rpm that can be rotated by log rotate (if neccessary). Format needs to be extendible with application specific "tags" but for most stuff there should be predefined names so tools can share information more easily.

Alternative would be per transaction files. Probably /var/log/rpm/TIMESTAMP(.N). Switching between those alternatives should be easy.

### Lines
Start Transaction
: 1. "STARTTRANSACTION"
  2. StartTime
  3. TransactionFlags
  4. RpmlibVersion
  5.  RpmDbIdBefore "check" sum of rpmdb 

Command Line
: 1. "CommandLine?"
  2. ARGV - each parameter in one column ((X) may be overwritten by application) 

Command
: 1. "Command"
  2. (X) CommandName (human readable)
  3. (X) CommandVersion
  4. (X) Operation human readable name of the operation selected by the user (mainly for GUI applications, use CLI command name otherwise)
  5. (X) DepsolverFlags (optional) comma separated, named options - depend on upper layer tool like yum or zypper
  6. (X) User (optional) user requesting the operation (try passing real user name from GUI apps) 

Repository
: All (X)
  : 1. "Repository"
    2. Name - human readable name
    3. Id - to be used in the packages "Origin" tag
    4. Type - should include a version number
    5. Date - creation date
    6. Version - version number of the repository (really needed/available? somehow redundant with Date
    7. Location - URL the repo was downloaded from / path where it can be found on disk 

Transaction Element
: 1. "INSTALL" &#124; "REMOVE"
  2.  NEVRA
  3.  CheckSum (SHA1:1234567890)
  4.  RpmDbId
  5.  (X) Reason for installing/removing the package (SELECTED by user, part of selected GROUP, BYDEPENDENCY, UPDATE, OBSOLETE)
  6.  (X) Origin Repository name or location (path, URL) the package came from (installs only) 

  *  (X) Groups the package is in or was installed as part of
  *  (X) link to aditional update, security information, reason for issuing this update (optional) 

Related Packages
: 1. "UPDATES"&#124;"UPDATEDBY"&#124;"OBSOLETES"&#124;"OBSOLETEDBY"
  2.  NEVRA of package (one per column? more information needed? Check sum, rpmid also needed? May be use a regular package block with some information left out (references to other blocks)?) 

Files of a TE
: Line belongs to the TE line above
  : 1. "Files"
    2. One file per column (rpmsave and rpmnew only) 

Scriptlet output
: Only for failed scriptlets - everything else should be 0 and ""
   : 1. "SCRIPTLET"
     2. ("PRE"&#124;"POST")"UN"?"TRANS"
     3. NEVRA of package
     4. Exitcode
     5 .Output 

Trigger output
: Only for failed scriptlets - everything else should be 0 and ""
  : 1. "TRIGGER"
    2. ("PRE"&#124;"POST")"UN"?"TRANS"
    3. NEVRA of package
    4. TNEVRA of triggering package
    5. Exitcode
    6. Output 

Messages
: 1. "WARNING"&#124;"ERROR"
  2.  Message 

End Transaction
: 1. "ENDTRANSACTION"
  2.  EndTime
  3.  RpmDbIdAfter 

## Format

Dates in fixed order with "&#124;" as separator one item (package/transaction) per line (similar to the libzypp Package History)

* Add comments to explain the rows from time to time to improve readability
* Needs a mechanism to deal with extentions and lists
  * May be allow appending things in the following lines with leading tab and one item per line
  * Or key:value pair at the end of the line
     * makes the probably most interesting items less readable... 

Sample (may be out of date):
<pre>
STARTTRANSACTION Tue Feb 23 16:58:57 CET 2010|4.9.0|force|b1f5b4b255fe69efc90feec6793fb307
CommandLine yum|-y|--skip-broken|install|foobar
Command Yum|3.2.25|Install|skipbroken|root

# Repository name | version | URL
Repository Fedora 17|base|md-V27|Tue Feb 20 16:58:57 CET 2010|2010028.0|http://foobar.com/fedora/28/x86_64
Repository Fedora 17 - updates|updates|md-V27|Tue Feb 20 16:58:57 CET 2010|2010028.0|http://foobar.com/fedora/28/x86_64

SKRIPT PRETRANS|foobar-99.3-22.noarch|bash: hgdhjsd: command not found\n
# op    NEVRA | checksum | dbId | reason | repo | groups | info
INSTALL foobar-99.3-22.noarch|SHA1:1234567890|4527|updates|Selected|Humor,Administration|
    files /etc/foobar/default.conf.rpmnew|/etc/foobar/emergency.conf.rpmsave.2
    OBSOLETES bar-43.2-2.noarch

ENDTRANSACTION Tue Feb 23 17:58:57 CET 2010|77d3233bcc453c5800077a8ad4d3670c
</pre>

### Quoting

As we use lines and and "&#124;" to structure the data we need to use quoting. "\" is used for quoting.

* newline - "\n"
* Null char - "\0" (can happen in script outputs and may course trouble)
* "\" - "\\"
* "&#124;" - "\&#124;" 

