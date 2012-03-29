#!/bin/sh

. ./common/envsetup.sh

. ./common/makesetup.sh

export STAGING_DIR=$LUNA_STAGING
export QT_INSTALL_PREFIX=`$QMAKE -query QT_INSTALL_PREFIX`

build_target $ISIS_ROOT $1 $2 Ubuntu stage
