# tools/linux-tools-build-ubuntu:26.04
FROM docker.io/library/ubuntu:26.04
MAINTAINER Arnaldo Carvalho de Melo <acme@kernel.org>
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update && \
    apt-get -y install \
	make gcc g++ git flex bison curl file man \
	bc findutils clang llvm curl rustc cargo \
	libclang-dev llvm-dev libcap-dev \
	libunwind8-dev libssl-dev libslang2-dev python3-dev python3-setuptools \
	systemtap-sdt-dev libgtk2.0-dev liblzma-dev binutils-dev \
	libelf-dev libiberty-dev libdw-dev libaudit-dev libtraceevent-dev libbpf-dev \
	libperl-dev libnuma-dev libzstd-dev cmake xmlto asciidoc libcapstone-dev && \
    apt-get -y clean && \
    mkdir -m 777 -p /git /tmp/build/perf /tmp/build/objtool /tmp/build/linux && \
    groupadd -r toolsbuilder && \
    useradd -m -r -g toolsbuilder toolsbuilder && \
    chown -R toolsbuilder.toolsbuilder /tmp/build/ /git/
USER toolsbuilder
COPY rx_and_build.sh /
COPY .bash_profile /home/toolsbuilder/
ENTRYPOINT ["/rx_and_build.sh"]
