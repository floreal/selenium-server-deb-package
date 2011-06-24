#!/bin/sh

version=$2
here=`dirname $0`
dest_dl_dir=$here/servers
src_dir=$here/src
build_dir=$here/build
pkg_dir=$here/pkg

select_version() {
	if [ -z $version ] ; then
		version=2.0rc2
	fi
	echo "Builing version $version"
}

make_dirs() {
	echo "Creating directories ..."
	mkdir -p $pkg_dir
	mkdir -p $build_dir
	mkdir -p $dest_dl_dir
	mkdir -p $src_dir/usr/share/selenium-server
	mkdir -p $src_dir/var/lib/selenium-server
	mkdir -p $src_dir/var/log/selenium-server
	mkdir -p $src_dir/var/run/selenium-server
}

download() {
	echo "Downloading selenium-server ..."
	jar=selenium-server-standalone-$version.jar
	selected_file=$dest_dl_dir/$jar
	if [ ! -f $selected_file ] ; then
		wget -nv http://selenium.googlecode.com/files/$jar -O $selected_file || exit 1
	else
		echo "  File already downloaded." 
	fi
}

build() {
	echo "Processing ..."
	rm -Rf $build_dir
	cp -R $src_dir $build_dir
	find $build_dir -type f -exec sed -i s/%VERSION%/$version/g {} \;
	cp $selected_file $build_dir/usr/share/selenium-server/selenium-server.jar
}

clean() {
	echo "Cleanning ..."
	rm -Rf $pkg_dir $build_dir $dest_dl_dir
}

package() {
	echo 'Packaging ...'
	dpkg-deb --build $build_dir > /dev/null
	mv $here/build.deb $pkg_dir/selenium-server-$version.deb	
}

usage() {
	echo "usage:"
	echo "  `basename $0` pkg [ version ]"
	echo "  `basename $0` clean"
}

case $1 in
	clean)
		clean
		;;
	pkg)
		select_version
		make_dirs
		download
		build
		package
		;;
	*)
		usage
esac
