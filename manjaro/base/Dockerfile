# tools/linux-tools-build-manjaro:base
FROM docker.io/manjarolinux/base
MAINTAINER Arnaldo Carvalho de Melo <acme@kernel.org>
RUN pacman -Syu --noconfirm \
      make gcc flex bison libelf openssl slang libunwind audit numactl \
      gettext cmake xmlto asciidoc \
      sed grep diffutils gawk jdk8-openjdk clang llvm zstd libcap \
      libtraceevent pkgconf libbpf capstone elfutils bpf git xxhash && \
    git clone https://sourceware.org/git/dwz.git /tmp/dwz && \
    cd /tmp/dwz && make && make install && rm -rf /tmp/dwz
RUN mkdir -m 777 -p /git /tmp/build/perf /tmp/build/objtool /tmp/build/linux && \
    groupadd -r toolsbuilder && \
    useradd -m -r -g toolsbuilder toolsbuilder && \
    chown -R toolsbuilder:toolsbuilder /tmp/build/ /git/

USER toolsbuilder
COPY rx_and_build.sh /
COPY .bash_profile /home/toolsbuilder/
ENTRYPOINT ["/rx_and_build.sh"]
