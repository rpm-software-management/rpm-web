---
layout: default
title: Conditional Builds
---
# Conditional Builds

Rpmbuild supports conditional package builds with the command line switches --with and --without.

Here is an example to enable gnutls and disable openssl support:
<pre>
$ rpmbuild -ba newpackage.spec --with gnutls --without openssl
</pre>

## Enable --with/--without parameters
To use this feature in a spec file, add this to the beginning of the spec:
<pre>
# add --with gnutls option, i.e. disable gnutls by default
%bcond_with gnutls
# add --without openssl option, i.e. enable openssl by default
%bcond_without openssl 
</pre>

If you want to change whether or not an option is enabled by default, only change %bcond_with to %bcond_without or vice versa. The remainder of the spec file needs to stay the same.

## Check wether an option is enabled
To define BuildRequires depending on the commandline switch, you can use the %{with foo} macro:

<pre>
%if %{with gnutls}
BuildRequires:  gnutls-devel
%endif
%if %{with openssl}
BuildRequires:  openssl-devel
%endif
</pre>

## Pass it to %configure

To pass this option to configure or other scripts than understand a --with-foo or --without-foo parameter, you can use the %{?_with_foo} macro:
<pre>
%configure \
        %{?_with_gnutls} \
                %{?_with_openssl}
                </pre>

## References
* [doc/manual/conditionalbuilds](https://github.com/rpm-software-management/rpm/blob/master/doc/manual/conditionalbuilds)
* [macros](https://github.com/rpm-software-management/rpm/blob/master/macros.in) 

