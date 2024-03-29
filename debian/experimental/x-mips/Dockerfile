# tools/linux-tools-build-debian:experimental-x-mips
FROM debian:experimental
MAINTAINER Arnaldo Carvalho de Melo <acme@kernel.org>
# See debian:experimental-x-mips/Dockerfile for info about why
# objtool and samples/bpf are disabled
# We need libc6-dev to build hostprogs such as 'fixdep'
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update && \
    apt-get -y install apt-utils make flex bison curl bc findutils build-essential cmake xmlto asciidoc vim strace exuberant-ctags && \
    apt-get -y clean && \
    rm -rf /usr/share/doc /usr/share/gtk-doc /usr/share/locale /usr/share/man
ENV ARCH mips
ENV DEBIAN_ARCH mips
ENV TARGET mips-linux-gnu
RUN dpkg --add-architecture ${DEBIAN_ARCH} && \
    apt-get -y update && \
    apt-get -y install \
	libc6-dev \
	binutils-${TARGET} \
	gcc-${TARGET} \
	g++-${TARGET} \
	libc6-dev-mips-cross
#RUN apt-get -y install libaudit-dev:${DEBIAN_ARCH} libelf-dev:${DEBIAN_ARCH} liblzma-dev:${DEBIAN_ARCH} libnuma-dev:${DEBIAN_ARCH} libslang2-dev:${DEBIAN_ARCH} libssl-dev:${DEBIAN_ARCH} libunwind-dev:${DEBIAN_ARCH} systemtap-sdt-dev:${DEBIAN_ARCH}
RUN apt-get -y clean && \
    unset TARGET INSTALLDIR TARGETMACH CROSS CC LD AS && \
    rm -rf /usr/share/doc /usr/share/gtk-doc /usr/share/locale /usr/share/man
COPY perf_regs.h /usr/mips-linux-gnu/include/asm/
RUN mkdir -m 777 -p /git /tmp/build/perf /tmp/build/objtool /tmp/build/linux && \
    groupadd -r toolsbuilder && \
    useradd -m -r -g toolsbuilder toolsbuilder && \
    chown -R toolsbuilder.toolsbuilder /tmp/build/ /git/
USER toolsbuilder
COPY rx_and_build.sh /
ENV CROSS_COMPILE=${TARGET}-
COPY .bash_profile /home/toolsbuilder/
ENV EXTRA_MAKE_ARGS=NO_LIBTRACEEVENT=1 NO_LIBELF=1
ENTRYPOINT ["/rx_and_build.sh"]
