# tools/linux-tools-build-ubuntu:20.04
FROM docker.io/library/ubuntu:20.04
MAINTAINER Arnaldo Carvalho de Melo <acme@kernel.org>
ENV DEBIAN_FRONTEND noninteractive
# Don't include capstone, it uses enum for the arches and new code uses things we don't have in this distro
RUN apt-get -y update && \
    apt-get -y install \
	make gcc g++ flex bison curl file man \
	bc findutils clang llvm \
	libcap-dev \
	libunwind8-dev libssl-dev libslang2-dev python3-dev python3-setuptools \
	systemtap-sdt-dev libgtk2.0-dev liblzma-dev binutils-dev \
	libelf-dev libiberty-dev libdw-dev libaudit-dev \
	libperl-dev libnuma-dev libzstd-dev \
	cmake xmlto asciidoc && \
    apt-get -y clean && \
    mkdir -m 777 -p /git /tmp/build/perf /tmp/build/objtool /tmp/build/linux && \
    groupadd -r toolsbuilder && \
    useradd -m -r -g toolsbuilder toolsbuilder && \
    chown -R toolsbuilder.toolsbuilder /tmp/build/ /git/
USER toolsbuilder
COPY rx_and_build.sh /
COPY .bash_profile /home/toolsbuilder/
ENV NO_BUILD_BPF_SKEL=1
# /usr/bin/ld: /usr/lib/llvm-10/lib/libclangCodeGen.a(BackendUtil.cpp.o): in function `(anonymous namespace)::EmitAssemblyHelper::EmitAssemblyWithNewPassManager(clang::BackendAction, std::unique_ptr<llvm::raw_pwrite_stream, std::default_delete<llvm::raw_pwrite_stream> >)':
# (.text._ZN12_GLOBAL__N_118EmitAssemblyHelper30EmitAssemblyWithNewPassManagerEN5clang13BackendActionESt10unique_ptrIN4llvm17raw_pwrite_streamESt14default_deleteIS5_EE+0x1f15): undefined reference to `getPollyPluginInfo()'
# clang: error: linker command failed with exit code 1 (use -v to see invocation)
# make[2]: *** [Makefile.perf:666: /tmp/build/perf/perf] Error 1
ENV NO_CLANG=1
ENV EXTRA_MAKE_ARGS=NO_LIBTRACEEVENT=1
ENTRYPOINT ["/rx_and_build.sh"]
