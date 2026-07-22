# tools/linux-tools-build-ubuntu:24.04
FROM docker.io/library/ubuntu:24.04
MAINTAINER Arnaldo Carvalho de Melo <acme@kernel.org>
ENV DEBIAN_FRONTEND noninteractive
# Don't include capstone, it uses enum for the arches and new code uses things we don't have in this distro
RUN apt-get -y update && \
    apt-get -y install \
	make gcc g++ git flex bison curl file man \
	dwz debuginfod gawk \
	bc findutils clang llvm curl \
	libclang-dev llvm-dev libcap-dev \
	libunwind8-dev libssl-dev libslang2-dev python3-dev python3-setuptools \
	systemtap-sdt-dev libgtk2.0-dev liblzma-dev binutils-dev \
	libelf-dev libiberty-dev libdw-dev libaudit-dev libtraceevent-dev libbpf-dev \
	libperl-dev libnuma-dev libzstd-dev cmake xmlto asciidoc && \
    apt-get -y clean && \
    mkdir -m 777 -p /git /tmp/build/perf /tmp/build/objtool /tmp/build/linux && \
    groupadd -r toolsbuilder && \
    useradd -m -r -g toolsbuilder toolsbuilder && \
    chown -R toolsbuilder.toolsbuilder /tmp/build/ /git/
RUN git clone --recurse-submodules https://github.com/libbpf/bpftool.git /tmp/bpftool && \
    cd /tmp/bpftool/src && \
    make && \
    make install && \
    rm -rf /tmp/bpftool
USER toolsbuilder
COPY rx_and_build.sh /
COPY .bash_profile /home/toolsbuilder/
ENTRYPOINT ["/rx_and_build.sh"]
