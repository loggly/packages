NAME=collectd-collection
VERSION=4.0.0
BUILDDEPS=autotools-dev, libfcgi-dev, librrd-dev, libyajl-dev
RUNDEPS=libfcgi0ldbl, librrd4, libyajl1

PKGNAME?=collection
TARBALL=$(PKGNAME)-$(VERSION).tar.gz
DOWNLOAD=http://octo.it/c4/files/$(TARBALL)

SOURCEDIR=$(PKGNAME)-$(VERSION)

.PHONY: default
default: package

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
	[ -f rules ] && cp rules $(SOURCEDIR)/debian/rules; true

$(SOURCEDIR)/debian: $(SOURCEDIR)
	set -e; \
	cd $(SOURCEDIR); \
	dh_make -s -n -c gpl3 -e $$USER -p "$(PKGNAME)_$(VERSION)" < /dev/null

.PHONY: buildpackage
buildpackage: 
	cd $(SOURCEDIR); \
	debuild --preserve-envvar JAVA_HOME -us -uc -b

.PHONY: package
package: $(SOURCEDIR)
	rm -r $(SOURCEDIR)/debian || true
	$(MAKE) $(SOURCEDIR)/debian
	$(MAKE) patch
	$(MAKE) buildpackage
