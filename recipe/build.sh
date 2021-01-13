#!/bin/bash
# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* ./build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./tp/Texinfo/XS

./configure --prefix=$PREFIX PERL='/usr/bin/env perl'

make
# OS X fails on `ii-0041-test` and `ii-0050-test` 2 out of 57.
if [[ $(uname) == Linux ]]; then
if [[ "${CONDA_BUILD_CROSS_COMPILATION}" != "1" ]]; then
  make check
fi
fi
make install
