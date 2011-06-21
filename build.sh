#!/bin/sh

case $1 in
	clean)
		rm -Rf pkg
		;;
	*)
		dpkg-deb --build src > /dev/null
		wget http://selenium.googlecode.com/files/selenium-server-standalone-2.0b3.jar -O src/usr/share/selenium-server/selenium-server.jar
		mkdir -p pkg
		mv src.deb pkg/selenium-server.deb
		;;
esac
