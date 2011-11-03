NAME=graphite-web
VERSION=0.9.9
DOWNLOAD=http://launchpad.net/graphite/0.9/$(VERSION)/+download/$(NAME)-$(VERSION).tar.gz
TARBALL=$(NAME)-$(VERSION).tar.gz
TARDIR=$(NAME)-$(VERSION)
BUILDDEPS=python
RUNDEPS=python

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

.PHONY: package
package: $(TARDIR)
	cd $(TARDIR); \
	yes | sh ../../python2deb.sh
