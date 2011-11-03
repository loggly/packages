#VERSION=0.2.2
TARDIR=django-piston

.PHONY: default
default: package

.PHONY: clean
clean:
	rm -r $(TARDIR) || true
	rm -r python-django-piston_0.2.2-*

.PHONY: package
package:
	yes | PATCHES=../patch.sh sh -x ../python2deb.sh django-piston 
