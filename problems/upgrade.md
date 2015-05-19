---
layout: default
title: Problems of upgrade
---
One level up: [Contribute](../contribute.html)

# Problems of upgrade

While upgrading, special action needs to take place. The only way to perform them is the standard set of scriptlets and triggers and information provided to them (number of instances of the package). It is far from being sufficient in a more complicated situations.

### Complex update with package rename or split
Sometimes package is going to be replaced or splitted to more subpackages. Standard scriptlets have no idea about this change.
<dl>
<dt>Why:</dt>
<dd>Package remove can easily activate destructive post-removal actions.</dd>
<dt>Work-arounds:</dt>
<dd>Corruption prevention hacks (temporary replacing of binaries by /bin/true) or post corruption fixes.</dd>
<dt>Proposed solution:</dt>
<dd>Not clean yet. Maybe scripts associated with file instances instead of package instances. Maybe definition of package successor on rename.</dd>
</dl>

### Version-dependend configuration file update
Version updates may need special update scenario.
Examples: Any config files which needs to be changed between versions.
<dl>
<dt>Why:</dt>
<dd>RPM provides no way to detect previous version of the package before upgrade. RPM database is locked when scripts are running, so there is no way to get this information in a non-stadard way.</dd>
<dt>Work-arounds:</dt>
<dd>Check unrelated files to guess, which version was installed.</dd>
<dt>Proposed solutions:</dt>
<dd>Provide more information in the scriptlet arguments.</dd>
<dd>Allow access to RPM database from scripts.</dd>
</dl>

### Future breakage
Package changes syntax of a binary used in scriptlet causing breakage of %postun of the old instance. Packager found a dangerous %postun mistake and it would be nice to not call it on upgrade.
<dl>
<dt>Examples:</dt>
<dd>Update from gstreamer-0.8 to gstreamer-0.10 several years ago.</dd>
<dt>Why:</dt>
<dd>There is no way to block scripts in database except --noscripts.</dd>
<dt>Work-arounds:</dt>
<dd>Temporary altering filesystems replacing of failing command with /bin/true and reverting in %posttrans.</dd>
<dt>Proposed solution:</dt>
<dd>rpm or rpm scriptlet initiated blocking of other scriptlets.</dd>
</dl>

### Compatibility symlinks and replacement of directory by file
Package does not contain particular directory an more, but packager wants to provide compatibility symlink.
<dl>
<dt>Examples:</dt>
<dd>Many</dd>
<dt>Why:</dt>
<dd>RPM deletes linked files during obsolete files removal.</dd>
<dt>Work-arounds:</dt>
<dd>Live without compatibility symlinks. Crazy scripts in %posttrans or SuSEconfig</dd>
<dt>Proposed solutions:</dt>
<dd>Fix RPM database check.</dd>
<dd>or</dd>
<dd>Possibility of RPM database helper providing interface for advanced reorganization.</dd> 
<dd>or</dd>
<dd>Possibility of upgrade scenario selection - place new then remove old (default), remove old then place new (alternative)</dd>
</dl>

### Config file updates
No way to update config files automatically is provided by rpm.
<dl>
<dt>Examples:</dt>
<dd>All modified config files</dd>
<dt>Why:</dt>
<dd>All concurrent systems provide a solution for seamless update of modified config files.</dd>
<dt>Work-arounds:</dt>
<dd>None. Silently keep rpmorig and rpmnew files hoping that admin will find them.</dd>
<dt>Proposed solution:</dt>
<dd>As other distributions, make a backup of an intact copy of all %config files. Then provide a diff -> patch as a basic upgrade scenario with possibility to define a different one by the spec file author. GUI than could provide a wizard for manual upgrade of remaining rejects.</dd>
</dl>

### Counter handling
Sometimes it is required to execute certain type of action, if there is no more package using something. Related to "Complex update with package rename or split".
<dl>
<dt>Examples:</dt>
<dd>Remove UID/GID, which is not used. Delete cache for programs, which are just uninstalled.</dd>
<dt>Why:</dt>
<dd>RPM does not export counter concept to the outer world. If it is not possible to associate this type of action with a concrete symbol and its counter.</dd>
<dt>Work-arounds:</dt>
<dd>Keeping orphans. Adding crazy logic into %postun scripts.</dd>
<dt>Proposed solution:</dt>
<dd>Counter scriptlets, triggered when number of symbol providers reaches zero. This concept may be used for other problems mentioned here (e. g. Complex update with package rename or split).</dd>
</dl>

### Package successor
There is no way to discriminate between situation, when package is replaced by a successor with a diferent function, successor with the same function, but different name, or it is obsoleted without replacement.
<dl>
<dt>Why:</dt>
<dd>Only Obsoletes with Provides or Obsoletes without Provides are possible. There is no further way to specify these cases.</dd>
<dt>Examples:</dt>
<dd>apache1 is replaced by apache2. Special config conversion script needs to be called, apache1 has to be stopped and apache2 has to be started then ASAP. (Depending on implementation, files may exist in parallel some time or may require remove first, then place new files.)</dd>
<dd>gaim is replaced by pidgin. Place new files, then remove old to not break service.</dd> 
<dd>package foo1 is replaced by foo2, but modified /etc/foo.conf must be kept in place.</dd>
<dt>Proposed solution:</dt>
<dd>Define new keyword for defining successor of package.</dd>
<dd>Allow to use "place new, then remove old" process while installing compatible successor.</dd> 
<dd>Design a way, how to call scripts only if "removal of package, if no compatible successor exists" and "package replacement by successor happens". </dd>
</dl>

### Conflicting update
There is no correct way to update system to another package providing the same required function and conflicting with the one just installed.
<dl>
<dt>Why:</dt>
<dd>It is not possible to to both erase and install in one transaction, so one has to use --nodeps with temporary breaking of dependencies.</dd>
<dt>Examples:</dt>
<dd>gimp-branding-upstream is going to be replaced by conflicting gimp-branding-openSUSE. In fact, it could happen silently. But just now, one must use rpm -e --nodeps gimp-branding-upstream ; rpm -U gimp-branding-openSUSE with a short service breakage.</dd>
<dt>Proposed solution:</dt>
<dd>Allow both erase package and install package in one transaction (and on command line). </dd>
<dd>Design a concept of conflicting (exclusive) replacement. Basically it would be "provides + obsoletes_each_other_provider". On RPM level, it could have exactly the same behavior as classical "provides + obsoletes", but higher level tools will evaluate it differently (not consider obsoleting provider as a replacement). </dd>
</dl>


