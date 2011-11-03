VERSION=0.12.1
DOWNLOAD=http://github.com/downloads/elasticsearch/elasticsearch/elasticsearch-$(VERSION).zip
NAME=elasticsearch
TARBALL=$(NAME)-$(VERSION).zip
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
	wget --no-check-certificate "$(DOWNLOAD)"

$(NAME)-$(VERSION): $(TARBALL)
	unzip $(TARBALL)

.PHONY: package
package: $(NAME)-$(VERSION)
	cd $(NAME)-$(VERSION); \
	set -e; \
	rm -rf debian; \
	dh_make -s -n -c apache -e $$USER -p "$(NAME)_$(VERSION)" < /dev/null; \
	sed -i -e "s/Build-Depends:.*/&, $(BUILDDEPS)/" debian/control; \
	sed -i -e "s/Depends:.*/&, $(RUNDEPS)/" debian/control; \
	[ -f ../rules ] && install ../rules debian/rules; \
	install ../Makefile.elasticsearch Makefile; \
	CFLAGS=$(CFLAGS) debuild -uc -us

