VERSION=5.4.1
DOWNLOAD=http://apache.cs.utah.edu/activemq/apache-activemq/$(VERSION)/apache-activemq-$(VERSION)-bin.tar.gz
NAME=apache-activemq
TARBALL=$(NAME)-$(VERSION)-bin.tar.gz
BUILDDEPS=
RUNDEPS=java-runtime

#CFLAGS=-g

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
	dh_make -s -n -c gpl3 -e $$USER -p "$(NAME)_$(VERSION)" < /dev/null; \
	sed -i -e "s/Build-Depends:.*/&, $(BUILDDEPS)/" debian/control; \
	sed -i -e "s/Depends:.*/&, $(RUNDEPS)/" debian/control; \
	[ -f ../rules ] && install ../rules debian/rules; \
	install ../Makefile.activemq Makefile; \
	CFLAGS=$(CFLAGS) debuild -uc -us

