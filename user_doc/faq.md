---
layout: default
title: RPM Frequently asked questions (FAQ)
---
# RPM Frequently asked questions (FAQ)

## General
<dl>
<dt>I have /usr/local mounted on NFS on 1500 systems and this causes upgrades to break occasionally</dt>
<dd>You can tell RPM about unwritable network mounts with %_netsharedpath macro. For example to have RPM leave NFS-mounted /home and /usr/local alone:
<pre># echo "%_netsharedpath /home:/usr/local" > /etc/rpm/macros.netshared</pre></dd>
<dt>My rpmdb is corrupted! I'm getting errors about "Thread/process died in Berkeley DB library" telling me to run database recovery</dt>
<dd>Chances are the database is not really corrupted, it was just uncleanly shut down and most likely doing 'rm -f /var/lib/rpm/__db.*' is enough to clear the situation. However if you didn't manually issue kill -9 on rpm (or other process accessing the rpmdb) and are (frequently) getting this error, something is wrong, and tracking down the cause is important as it is likely to be a bug of some kind somewhere, possibly in seemingly unrelated software. It can be tricky though: the error means that a former process got forcefully killed (or crashed) in middle of accessing the rpmdb, and there's no way to for you or the developers to know what happened at the time you actually see this error.</dd>
<dd>On modern Linux, the audit subsystem can lend a hand here:
<pre># echo "-w /var/lib/rpm/Packages -p war -k rpmdb" >> /etc/audit/audit.rules
# service auditd restart</pre></dd>
<dd>The next time you get the "Thread/process [pid/tid] died..." message, you can look up the process causing this failure from the audit records, just replace &lt;pid&gt; with the [pid] part of the error message:
<pre># ausearch -k rpmdb --pid &lt;pid&gt;</pre></dd>
<dd>Once the originating program is known, its time to file a bug.</dd>
</dl>


## Packaging

<dl>
<dt>How can I make a package C require one of two packages (ie Requires: A or B)</dt>
<dd>Or-dependencies are not supported in existing RPM versions. This can be achieved by having a common virtual provide in A and B, and having C require that.</dd>

<dt>How can I replace a directory with a symlink or vice-versa?</dt>
<dd>You dont. If you are desperate, it can be achieved with a %pretrans scriptlet written with the embedded Lua interpreter, but this is fragile at best. TODO: add an actual example...</dd>

<dt>/var/tmp/rpm-tmp.XXXXXX: line NN: fg: no job control</dt>
<dd>I get the above error message while installing or removing a package. What does it mean?</dd>

<dd>Looks like a scriptlet contains a % character - probably from an undefined and though unexpanded macro. The shell (by default /bin/sh) executing the scriptlet is not happy with that. Check your scriptlets with rpm -q --scripts pkgname and fix the scriptlet or bug the original packager. </dd>
</dl>
