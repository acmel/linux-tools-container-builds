# tools/linux-tools-build-archlinux:base
FROM docker.io/library/archlinux:base
MAINTAINER Arnaldo Carvalho de Melo <acme@kernel.org>
RUN pacman-key --init
RUN pacman -Sy archlinux-keyring --noconfirm
RUN pacman -Syu --noconfirm sed grep diffutils awk
RUN pacman -Syu --noconfirm jdk8-openjdk clang llvm zstd gtk2 libcap python
RUN pacman -Syu --noconfirm make gcc flex bison libelf openssl slang libunwind audit numactl gettext cmake xmlto asciidoc
RUN pacman -Syu --noconfirm vim git ctags python-setuptools libtraceevent openssh wget pkg-config libbpf capstone
RUN mkdir -m 777 -p /git /tmp/build/perf /tmp/build/objtool /tmp/build/linux && \
    useradd -m toolsbuilder
USER toolsbuilder
COPY rx_and_build.sh /
COPY .bash_profile /home/toolsbuilder/
ENV PERL_EMBED_CCFLAGS="-Wno-thread-safety-analysis $(perl -MExtUtils::Embed -e ccopts)"
ENTRYPOINT ["/rx_and_build.sh"]
