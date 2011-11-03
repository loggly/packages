VERSION=1.3
DOWNLOAD=http://media.djangoproject.com/releases/1.3/Django-$(VERSION).tar.gz
NAME=python-django
TARBALL=Django-$(VERSION).tar.gz
TARDIR=Django-$(VERSION)

# TODO(sissel): Find dependencies
BUILDDEPS=
RUNDEPS=

#CFLAGS=-g

.PHONY: default
default: package

.PHONY: clean
clean:
	rm $(NAME)-* $(NAME)_* || true
	rm -r $(TARDIR) || true

$(TARBALL):
	wget "$(DOWNLOAD)"

$(TARDIR): $(TARBALL)
	tar -zxf $(TARBALL)

.PHONY: patch
patch:
	patch -p0 -d $(TARDIR) < patches/web/0001-Fix-determination-of-remote-host.patch
	patch -p0 -d $(TARDIR) < patches/web/0002-Make-auth-models-methods-log-some-stuff.patch

.PHONY: package
package: $(TARDIR)
	$(MAKE) patch
	cd $(TARDIR); \
	set -e; \
	rm -rf debian; \
	sh ../../python2deb.sh

