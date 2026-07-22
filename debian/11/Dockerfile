# tools/linux-tools-build-debian:11
FROM debian:11
MAINTAINER Arnaldo Carvalho de Melo <acme@kernel.org>
ENV DEBIAN_FRONTEND noninteractive
# Don't include capstone, it uses enum for the arches and new code uses things we don't have in this distro
RUN apt-get -y update && \
    apt-get -y install apt-utils && \
    apt-get -y install \
	make flex bison cpio \
	gcc g++ \
	bc findutils clang-13 llvm-13 \
	binutils-dev \
	libaudit-dev \
	libcap-dev \
	libdw-dev \
	libelf-dev \
	libgtk2.0-dev \
	libiberty-dev \
	liblzma-dev \
	libnuma-dev \
	libperl-dev \
	libslang2-dev \
	libssl-dev \
	libunwind-dev \
	libzstd-dev \
	python-dev-is-python3 \
	systemtap-sdt-dev \
	openjdk-11-jdk-headless \
	libbpf-dev \
	libtraceevent-dev bpftool dwz gawk \
	libbabeltrace-ctf-dev cmake xmlto asciidoc && \
    apt-get -y clean && \
    mkdir -m 777 -p /git /tmp/build/perf /tmp/build/objtool /tmp/build/linux && \
    groupadd -r toolsbuilder && \
    useradd -m -r -g toolsbuilder toolsbuilder && \
    ln /usr/bin/clang-13 /usr/bin/clang && \
    chown -R toolsbuilder.toolsbuilder /tmp/build/ /git/
USER toolsbuilder
COPY rx_and_build.sh /
COPY .bash_profile /home/toolsbuilder/
ENTRYPOINT ["/rx_and_build.sh"]
