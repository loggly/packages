NAME=djbdnsplus
VERSION=1.05.06
DOWNLOAD=http://github.com/jordansissel/djbdnsplus/tarball/v$(VERSION)
TARBALL=$(NAME)-$(VERSION).tar.gz
TARDIR=jordansissel-$(NAME)-*
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
	wget -O "$(TARBALL)" "$(DOWNLOAD)"

$(TARDIR): $(TARBALL)
	tar -zxf $(TARBALL)

.PHONY: package
package: $(TARDIR)
	cd $(TARDIR); \
	set -e; \
	rm -rf debian; \
	dh_make -s -n -c bsd -e $$USER -p "$(NAME)_$(VERSION)" < /dev/null; \
	sed -i -e "s/Build-Depends:.*/&, $(BUILDDEPS)/" debian/control; \
	sed -i -e "s/Depends:.*/&, $(RUNDEPS)/" debian/control; \
	[ -f ../rules ] && install ../rules debian/rules; \
	echo '/usr' > conf-home; \
	CFLAGS=$(CFLAGS) debuild -uc -us

.PHONY: clean
	rm djbdnsplus* || true
	rm -r jordansissel-djbdns*/ || true

