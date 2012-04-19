#!/bin/bash

. ./common/envsetup.sh

. ./common/qmakesetup.sh

build_target $ISIS_ROOT $1 $2

if [ ! -z "$PACKAGE" ]; then
    cd $ISIS_ROOT/$NAME
    dpkg-buildpackage -rfakeroot
    cd $STARTDIR
fi

