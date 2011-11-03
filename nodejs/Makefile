NAME=node
VERSION=0.4.8
BUILDDEPS=libssl-dev, autotools-dev, libev-dev
RUNDEPS=libssl0.9.8, libev3

PKGNAME=nodejs
DOWNLOAD=http://nodejs.org/dist/$(TARBALL)

TARBALL=$(NAME)-v$(VERSION).tar.gz
PKGNAME?=$(NAME)
SOURCEDIR=$(NAME)-v$(VERSION)

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
	cp rules $(SOURCEDIR)/debian/rules

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
