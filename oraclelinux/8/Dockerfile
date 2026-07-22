# tools/linux-tools-build-oraclelinux:8
FROM oraclelinux:8
MAINTAINER Arnaldo Carvalho de Melo <acme@kernel.org>
# libunwind-devel
RUN dnf -y update
RUN dnf -y install yum-utils
RUN dnf -y config-manager --set-enabled ol8_codeready_builder
RUN dnf -y install make gcc gcc-c++ flex bison \
		   clang clang-devel llvm llvm-devel \
		   dwz elfutils-debuginfod-client bpftool \
		   bc tar xz elfutils-libelf-devel elfutils-devel \
		   audit-libs-devel openssl-devel slang-devel libzstd-devel  \
		   gtk2-devel perl-ExtUtils-Embed python3-devel binutils-devel \
		   systemtap-sdt-devel xz-devel numactl-devel libcap-devel \
		   java-1.8.0-openjdk-devel cmake xmlto asciidoc \
		   libtraceevent-devel libbpf-devel && \
    dnf -y clean all && \
    mkdir -m 777 -p /git /tmp/build/perf /tmp/build/objtool /tmp/build/linux && \
    groupadd -r toolsbuilder && \
    useradd -m -r -g toolsbuilder toolsbuilder && \
    chown -R toolsbuilder.toolsbuilder /tmp/build/ /git/
USER toolsbuilder
COPY rx_and_build.sh /
COPY .bash_profile /home/toolsbuilder/
ENTRYPOINT ["/rx_and_build.sh"]
