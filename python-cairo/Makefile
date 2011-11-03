NAME=pycairo
VERSION=1.8.10
TARDIR=$(NAME)-$(VERSION)

# It's "py2cairo" for python 2.x

py2cairo-$(VERSION).tar.gz:
	wget http://cairographics.org/releases/py2cairo-1.8.10.tar.gz

$(TARDIR): py2cairo-$(VERSION).tar.gz
	tar -zxf $<

usr: $(TARDIR)
	cd $(TARDIR); python setup.py bdist
	tar -zxf $(TARDIR)/dist/$(NAME)-$(VERSION).linux-$(shell uname -m).tar.gz
	# Move files to the right place.
	rsync -av  ./usr/local/lib/ ./usr/lib/
	rm -r ./usr/local/lib

package: usr
	fpm -s dir -t deb -n python-$(NAME) -v $(VERSION) \
		-p python-$(NAME)-VERSION_ARCH.deb -d "python" \
		-d "libcairo2 (>= 1.8.6)" \
		usr
