# tools/linux-tools-build-debian:experimental
FROM debian:experimental
MAINTAINER Arnaldo Carvalho de Melo <acme@kernel.org>
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update && \
    apt-get -y install apt-utils make flex bison curl bc findutils \
	gcc g++ clang llvm git \
	binutils-dev \
	libclang-dev \
	libbpf-dev \
	libtraceevent-dev \
	llvm-dev \
	libcap-dev \
	libcapstone-dev \
	libdw-dev \
	libelf-dev \
	libgtk2.0-dev \
	libiberty-dev \
	liblzma-dev \
	libnuma-dev \
	libperl-dev \
	libslang2-dev \
	libssl-dev \
	libzstd-dev \
	libunwind-dev \
	python-dev-is-python3 \
	python3-setuptools \
	systemtap-sdt-dev \
        libbabeltrace-ctf-dev cmake xmlto asciidoc && \
    apt-get -y clean && \
    mkdir -m 777 -p /git /tmp/build/perf /tmp/build/objtool /tmp/build/linux && \
    groupadd -r toolsbuilder && \
    useradd -m -r -g toolsbuilder toolsbuilder && \
    chown -R toolsbuilder.toolsbuilder /tmp/build/ /git/
USER toolsbuilder
COPY rx_and_build.sh /
COPY .bash_profile /home/toolsbuilder/
ENTRYPOINT ["/rx_and_build.sh"]
