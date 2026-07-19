# tools/linux-tools-build-fedora:43
FROM fedora:43
MAINTAINER Arnaldo Carvalho de Melo <acme@kernel.org>
RUN dnf -y install make gcc gcc-c++ flex bison elfutils-libelf-devel xz
RUN dnf -y install bc file findutils clang llvm openssl git diffutils \
		   elfutils-devel libunwind-devel gawk which \
		   openssl-devel slang-devel gtk2-devel perl-ExtUtils-Embed \
		   python3-devel python3-setuptools binutils-devel xz-devel numactl-devel systemtap-sdt-devel \
		   clang-devel llvm-devel redhat-rpm-config libcap-devel \
		   java-latest-openjdk-devel libzstd-devel opencsd-devel \
		   libtraceevent-devel libbpf-devel bpftool dwz \
		   cmake asciidoc xmlto capstone-devel
RUN dnf -y update && \
    dnf -y clean all && \
    mkdir -m 777 -p /git /tmp/build/perf /tmp/build/objtool /tmp/build/linux && \
    groupadd -r toolsbuilder && \
    useradd -m -r -g toolsbuilder toolsbuilder && \
    chown -R toolsbuilder.toolsbuilder /tmp/build/ /git/
USER toolsbuilder
COPY rx_and_build.sh /
COPY .bash_profile /home/toolsbuilder/
ENTRYPOINT ["/rx_and_build.sh"]
