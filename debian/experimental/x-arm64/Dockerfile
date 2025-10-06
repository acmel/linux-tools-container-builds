# tools/linux-tools-build-debian:experimental-x-arm64
# libelf-dev, a host package, is needed to build objtool, that will run
# on the host checking target object files. It is also needed for samples/bpf/,
# but that is disabled as cross compilation is not available for it, would require
# a cross clang, etc.
# objtool is disabled because it requires a per arch function that is
# missing for
# arm64:
# make[1]: Leaving directory '/git/linux/tools/objtool'
#   LINK     /tmp/build/objtool/objtool
# /tmp/build/objtool/objtool-in.o: In function `decode_instructions':
# /git/linux/tools/objtool/builtin-check.c:296: undefined reference to `arch_decode_instruction'
# collect2: error: ld returned 1 exit status
# Makefile:45: recipe for target '/tmp/build/objtool/objtool' failed
# make: *** [/tmp/build/objtool/objtool] Error 1
# make: Leaving directory '/git/linux/tools/objtool'
# debian:experimental-x-arm64: FAIL
# bc, findutils, libssl-dev needed to build samples/bpf/
FROM debian:experimental
MAINTAINER Arnaldo Carvalho de Melo <acme@kernel.org>
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update && \
    apt-get -y install apt-utils vim make flex bison curl bc findutils build-essential git cmake xmlto asciidoc python3-dev  && \
    apt-get -y install clang llvm libclang-dev llvm-dev libcap-dev \
	libunwind8-dev libssl-dev libslang2-dev python3-dev python3-setuptools \
	systemtap-sdt-dev libgtk2.0-dev liblzma-dev binutils-dev \
	libelf-dev libiberty-dev libdw-dev libaudit-dev libtraceevent-dev libbpf-dev \
	libperl-dev libnuma-dev libzstd-dev cmake xmlto asciidoc && \
    apt-get -y clean && \
    rm -rf /usr/share/doc /usr/share/gtk-doc /usr/share/locale /usr/share/man
ENV ARCH arm64
ENV TARGET aarch64-linux-gnu
RUN dpkg --add-architecture ${ARCH} && \
    apt-get -y update && \
    apt-get -y install \
	crossbuild-essential-${ARCH} \
	libaudit-dev:${ARCH} \
	libdw-dev:${ARCH} \
	libelf-dev:${ARCH} \
	liblzma-dev:${ARCH} \
	libnuma-dev:${ARCH} \
	libperl-dev:${ARCH} \
	libslang2-dev:${ARCH} \
	libssl-dev:${ARCH} \
	libunwind-dev:${ARCH} \
	systemtap-sdt-dev:${ARCH} && \
    apt-get -y clean && \
    unset TARGET INSTALLDIR TARGETMACH CROSS CC LD AS
RUN mkdir -m 777 -p /git /tmp/build/perf /tmp/build/objtool /tmp/build/linux && \
    groupadd -r toolsbuilder && \
    useradd -m -r -g toolsbuilder toolsbuilder && \
    chown -R toolsbuilder.toolsbuilder /tmp/build/ /git/
USER toolsbuilder
COPY rx_and_build.sh /
COPY .bash_profile ~toolsbuilder/
ENV CROSS_COMPILE=${TARGET}-
ENV EXTRA_MAKE_ARGS=NO_LIBTRACEEVENT=1
ENTRYPOINT ["/rx_and_build.sh"]

