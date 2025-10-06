#!/bin/sh
# Copyright (c) Red Hat Inc. 2017-
# Arnaldo Carvalho de Melo <acme@redhat.com>
# cross build Dockerfiles must have ENV lines for ARCH and CROSS_COMPILE


build_perf_gcc() {
	set -o xtrace
	make $EXTRA_MAKE_ARGS ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE EXTRA_CFLAGS="$EXTRA_CFLAGS" -C tools/perf O=/tmp/build/perf || exit 1
	rm -rf /tmp/build/perf ; mkdir /tmp/build/perf
	make $EXTRA_MAKE_ARGS ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE EXTRA_CFLAGS="$EXTRA_CFLAGS" NO_LIBELF=1 -C tools/perf O=/tmp/build/perf || exit 1
	rm -rf /tmp/build/perf ; mkdir /tmp/build/perf
	make $EXTRA_MAKE_ARGS ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE EXTRA_CFLAGS="$EXTRA_CFLAGS" NO_LIBBPF=1 -C tools/perf O=/tmp/build/perf || exit 1
	set +o xtrace
}

build_perf_clang() {
	set -o xtrace

	if [ ! $NO_BUILD_BPF_SKEL ] ; then
		rm -rf /tmp/build/perf ; mkdir /tmp/build/perf
		make $EXTRA_MAKE_ARGS $EXTRA_MAKE_ARGS_CLANG ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE EXTRA_CFLAGS="$EXTRA_CFLAGS" BUILD_BPF_SKEL=1 -C tools/perf O=/tmp/build/perf || exit 1
	fi

	rm -rf /tmp/build/perf ; mkdir /tmp/build/perf
	make $EXTRA_MAKE_ARGS $EXTRA_MAKE_ARGS_CLANG ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE EXTRA_CFLAGS="$EXTRA_CFLAGS" -C tools/perf O=/tmp/build/perf CC=clang || exit 1
	rm -rf /tmp/build/perf ; mkdir /tmp/build/perf
	make $EXTRA_MAKE_ARGS $EXTRA_MAKE_ARGS_CLANG ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE EXTRA_CFLAGS="$EXTRA_CFLAGS" NO_LIBELF=1 -C tools/perf O=/tmp/build/perf CC=clang || exit 1
	rm -rf /tmp/build/perf ; mkdir /tmp/build/perf
	make $EXTRA_MAKE_ARGS $EXTRA_MAKE_ARGS_CLANG ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE EXTRA_CFLAGS="$EXTRA_CFLAGS" NO_LIBBPF=1 -C tools/perf O=/tmp/build/perf CC=clang || exit 1
	set +o xtrace
}

export PATH=$PATH:$EXTRA_PATH

TARBALL_URL=$1

if [ -z "$TARBALL_URL" ] ; then
	echo "usage: rx_and_build.sh tarball [build_script]"
	exit 1
fi

shift
BUILD_CMD="$*"

cd /git
echo "Downloading $TARBALL_URL..."
curl -OL $TARBALL_URL || wget $TARBALL_URL
TARBALL=`basename $TARBALL_URL`
xzcat $TARBALL | tar xvf -
SRCDIR=`echo $TARBALL | sed -r 's/(.*).tar\..*/\1/g'` 
cd /git/$SRCDIR
test -f HEAD && (echo -n BUILD_TARBALL_HEAD= ; cat HEAD)

# print the version for dm to harvest and put in the status line
${CROSS_COMPILE}gcc -v

if [ -z "$BUILD_CMD" ] ; then
	build_perf_gcc
else
	$BUILD_CMD $EXTRA_MAKE_ARGS ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE EXTRA_CFLAGS="$EXTRA_CFLAGS" || exit 1
fi

# So that we can see if we're exiting via the NO_CLANG path, i.e. if --env NO_CLANG=1 was used in 'dm'
set -o xtrace
# Allow for explicitely asking to avoid building with clang even if present
# ClearLinux had this problem at some point
[ $NO_CLANG ] && exit 0
set +o xtrace

# Bail ou if we don't have clang, print the version for dm to harvest and put in the status line
clang -v || exit 0

if [ -z "$BUILD_CMD" ] ; then
	build_perf_clang
else
	CC=clang $BUILD_CMD $EXTRA_MAKE_ARGS $EXTRA_MAKE_ARGS_CLANG ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE EXTRA_CFLAGS="$EXTRA_CFLAGS" CC=clang
fi
