#!/bin/sh

. ./common/envsetup.sh

. ./common/qmakesetup.sh

export STAGING_DIR=$LUNA_STAGING
export STAGING_INCDIR=$LUNA_STAGING/include
export STAGING_LIBDIR=$LUNA_STAGING/lib

build_target $ISIS_ROOT $1 $2 $PACKAGE

if [ ! -z "$PACKAGE" ]; then
    cd $ISIS_ROOT/$NAME
    dpkg-buildpackage -rfakeroot
    cd $STARDIR
fi

