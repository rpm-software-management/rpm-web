---
layout: default
title: Problems of scriptlets
---
One level up: [Contribute](../contribute.html)

# Problems of scriptlets

Scriptlets are the only possibility to influent files, that cannot be part of the static file list itself. The scriptlet concept provides several types of script types. However these scripts don't fit the need of the real life packaging. Especially several types of standard scenarions does not have any related RPM script level concept:

### Database rebuild

This installation concept requires rebuild of certain type of a database from scratch when file is installed or uninstalled. RPM scripts fit very badly to this concept.
<dl>
<dt>Examples:</dt>
<dd>ldconfig, gtk-update-icon-cache, update-mime-database, update-desktop-database</dd>
<dt>Why:</dt>
<dd>There is no concept of scripts called once per transaction or once per installation batch.</dd>
<dt>Work-arounds:</dt>
<dd>External tools (SuSEconfig).</dd>
<dd>Calling script multiple times at cost of >>10000% of performance drop-down.</dd>
<dd>Making installation images. Scriptlets are called by image author instead of installing person.</dd>
<dt>Proposed solution:</dt>
<dd>Introduction of new scriptlets:</dd>
<dd>from uninstalled instance before starting to place new files</dd>
<dd>or</dd>
<dd>from installed instance after removing of replaced files (optional, %posttrans does it)</dd>
<dt>Note:</dt>
<dd>This concept requires a short service drop-out while installing.</dd>
</dl>


### Registry, which needs subscription and unsubscription
This installation concept requires registration of each installed file to certain type of a database and deregistration when file is uninstalled. RPM scripts fit very badly to this concept.
<dl>
<dt>Examples:</dt>
<dd>gconf install rules, install-info</dd>
<dt>Why:</dt>
<dd>It is not possible to execute script from uninstalled instance just before starting of upgrade process.</dd> 
<dd>The only script from installed version available after completing update is %posttrans, which was intended for different types of actions.</dd>
<dt>Work-arounds:</dt>
<dd>Three scripts have to be activated. With co-ordination of old and new instance, hiding of files away from RPM sight, it is possible to work-around this problem. The solution is ugly and fragile.</dd>
<dt>Proposed solution:</dt>
<dd>Introduction of new scriptlets:</dd>
<dd>from uninstalled instance before starting to place new files</dd>
<dd>or</dd>
<dd>from installed instance after removing of replaced files (optional, %posttrans does it)</dd>
<dt>Note:</dt>
<dd>This concept requires a short service drop-out while installing.</dd>
</dl>


### Daemon restart
Daemon should be started on installation, stopped on removal and restarted just once during update.

This problem exhibits combination of "registration/deregistration to database" and "Complex update with package rename or split".
<dl>
<dt>Examples:</dt>
<dd>All init scripts</dd>
<dt>Why:</dt>
<dd>There is no uninstallation script early enough to stop before removal and it is hard to guess, whether it is update or removal.</dd>
<dt>Work-arounds:</dt>
<dd>Three scripts have to be activated. With co-ordination of old and new instance, it is possible to partially work-around this problem. The solution is ugly and fragile and cannot provide a solution for package rename or split.</dd>
<dt>Proposed solution:</dt>
<dd>More straightforward detection of upgrade. </dd>
<dd>Introduction of new scriptlet from installed instance after removing of replaced files (optional, %posttrans does it)</dd>
</dl>


### Proposal

Remove the scripts handling special file types (or services) out of the packages containing them and allow the packages that handle the file type (contain the programs to do so) to register a handler that takes care of those files. There are currently two ideas:

 * File triggers: Add a new flag or tag to register triggers for file patterns. While this is consistent with the current trigger mechanism it makes it hard to really act more intelligent - especially if even the large number of newly started processes is becoming a problem.
 * Lua: Extent the rpm lua API to lua scripts have access to the transaction details. Then allow registrating hooks - lua functions that are called from special places in the rpm code - that can check for files needing special treatment in the transaction. As the state of the lua interpreter is maintained over the runtime of rpm it is easy to collect data in one hook (e.g. pkg install and remove) and use it in another (e.g. post trans). The obvious disadvantage is the lua centricity of this solution. 

