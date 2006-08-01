
Summary:          @PACKAGE_SUMMARY@
Name:             @PACKAGE_NAME@
Version:          @PACKAGE_VERSION@
Release:          @RPM_RELEASE@%{?dist}
License:          @PACKAGE_LICENSE@
URL:              @PACKAGE_URL@
Group:            @DISTRO_LIB_GROUP@
Source:           @PACKAGE_DOWNLOAD@@PACKAGE_NAME@-@PACKAGE_VERSION@.tar.bz2
BuildRoot:        %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
BuildRequires:    @DISTRO_BUILD_REQUIRES@

%description
The clipsmm library provides a C++ interface to the CLIPS C library.

%package          devel
Summary:          Headers for developing programs that will use @PACKAGE_NAME@ 
Group:            @DISTRO_DEVEL_GROUP@
Requires:         @PACKAGE_NAME@ = %{version}-%{release}
Requires:         @DISTRO_DEVEL_REQUIRES@

%description    devel
This package contains the libraries and header files needed for
developing @PACKAGE_NAME@ applications.

%prep
%setup -q

%build
%configure --enable-static=no
ifelse(DISTRO,FEDORA,`%{__make} %{?_smp_mflags}')
ifelse(DISTRO,SUSE,`%{__make} %{?jobs:-j%{jobs}}')

%install
%{__rm} -rf %{buildroot}

%{__make} DESTDIR=%{buildroot} install
find %{buildroot} -type f -name "*.la" -exec rm -f {} ';'
# Copy the docs into a different place in the dist hierarchy so they
# install as /usr/share/doc/package-x.x.x-devel/reference
%{__cp} -ar docs/reference .

%clean
%{__rm} -rf %{buildroot}

%post -p /sbin/ldconfig

%postun -p /sbin/ldconfig

%files
%defattr(-,root,root,-)
%{_libdir}/lib*.so.*
%doc AUTHORS COPYING

%files devel
%defattr(-,root,root,-)
%{_libdir}/*.so
%{_libdir}/pkgconfig/@PACKAGE_NAME@*.pc
%{_includedir}/@PACKAGE_NAME@-@PACKAGE_RELEASE@/
%doc ChangeLog reference


%changelog
* Mon Jul 31 2006 Rick L Vinyard Jr <rvinyard@cs.nmsu.edu> - 0.0.5-1
- New release fixes autoconf generated headers
- Removed pkgconfig from BuildRequires
- Added pkgconfig to -devel Requires

* Sun Jul 30 2006 Rick L Vinyard Jr <rvinyard@cs.nmsu.edu> - 0.0.4-2
- Changed make to %%{__make}
- Changed %%{name} to autoconf subst that puts specific name in devel requires
- Added comment regarding why cp occurs for docs
- Added package name to globs in so libs, .pc and demos
- Changed clips-libs BuildRequires to clips-devel
- Added cppunit-devel BuildRequires

* Sat Jul 29 2006 Rick L Vinyard Jr <rvinyard@cs.nmsu.edu> - 0.0.4-1
- New release

* Sat Jul 21 2006 Rick L Vinyard Jr <rvinyard@cs.nmsu.edu> - 0.0.3-1
- New release

* Sat Jul 20 2006 Rick L Vinyard Jr <rvinyard@cs.nmsu.edu> - 0.0.2-1
- New release

* Sun Jun 25 2006 Rick L Vinyard Jr <rvinyard@cs.nmsu.edu> - 0.0.1-1
- Initial release
