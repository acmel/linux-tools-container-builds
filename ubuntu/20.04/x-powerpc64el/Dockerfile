# tools/linux-tools-build-ubuntu:20.04-x-powerpc64el
FROM docker.io/library/ubuntu:20.04
# LIBBPF=1 requires python3
MAINTAINER Arnaldo Carvalho de Melo <acme@kernel.org>
ENV DEBIAN_FRONTEND noninteractive
# ubuntu doesn't have the other devel packages for this target, so build just the basic tool
# libelf-dev is needed to build objtool, which is a host tool, not being cross compiled.
# It will check the cross compiled kernel objects
# It will not be used tho, as there is no support to check binaries for this arch yet
ENV ARCH powerpc
ENV TARGET powerpc64le-linux-gnu
RUN apt-get -y update && \
    apt-get -y install make gcc-10-${TARGET} g++-10-${TARGET} pkg-config-${TARGET} flex bison python python-dev python3-dev cmake wget curl bzip2 xmlto asciidoc && \
    apt-get clean
RUN export ELFUTILS_VER=0.180 && \
    export ZLIB_VER=1.3.1 && \
    export INSTALLDIR=/usr/${TARGET} && \
    export PATH=$INSTALLDIR/bin:$PATH && \
    export TARGETMACH=${TARGET} && \
    export CROSS=${TARGET}- && \
    export CC=${CROSS}gcc-10 && \
    export CXX=${CROSS}g++-10 && \
    export LD=${CROSS}ld && \
    export AS=${CROSS}as && \
    wget -q http://zlib.net/zlib-${ZLIB_VER}.tar.gz && \
    wget -q https://fedorahosted.org/releases/e/l/elfutils/${ELFUTILS_VER}/elfutils-${ELFUTILS_VER}.tar.bz2 && \
    tar xf zlib-${ZLIB_VER}.tar.gz && \
    cd zlib-${ZLIB_VER} && \
    ./configure --prefix=${INSTALLDIR} && \
    make && \
    make install && \
    cd .. && \
    rm -rf zlib-${ZLIB_VER} && \
    rm -f zlib-${ZLIB_VER}.tar.gz && \
    tar xf elfutils-${ELFUTILS_VER}.tar.bz2 && \
    cd elfutils-${ELFUTILS_VER} && \
    ./configure --host=${TARGET} --prefix=${INSTALLDIR} --disable-debuginfod && \
    make && \
    make install && \
    cd .. && \
    rm -rf elfutils-${ELFUTILS_VER} && \
    apt-get -y remove wget bzip2 && \
    apt-get clean && \
    unset INSTALLDIR TARGETMACH CROSS CC LD AS && \
    mkdir -m 777 -p /git /tmp/build/perf /tmp/build/objtool /tmp/build/linux && \
    groupadd -r toolsbuilder && \
    useradd -m -r -g toolsbuilder toolsbuilder && \
    chown -R toolsbuilder.toolsbuilder /tmp/build/ /git/
RUN ln -s /usr/bin/${TARGET}-gcc-10 /usr/bin/${TARGET}-gcc
USER toolsbuilder
COPY rx_and_build.sh /
ENV CROSS_COMPILE=${TARGET}-
ENV EXTRA_MAKE_ARGS=NO_LIBTRACEEVENT=1
COPY .bash_profile /home/toolsbuilder/
ENTRYPOINT ["/rx_and_build.sh"]
