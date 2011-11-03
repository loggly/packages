NAME=membase
VERSION=1.6.0beta2-18
BUILDDEPS=build-essential, automake, libtool, pkg-config, check, libssl-dev, \
          libsqlite3-dev, libevent-dev, libglib2.0-dev, libcurl4-gnutls-dev, \
          libsasl2-dev
RUNDEPS=sqlite3, libevent-1.4-2, libglib2.0-0-dbg, libcurl3-gnutls, libsasl2-2

PKGNAME=$(NAME)
DOWNLOAD=http://membase.org/downloads/$(TARBALL)

TARBALL=$(NAME)_$(VERSION)-g638fc06_src.tar.gz
PKGNAME?=$(NAME)
SOURCEDIR=$(NAME)_$(VERSION)-g638fc06_src

.PHONY: default
default: 
	@echo "NorthScale provides their own deb packages, you should use that."
	@false

.PHONY: clean
clean: cleantar cleanbuild

cleantar:
	rm -f $(TARBALL)

cleanbuild:
	#rm $(NAME)-*deb $(NAME)_* || true
	rm -r $(SOURCEDIR) || true

$(TARBALL):
	[ -z "$(DOWNLOAD)" ] || wget "$(DOWNLOAD)"

sourcedir: $(SOURCEDIR)
$(SOURCEDIR): $(TARBALL)
	tar -zxf $(TARBALL)

.PHONY: patch
patch: $(SOURCEDIR)/debian
	sed -i -e "s/Build-Depends:.*/&, $(BUILDDEPS)/" $(SOURCEDIR)/debian/control
	sed -i -e "s/Depends:.*/&, $(RUNDEPS)/" $(SOURCEDIR)/debian/control
	cp rules $(SOURCEDIR)/debian/rules
	
	# Hack the membase/moxi build to be able to find its libs
	sed -i -re '/cd moxi .* && .\/configure/ { s@LDFLAGS@LD_LIBRARY_PATH=$$$$PWD/../lib/lib &@ }' $(SOURCEDIR)/Makefile
	# The release tarballs don't have git data, replace version checker with our value.
	#sed -i -re 's/git describe.* >/echo "$(VERSION)" >/' $(SOURCEDIR)/ns_server/Makefile

$(SOURCEDIR)/debian: $(SOURCEDIR)
	set -e; \
	cd $(SOURCEDIR); \
	dh_make -s -n -c gpl3 -e $$USER -p "$(PKGNAME)_$(VERSION)" < /dev/null

.PHONY: buildpackage
buildpackage: 
	cd $(SOURCEDIR); \
	debuild --preserve-envvar JAVA_HOME -uc -us

.PHONY: package
package: $(SOURCEDIR)
	rm -r $(SOURCEDIR)/debian || true
	$(MAKE) $(SOURCEDIR)/debian
	$(MAKE) patch
	$(MAKE) buildpackage
