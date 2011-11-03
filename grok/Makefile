NAME=grok
VERSION=1.20101018.3074
DOWNLOAD=http://semicomplete.googlecode.com/files/$(NAME)-$(VERSION).tar.gz
TARBALL=$(NAME)-$(VERSION).tar.gz
TARDIR=$(NAME)-$(VERSION)
BUILDDEPS=libpcre3-dev,libtokyocabinet-dev,bison,flex,gperf,libevent-dev
RUNDEPS=libpcre3,libtokyocabinet8,libevent-1.4-2

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

.PHONY: package
package: $(TARDIR)
	cd $(TARDIR); \
	set -e; \
	rm -rf debian; \
	dh_make -s -n -c bsd -e $$USER -p "$(NAME)_$(VERSION)" < /dev/null; \
	sed -i -e "s/Build-Depends:.*/&, $(BUILDDEPS)/" debian/control; \
	sed -i -e "s/Depends:.*/&, $(RUNDEPS)/" debian/control; \
	[ -f ../rules ] && install ../rules debian/rules; \
	CFLAGS=$(CFLAGS) debuild -uc -us

