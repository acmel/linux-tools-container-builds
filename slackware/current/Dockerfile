# tools/linux-tools-build-slackware:current
FROM docker.io/aclemons/slackware
MAINTAINER Arnaldo Carvalho de Melo <acme@kernel.org>
RUN yes | slackpkg install --batch \
	make guile gc gcc kernel-headers pkg-config \
	flex bison elfutils python3 m4 slang zstd llvm \
	zlib libxml2 libedit python-setuptools llvm \
	libunwind debuginfod
RUN mkdir -m 777 -p /git /tmp/build/perf /tmp/build/objtool /tmp/build/linux && \
    groupadd -r toolsbuilder && \
    useradd -m -r -g toolsbuilder toolsbuilder && \
    chown -R toolsbuilder.toolsbuilder /tmp/build/ /git/
USER toolsbuilder
COPY rx_and_build.sh /
COPY .bash_profile /home/toolsbuilder/
# No libtraceevent in slackware, at least on the aclemons image...
# The openssl problem:
# sign.c:40:21: warning: implicit declaration of function 'ERR_get_error_all'; did you mean 'ERR_get_error_line'? [-Wimplicit-function-declaration]
ENV EXTRA_MAKE_ARGS=NO_LIBTRACEEVENT=1 NO_LIBELF=1
ENTRYPOINT ["/rx_and_build.sh"]
