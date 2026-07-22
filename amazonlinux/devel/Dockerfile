# tools/linux-tools-build-amazonlinux:devel
FROM docker.io/library/amazonlinux:devel
MAINTAINER Arnaldo Carvalho de Melo <acme@kernel.org>
RUN dnf -y --enablerepo="amazonlinux-debuginfo" install perf-debuginfo
RUN yum -y install make gcc g++ flex bison \
		   clang-devel llvm llvm-devel \
		   elfutils-debuginfod-client \
		   bc git openssl \
		   xz tar diffutils \
		   elfutils-libelf-devel elfutils-devel \
		   libunwind-devel audit-libs-devel openssl-devel \
		   slang-devel dwz bpftool \
		   perl-ExtUtils-Embed python-devel \
		   python-setuptools binutils-devel \
		   systemtap-sdt-devel xz-devel numactl-devel \
		   libzstd-devel libcap-devel cmake xmlto asciidoc libbpf-devel && \
# Don't include capstone, it uses enum for the arches and new code uses things we don't have in this distro
    yum -y clean all && \
    mkdir -m 777 -p /git /tmp/build/perf /tmp/build/objtool /tmp/build/linux && \
    groupadd -r toolsbuilder && \
    useradd -m -r -g toolsbuilder toolsbuilder && \
    chown -R toolsbuilder.toolsbuilder /tmp/build/ /git/
USER toolsbuilder
COPY rx_and_build.sh /
COPY .bash_profile /home/toolsbuilder/
ENV EXTRA_MAKE_ARGS=NO_LIBTRACEEVENT=1
ENTRYPOINT ["/rx_and_build.sh"]
