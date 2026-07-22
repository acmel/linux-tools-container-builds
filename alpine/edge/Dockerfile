# tools/linux-tools-build-alpine:edge
FROM alpine:edge
MAINTAINER Arnaldo Carvalho de Melo <acme@kernel.org>
RUN apk add --no-cache \
	make gcc g++ flex bison curl \
	bc findutils libcap-dev git \
	mandoc clang clang-dev llvm llvm-dev \
	libc-dev linux-headers libdwarf-dev musl-obstack-dev \
	argp-standalone debuginfod \
	elfutils-dev openssl-dev slang-dev libtraceevent-dev \
	gtk+3.0-dev perl-dev python3-dev py3-setuptools binutils-dev xz-dev \
	numactl-dev libunwind-dev zstd-dev libcap-dev openjdk8 xmlto asciidoc cmake asciidoc xmlto \
	libbpf-dev capstone-dev bpftool gawk
RUN apk add --no-cache argp-standalone musl-dev xxhash-dev musl-obstack-dev && \
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
    chown -R toolsbuilder /tmp/build/ /git/
USER toolsbuilder
COPY rx_and_build.sh /
ENV DEBUGINFOD_URLS=https://debuginfod.achill.org/
ENTRYPOINT ["/rx_and_build.sh"]
