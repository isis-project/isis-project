#!/bin/sh

. ./common/envsetup.sh

. ./common/qmakesetup.sh

if [ ! -z "$PACKAGE" ]; then
    build_target $ISIS_ROOT $1 $2 $PACKAGE
else
    build_target $ISIS_ROOT $1 $2 
fi
