

VERSION=1.1.0
REL=4

package: mcollective_$(VERSION)-$(REL)_all.deb \
         mcollective-client_$(VERSION)-$(REL)_all.deb \
         mcollective-common_$(VERSION)-$(REL)_all.deb \
         mcollective-doc_$(VERSION)-$(REL)_all.deb \

%.deb:
	wget http://puppetlabs.com/downloads/mcollective/$@
