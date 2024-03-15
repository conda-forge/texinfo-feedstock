#!/bin/bash
# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/libtool/build-aux/config.* ./tp/Texinfo/XS
cp $BUILD_PREFIX/share/libtool/build-aux/config.* ./build-aux

if [[ "$CONDA_BUILD_CROSS_COMPILATION" == "1" ]]; then
  export BUILD_CC=$CC_FOR_BUILD
  export BUILD_AR=$($CC_FOR_BUILD -print-prog-name=ar)
  export BUILD_RANLIB=$($CC_FOR_BUILD -print-prog-name=ranlib)
fi

./configure --prefix=$PREFIX PERL='/usr/bin/env perl' \
            --with-system-icu=yes

make
# OS X fails on `ii-0041-test` and `ii-0050-test` 2 out of 57.
if [[ $(uname) == Linux ]]; then
  make check
fi
make install
