VERSION=2.1.6
RELEASE=1
#DOWNLOAD=http://zeromq.wdfiles.com/local--files/area:download/zeromq-$(VERSION).tar.gz
NAME=jzmq
PKGNAME=zeromq-java
TARBALL=$(NAME)-$(VERSION).tgz
BUILDDEPS=autotools-dev, zeromq, libtool, autoconf, sun-java6-jdk
RUNDEPS=zeromq, sun-java6-jre
PKGNAME?=$(NAME)
SOURCEDIR=$(NAME)-$(VERSION)

.PHONY: default
default: package

.PHONY: clean
clean:
	rm $(NAME)-* $(NAME)_* || true
	rm -r $(SOURCEDIR) || true

$(TARBALL):
	[ -z "$(DOWNLOAD)" ] || wget "$(DOWNLOAD)"

$(SOURCEDIR): $(TARBALL)
	tar -zxf $(TARBALL)

.PHONY: patch
patch:
	sed -i -e "s/Build-Depends:.*/&, $(BUILDDEPS)/" $(SOURCEDIR)/debian/control
	sed -i -e "s/Depends:.*/&, $(RUNDEPS)/" $(SOURCEDIR)/debian/control
	cp rules $(SOURCEDIR)/debian/rules

$(SOURCEDIR)/debian:
	cd $(SOURCEDIR); \
	dh_make -s -n -c gpl3 -e $$USER -p "$(PKGNAME)_$(VERSION)-$(RELEASE)" < /dev/null

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
