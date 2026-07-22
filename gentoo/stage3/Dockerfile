# tools/linux-tools-build-gentoo:stage3
FROM docker.io/gentoo/stage3
MAINTAINER Arnaldo Carvalho de Melo <acme@kernel.org>
RUN emerge --sync && \
    emerge --oneshot sys-apps/portage && \
    emerge \
      dev-libs/capstone \
      sys-libs/libcap \
      sys-libs/zlib \
      dev-libs/libbpf \
      app-arch/zstd \
      llvm-core/clang \
      llvm-core/llvm \
      llvm-runtimes/compiler-rt \
      llvm-runtimes/libunwind \
      llvm-core/lld \
      dev-libs/elfutils \
      sys-process/numactl \
      sys-libs/slang \
      dev-util/babeltrace \
      dev-libs/libtraceevent \
      app-text/xmlto \
      app-text/asciidoc \
      dev-debug/systemtap \
      dev-util/bpftool \
      sys-devel/dwz \
      dev-vcs/git \
      app-editors/vim
RUN mkdir -m 777 -p /git /tmp/build/perf /tmp/build/objtool /tmp/build/linux && \
    groupadd -r toolsbuilder && \
    useradd -m -r -g toolsbuilder toolsbuilder && \
    chown -R toolsbuilder:toolsbuilder /tmp/build/ /git/
USER toolsbuilder
COPY rx_and_build.sh /
COPY .bash_profile /home/toolsbuilder/
ENV PATH $PATH:/usr/lib/llvm/16/bin/
# The stack protector flags are being applied to the BPF bytecode (BPF skels) build...
ENV EXTRA_MAKE_ARGS=WERROR=0
ENTRYPOINT ["/rx_and_build.sh"]
