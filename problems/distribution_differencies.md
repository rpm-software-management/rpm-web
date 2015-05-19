---
layout: default
title: Problems of distribution differencies
---
One level up: [Contribute](../contribute.html)

# Problems of distribution differencies


This page tries to list differences in packaging between distributions and to propose possible solutions.

* desktop macros
    * Fedora: BuildRequires: desktop-file-utils and uses desktop-file-validate or desktop-file-install commands in %install phase
    * openSUSE: BuildRequires: update-desktop-files and uses %suse_update_desktop_file macro
    * solution: try to unify the procedure, if some macro is still needed, try to push it to upstream RPM 

* Ruby packaging

    * Fedora: uses these macros:
    <pre>
    a) %global ruby_sitelib %(ruby -rrbconfig -e 'puts Config::CONFIG["sitelibdir"] ')
    b) %global ruby_sitearch %(ruby -rrbconfig -e 'puts Config::CONFIG["sitearchdir"] ')
    c) %global gemdir %(ruby -rubygems -e 'puts Gem::dir' 2>/dev/null)
    </pre>
    and adds Requires: ruby(abi) = 1.8 to packages

    * openSUSE: uses %rb_ver and %rb_arch macros and the following corresponding paths:
    <pre>
    a) %{_libdir}/ruby/vendor_ruby/%{rb_ver}
    b) %{_libdir}/ruby/vendor_ruby/%{rb_ver}/%{rb_arch}
    c) %{_libdir}/ruby/gems/%{rb_ver}
    </pre>
    (almost the same, difference is site_ruby vs. vendor_ruby)

    * solution: create the macros in upstream, use them consistently in both distributions 

* Python packaging (2)

    * Fedora: RPM adds a automatic dependency on correct python(abi) = X.Y symbol
    * openSUSE: needs %{py_requires} macro which expands to python >= X.Y and python < X.(Y+1) which is broken
    * solution: enable method used by Fedora in openSUSE too 

* parallel make

    * Fedora: make %{?_smp_mflags}
    * openSUSE: make %{?jobs:-j%jobs}
    * solution: unify notation (%{?_smp_mflags} works on openSUSE too), even better add the definition to RPM upstream (%make for parallel build and %make_single for single?)
    * ticket #115 

* init scripts (2)

    * Fedora: LBS are not required in init scripts, but honored
    * openSUSE: LSB headers are required init scripts
    * solution: ? 

* init scripts

    * Fedora:
    <pre>
    Requires(post): chkconfig
    Requires(postun): initscripts
    Requires(preun): chkconfig
    Requires(preun): initscripts

    %post
    /sbin/chkconfig --add <script>

    %preun
    if [ $1 = 0 ] ; then
        /sbin/service <script> stop >/dev/null 2>&1
        /sbin/chkconfig --del <script>
    fi

    %postun
    if [ "$1" -ge "1" ] ; then
        /sbin/service <script> condrestart >/dev/null 2>&1 || :
    fi`
    </pre>
    * openSUSE:
    <pre>
    PreReq: %insserv_prereq %fillup_prereq

    %install
    mkdir -p %{buildroot}%{_initddir}
    install -m 755 <script>.init %{buildroot}%{_initddir}/<script>

    mkdir -p %{buildroot}%{_sbindir}
    ln -sf %{_initddir}/service %{buildroot}%{_sbindir}/rc<script>

    %post
    %fillup_and_insserv <script>
    %restart_on_update <script>

    %preun
    %stop_on_removal <script>

    %postun
    %insserv_cleanup

    %files
    %defattr(-,root,root)
    %{_initddir}/<script>
    %{_sbindir}/rc<script>
    </pre>
    * solution: try to unify the procedure, if some macros are still needed, try to push them to upstream RPM
    * openSUSE 11.1 and older have broken macro %{_initrddir} - it should read %{_initddir} 

## SOLVED

* Build Root

    * buildroot is safely created, ignoring the path from the .spec
    * BuildRoot tag is not-mandatory in .spec, could be omitted
    * does not need to be removed in %install phase
    * needs to be removed in %clean phase - this is done automatically now, if no %clean phase is defined in spec: [https://github.com/rpm-software-management/rpm/commit/3fc58248d23d6f720942e5cbf4f92db246a802f0](https://github.com/rpm-software-management/rpm/commit/3fc58248d23d6f720942e5cbf4f92db246a802f0)

* Python packaging

    * Fedora: uses two variables in python spec files:
    <pre>
    %{!?python_sitelib: %global python_sitelib %(%{__python} -c "from distutils.sysconfig import get_python_lib; print get_python_lib()")}
    %{!?python_sitearch: %global python_sitearch %(%{__python} -c "from distutils.sysconfig import get_python_lib; print get_python_lib(1)")}
    </pre>

first one is for noarch packages, second for arch packages

* openSUSE: uses only one %{py_sitedir} macro which is hardcoded to %{py_libdir}/site-packages, does not allow noarch packages
* solution: push macros from Fedora to RPM upstream, use them in openSUSE too (done, see ticket #83 and [https://github.com/rpm-software-management/rpm/commit/3e5097c97541fa0b8f289ef3b6011bdc3b4dc002](https://github.com/rpm-software-management/rpm/commit/3e5097c97541fa0b8f289ef3b6011bdc3b4dc002)) 

* make install

    * Fedora: macro %makeinstall is defined as:
    <pre>
    make \
        prefix="%{buildroot}%{_prefix}"
        libdir="%{buildroot}%{_libdir}"
    ...
    </pre>
    * openSUSE: defined as make DESTDIR=$RPM_BUILD_ROOT install
    * solution: push openSUSE definition to upstream - (done, see [https://github.com/rpm-software-management/rpm/commit/883253ea6af71f8063d7a045841c35bad22147e2](https://github.com/rpm-software-management/rpm/commit/883253ea6af71f8063d7a045841c35bad22147e2))

* Shared Library Policy

    * Fedora: does not use it
    * openSUSE: uses it
    * solution: nothing to do, just make sure that -devel packages have/provide the same name 

* Branding subpackages

    * Fedora: does not use it
    * openSUSE: uses it
    * solution: nothing to do 


