NAME=afterglow
VERSION=1.6.0
DOWNLOAD=http://sourceforge.net/projects/afterglow/files/AfterGlow%201.x/$(VERSION)/$(TARBALL)/download
TARBALL=$(NAME)-$(VERSION).tar.gz
TARDIR=$(NAME)
BUILDDEPS=perl
RUNDEPS=perl

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
	mkdir -p opt/afterglow; \
	mv * opt/afterglow; \
	fpm -p $(NAME)-VERSION_ARCH.deb -n $(NAME) -v $(VERSION) -s dir -t deb -d "perl" opt/afterglow
	mv $(TARDIR)/*.deb .
