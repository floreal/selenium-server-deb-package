#!/bin/sh

make_dirs()
{
	echo "Creating directories..."
	mkdir -p pkg
	mkdir -p src/usr/share/selenium-server
	mkdir -p src/var/lib/selenium-server
	mkdir -p src/var/log/selenium-server
	mkdir -p src/var/run/selenium-server
}

case $1 in
	clean)
		rm -Rf pkg
		;;
	*)
		make_dirs
		echo "Downloading selenium-server..."
		wget http://selenium.googlecode.com/files/selenium-server-standalone-2.0b3.jar -O src/usr/share/selenium-server/selenium-server.jar
		echo "Building debian package..."
		dpkg-deb --build src > /dev/null
		mv src.deb pkg/selenium-server.deb
		;;
esac
