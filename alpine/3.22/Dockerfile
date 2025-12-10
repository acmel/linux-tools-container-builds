# tools/linux-tools-build-alpine:3.22
FROM alpine:3.22
MAINTAINER Arnaldo Carvalho de Melo <acme@kernel.org>
RUN apk add --no-cache \
	make gcc g++ flex bison curl cmake \
	clang clang-dev llvm llvm-dev \
	bc findutils file mandoc \
	libc-dev linux-headers musl-obstack-dev argp-standalone \
	elfutils-dev elfutils-libelf openssl-dev slang-dev \
	perl-dev python3-dev binutils-dev xz-dev libtraceevent-dev \
	numactl-dev libunwind-dev zstd-dev libcap-dev cmake asciidoc xmlto \
	libbpf-dev capstone-dev
RUN mkdir -m 777 -p /git /tmp/build/perf /tmp/build/objtool /tmp/build/linux && \
    adduser -D toolsbuilder && \
    chown -R toolsbuilder:toolsbuilder /tmp/build/ /git/
USER toolsbuilder
COPY rx_and_build.sh /
COPY .bash_profile /home/toolsbuilder/
ENTRYPOINT ["/rx_and_build.sh"]
