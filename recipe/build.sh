#!/bin/bash
# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/libtool/build-aux/config.* ./tp/Texinfo/XS
cp $BUILD_PREFIX/share/libtool/build-aux/config.* ./build-aux

./configure --prefix=$PREFIX PERL='/usr/bin/env perl'

make
# OS X fails on `ii-0041-test` and `ii-0050-test` 2 out of 57.
if [[ $(uname) == Linux ]]; then
  make check
fi
make install
