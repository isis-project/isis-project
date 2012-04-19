#!/bin/sh

. ./common/envsetup.sh
. ./common/makesetup.sh

if [ ! -z "$PACKAGE" ]; then
    cd $ISIS_ROOT/$1
    ls
    dpkg-buildpackage -rfakeroot
    cd $STARTDIR
fi

