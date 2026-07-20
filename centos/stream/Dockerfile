# tools/linux-tools-build-centos:stream
FROM centos:stream10
MAINTAINER Arnaldo Carvalho de Melo <acme@kernel.org>
RUN dnf -y config-manager --set-enabled crb
RUN dnf -y makecache
RUN dnf -y update
RUN dnf -y install make gcc gcc-c++ flex bison bc git openssl clang llvm xz
RUN dnf -y install clang-devel llvm-devel cmake \
		   elfutils-libelf-devel elfutils-devel \
		   audit-libs-devel openssl-devel slang-devel \
		   perl-ExtUtils-Embed binutils-devel \
		   libtraceevent-devel bpftool dwz \
		   elfutils-debuginfod-client \
		   systemtap-sdt-devel xz-devel numactl-devel \
		   libcap-devel asciidoc xmlto \
		   libbpf-devel
RUN dnf -y install python3-devel
RUN dnf -y install diffutils
RUN dnf -y install java-21-openjdk-devel
#RUN dnf -y gtk2-devel
RUN dnf -y clean all && \
    mkdir -m 777 -p /git /tmp/build/perf /tmp/build/objtool /tmp/build/linux && \
    groupadd -r toolsbuilder && \
    useradd -m -r -g toolsbuilder toolsbuilder && \
    chown -R toolsbuilder.toolsbuilder /tmp/build/ /git/
USER toolsbuilder
COPY rx_and_build.sh /
COPY .bash_profile /home/toolsbuilder/
ENV DEBUGINFOD_URLS="https://debuginfod.centos.org/"
ENTRYPOINT ["/rx_and_build.sh"]
