# tools/linux-tools-build-opensuse:tumbleweed
FROM docker.io/opensuse/tumbleweed
MAINTAINER Arnaldo Carvalho de Melo <acme@kernel.org>
# shadow for groupadd
RUN zypper -n update && \
    zypper -n install shadow \
	make gcc gcc-c++ flex bison cpio git openssh-clients vim-enhanced \
	bc file findutils clang llvm curl tar xz \
	libunwind-devel openssl-devel slang-devel python3-devel python3-setuptools \
	dwz debuginfod-client bpftool \
	systemtap-sdt-devel gtk2-devel xz-devel binutils-devel \
	libelf-devel libdw-devel audit-devel libzstd-devel \
	java-1_8_0-openjdk-headless libcap-devel \
	clang-devel llvm-devel perl libnuma-devel \
	libbpf-devel libtraceevent-devel libcapstone-devel \
	babeltrace-devel OpenCSD-devel cmake xmlto asciidoc && \
    zypper clean --all && \
    mkdir -m 777 -p /git /tmp/build/perf /tmp/build/objtool /tmp/build/linux && \
    groupadd -r toolsbuilder && \
    useradd -m -r -g toolsbuilder toolsbuilder && \
    chown -R toolsbuilder.toolsbuilder /tmp/build/ /git/
USER toolsbuilder
COPY rx_and_build.sh /
COPY .bash_profile /home/toolsbuilder/
ENTRYPOINT ["/rx_and_build.sh"]
