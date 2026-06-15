# tools/linux-tools-build-almalinux:9-i386
FROM docker.io/almalinux/i386:9
MAINTAINER Arnaldo Carvalho de Melo <acme@kernel.org>
RUN dnf -y update --nobest
RUN dnf -y install make gcc gcc-c++ flex bison bc git openssl clang llvm yum-utils
RUN dnf -y config-manager --set-enabled crb
# Don't include capstone, it uses enum for the arches and new code uses things we don't have in this distro
RUN dnf -y install clang-devel llvm-devel cmake pkg-config \
		   elfutils-libelf-devel elfutils-devel \
		   audit-libs-devel openssl-devel slang-devel \
		   gtk2-devel perl-ExtUtils-Embed binutils-devel \
		   systemtap-sdt-devel xz-devel numactl-devel libcap-devel asciidoc xmlto \
		   libtraceevent-devel libbpf-devel \
		   vim git diffutils python3-devel python3-setuptools
RUN dnf -y clean all && \
    mkdir -m 777 -p /git /tmp/build/perf /tmp/build/objtool /tmp/build/linux && \
    groupadd -r toolsbuilder && \
    useradd -m -r -g toolsbuilder toolsbuilder && \
    chown -R toolsbuilder.toolsbuilder /tmp/build/ /git/
USER toolsbuilder
COPY rx_and_build.sh /
COPY .bash_profile /home/toolsbuilder/
ENTRYPOINT ["/rx_and_build.sh"]
