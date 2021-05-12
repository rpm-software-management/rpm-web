Name:           foo
Version:        1.0
Release:        1%{?dist}
Summary:        Dummy test package

Group:          Development/Debug
License:        Public Domain
URL:            http://fedoraproject.org/
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)

%description


%prep


%build


%install
rm -rf $RPM_BUILD_ROOT
install -dm 755 $RPM_BUILD_ROOT/tmp
touch $RPM_BUILD_ROOT/tmp/{foo,bar,quux}
echo /tmp/foo > files1
echo /tmp/bar > files2
echo /tmp/quux > files3


%clean
rm -rf $RPM_BUILD_ROOT


%files -f files1 -f files2 -f files3
%defattr(-,root,root,-)


%changelog
