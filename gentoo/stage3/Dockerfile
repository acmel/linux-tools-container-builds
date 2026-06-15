# tools/linux-tools-build-gentoo:stage3
FROM docker.io/gentoo/stage3
MAINTAINER Arnaldo Carvalho de Melo <acme@kernel.org>
RUN emerge --sync
#RUN emerge --oneshot portage
RUN emerge --oneshot sys-apps/portage
RUN emerge capstone
RUN emerge libcap
RUN emerge sys-libs/zlib
RUN emerge dev-libs/libbpf
RUN emerge app-arch/zstd
RUN emerge llvm-core/clang llvm compiler-rt llvm-libunwind lld
RUN emerge elfutils
RUN emerge numactl
RUN emerge slang
RUN emerge babeltrace
RUN emerge dev-libs/libtraceevent
RUN emerge xmlto
RUN emerge asciidoc
RUN emerge systemtap
RUN emerge dev-vcs/git
RUN emerge vim
RUN mkdir -m 777 -p /git /tmp/build/perf /tmp/build/objtool /tmp/build/linux && \
    groupadd -r toolsbuilder && \
    useradd -m -r -g toolsbuilder toolsbuilder && \
    chown -R toolsbuilder.toolsbuilder /tmp/build/ /git/
USER toolsbuilder
COPY rx_and_build.sh /
COPY .bash_profile /home/toolsbuilder/
ENV PATH $PATH:/usr/lib/llvm/16/bin/
# The stack protector flags are being applied to the BPF bytecode (BPF skels) build...
ENV EXTRA_MAKE_ARGS=WERROR=0
ENTRYPOINT ["/rx_and_build.sh"]
