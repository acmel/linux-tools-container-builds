# tools/linux-tools-build-oraclelinux:9
FROM oraclelinux:9
MAINTAINER Arnaldo Carvalho de Melo <acme@kernel.org>
RUN dnf -y update
RUN dnf install yum-utils
RUN dnf config-manager --set-enabled ol9_codeready_builder
RUN dnf -y install make gcc gcc-c++ flex bison \
		   clang clang-devel llvm llvm-devel \
		   bc tar xz elfutils-libelf-devel elfutils-devel \
		   audit-libs-devel openssl-devel slang-devel libzstd-devel  \
		   gtk2-devel perl-ExtUtils-Embed python3-devel python3-setuptools binutils-devel \
		   systemtap-sdt-devel xz-devel numactl-devel libcap-devel \
		   java-1.8.0-openjdk-devel cmake xmlto asciidoc libtraceevent-devel libbpf-devel \
		   capstone-devel
RUN dnf -y clean all && \
    mkdir -m 777 -p /git /tmp/build/perf /tmp/build/objtool /tmp/build/linux && \
    groupadd -r toolsbuilder && \
    useradd -m -r -g toolsbuilder toolsbuilder && \
    chown -R toolsbuilder:toolsbuilder /tmp/build/ /git/
USER toolsbuilder
COPY rx_and_build.sh /
COPY .bash_profile /home/toolsbuilder/
ENTRYPOINT ["/rx_and_build.sh"]
