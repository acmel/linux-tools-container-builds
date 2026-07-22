# tools/linux-tools-build-alpine:3.22
FROM alpine:3.22
MAINTAINER Arnaldo Carvalho de Melo <acme@kernel.org>
RUN apk add --no-cache \
	make gcc g++ flex bison curl cmake \
	clang clang-dev llvm llvm-dev git \
	bc findutils file mandoc gawk xxhash xxhash-dev \
	libc-dev linux-headers musl-obstack-dev argp-standalone \
	elfutils-dev elfutils-libelf openssl-dev slang-dev \
	perl-dev python3-dev binutils-dev xz-dev libtraceevent-dev \
	numactl-dev libunwind-dev zstd-dev libcap-dev cmake asciidoc xmlto \
	libbpf-dev capstone-dev bpftool
RUN apk add --no-cache argp-standalone musl-dev musl-obstack-dev && \
    mkdir -p /usr/local/include/compat && \
    cat > /usr/local/include/compat/error.h << 'EOF'
#ifndef COMPAT_ERROR_H
#define COMPAT_ERROR_H
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>

static inline void error(int status, int errnum, const char *format, ...)
{
    va_list ap;
    fflush(stdout);
    va_start(ap, format);
    vfprintf(stderr, format, ap);
    va_end(ap);
    if (errnum)
        fprintf(stderr, ": %s", strerror(errnum));
    fprintf(stderr, "\n");
    if (status)
        exit(status);
}
#endif
EOF
RUN git clone https://sourceware.org/git/dwz.git /tmp/dwz && \
    cd /tmp/dwz && \
    make CFLAGS="-O2 -g -I/usr/local/include/compat" LIBS="-lelf -lobstack" && \
    make install && \
    rm -rf /tmp/dwz /usr/local/include/compat
RUN mkdir -m 777 -p /git /tmp/build/perf /tmp/build/objtool /tmp/build/linux && \
    adduser -D toolsbuilder && \
    chown -R toolsbuilder:toolsbuilder /tmp/build/ /git/
USER toolsbuilder
COPY rx_and_build.sh /
COPY .bash_profile /home/toolsbuilder/
ENTRYPOINT ["/rx_and_build.sh"]
