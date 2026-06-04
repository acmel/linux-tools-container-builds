# tools/linux-tools-build-opensuse:15.4
FROM opensuse/leap:15.4
MAINTAINER Arnaldo Carvalho de Melo <acme@kernel.org>
# Don't include capstone, it uses enum for the arches and new code uses things we don't have in this distro
RUN zypper -n update && \
    zypper -n install make gcc gcc-c++ flex bison curl tar xz libelf-devel libdw-devel \
		      clang clang-devel llvm llvm-devel cpio \
		      libunwind-devel openssl-devel \
		      slang-devel gtk2-devel perl python3-devel python3-setuptools \
		      systemtap-sdt-devel libzstd-devel libcap-devel \
		      binutils-devel xz-devel libnuma-devel OpenCSD-devel \
		      cmake xmlto asciidoc libbpf-devel vim git && \
    zypper clean --all && \
    mkdir -m 777 -p /git /tmp/build/perf /tmp/build/objtool /tmp/build/linux && \
    groupadd -r toolsbuilder && \
    useradd -m -r -g toolsbuilder toolsbuilder && \
    chown -R toolsbuilder.toolsbuilder /tmp/build/ /git/
USER toolsbuilder
COPY rx_and_build.sh /
COPY .bash_profile /home/toolsbuilder/
ENV EXTRA_MAKE_ARGS=NO_LIBTRACEEVENT=1
ENTRYPOINT ["/rx_and_build.sh"]
