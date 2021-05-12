
Name:	ts
Summary: ts
Version:	0
Release:	0
Group:	ts
License: ts

%description

%install
mkdir -p "%buildroot";
touch "%buildroot/test";

%files
%defattr(-,sys,root)
/test
