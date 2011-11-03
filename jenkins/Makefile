NAME=jenkins
VERSION=1.425

.PHONY: package
package:
	rm -f jenkins.war
	wget http://ftp.osuosl.org/pub/hudson/war/$(VERSION)/jenkins.war
	fpm -s dir -t deb -n $(NAME) -v $(VERSION) --prefix /opt/jenkins -d "sun-java6-jre (> 0)" jenkins.war


