#!/bin/sh

. ./common/envsetup.sh

NAME=$1
PROCCOUNT=$2

export MY_YAJL_INCLUDE_PATH=$ISIS_ROOT/pbnjson/src/deps/yajl/yajl-1.0.7/include
export MY_YAJL_LIB_PATH=$ISIS_ROOT/pbnjson/src/deps/yajl/yajl-1.0.7/lib

cd $ISIS_ROOT/$NAME/src/deps/yajl
cmake . -DCMAKE_INSTALL_PREFIX=$LUNA_STAGING
make -j$PROCCOUNT
make install

cd $ISIS_ROOT/$NAME/src
cmake . -DCMAKE_INSTALL_PREFIX=$LUNA_STAGING
make -j$PROCCOUNT
make install

cd $STARTDIR
