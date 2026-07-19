# tools/linux-tools-build-fedora:rawhide
FROM fedora:rawhide
MAINTAINER Arnaldo Carvalho de Melo <acme@kernel.org>
RUN dnf -y --nogpgcheck update
RUN dnf -y install make gcc gcc-c++ flex bison xz \
	bc file findutils clang llvm git which gawk rust \
	libunwind-devel openssl-devel slang-devel python-devel libzstd-devel \
	systemtap-sdt-devel gtk2-devel xz-devel binutils-devel \
	elfutils-libelf-devel elfutils-devel audit-libs-devel \
	numactl-devel clang-devel llvm-devel libcap-devel opencsd-devel \
	redhat-rpm-config java-latest-openjdk-devel perl-ExtUtils-Embed \
	libtraceevent-devel libbpf-devel capstone-devel \
	cmake xmlto asciidoc bpftool dwz && \
    dnf -y clean all && \
    mkdir -m 777 -p /git /tmp/build/perf /tmp/build/objtool /tmp/build/linux && \
    groupadd -r toolsbuilder && \
    useradd -m -r -g toolsbuilder toolsbuilder && \
    chown -R toolsbuilder.toolsbuilder /tmp/build/ /git/
RUN dnf -y install libtirpc-devel rpcgen
USER toolsbuilder
COPY rx_and_build.sh /
COPY .bash_profile /home/toolsbuilder/
ENTRYPOINT ["/rx_and_build.sh"]
