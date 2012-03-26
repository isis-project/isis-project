#!/bin/sh

. ./common/envsetup.sh

. ./common/makesetup.sh

export STAGING_DIR=$LUNA_STAGING
export QT_INSTALL_PREFIX=`$QMAKE -query QT_INSTALL_PREFIX`
export STAGING_BINDIR_NATIVE=$QT_INSTALL_PREFIX/bin

build_target $ISIS_ROOT $1 $2 Ubuntu stage
