#!/bin/sh

. ./common/envsetup.sh

. ./common/qmakesetup.sh

build_target $ISIS_ROOT $1 $2
