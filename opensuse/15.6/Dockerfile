# tools/linux-tools-build-opensuse:15.6
FROM opensuse/leap:15.6
MAINTAINER Arnaldo Carvalho de Melo <acme@kernel.org>
RUN zypper -n update
RUN zypper -n install make gcc gcc-c++ flex bison curl tar xz libelf-devel libdw-devel \
		      clang clang-devel llvm llvm-devel cpio \
		      libunwind-devel openssl-devel \
		      slang-devel gtk2-devel perl python3-devel python3-setuptools \
		      systemtap-sdt-devel libzstd-devel libcap-devel \
		      binutils-devel xz-devel libnuma-devel OpenCSD-devel \
		      cmake xmlto asciidoc libtraceevent-devel libbpf-devel \
		      libcapstone-devel
RUN zypper clean --all && \
    mkdir -m 777 -p /git /tmp/build/perf /tmp/build/objtool /tmp/build/linux && \
    groupadd -r toolsbuilder && \
    useradd -m -r -g toolsbuilder toolsbuilder && \
    chown -R toolsbuilder.toolsbuilder /tmp/build/ /git/
USER toolsbuilder
COPY rx_and_build.sh /
COPY .bash_profile /home/toolsbuilder/
ENTRYPOINT ["/rx_and_build.sh"]
