
alias m='make $EXTRA_MAKE_ARGS ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE EXTRA_CFLAGS="$EXTRA_CFLAGS" -C tools/perf O=/tmp/build/perf'
alias mclang='m CC=clang'
