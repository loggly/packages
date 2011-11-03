VERSION=2.1.6
RELEASE=1
DOWNLOAD=http://download.zeromq.org/zeromq-$(VERSION).tar.gz
NAME=zeromq
TARBALL=$(NAME)-$(VERSION).tar.gz
BUILDDEPS=autotools-dev, libssl-dev, uuid-dev
RUNDEPS=libssl0.9.8, libuuid1

CFLAGS=-g

.PHONY: default
default: package

.PHONY: clean
clean:
	rm $(NAME)-* $(NAME)_* || true
	rm -r $(NAME)-$(VERSION) || true

$(TARBALL):
	wget "$(DOWNLOAD)"


$(NAME)-$(VERSION): $(TARBALL)
	tar -zxf $(TARBALL)

.PHONY: package
package: $(NAME)-$(VERSION)
	cd $(NAME)-$(VERSION); \
	set -e; \
	rm -rf debian; \
	dh_make -s -n -c gpl3 -e $$USER -p "$(NAME)_$(VERSION)-$(RELEASE)" < /dev/null; \
	sed -i -e "s/Build-Depends:.*/&, $(BUILDDEPS)/" debian/control; \
	sed -i -e "s/Depends:.*/&, $(RUNDEPS)/" debian/control; \
	install ../rules debian/rules; \
	CFLAGS=$(CFLAGS) debuild -uc -us -b

