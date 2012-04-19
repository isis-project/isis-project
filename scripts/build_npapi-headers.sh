#!/bin/bash

. ./common/envsetup.sh

. ./common/makesetup.sh

if [ ! -z "$PACKAGE" ]; then
    build_target $ISIS_ROOT $1 $2 Ubuntu stage $PACKAGE
else
     build_target $ISIS_ROOT $1 $2 Ubuntu stage
fi

