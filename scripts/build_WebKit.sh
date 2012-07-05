#!/bin/bash

. ./common/envsetup.sh

. ./common/qmakesetup.sh

NAME=$1
PROCCOUNT=$2

cd $ISIS_ROOT/$NAME

export QMAKEPATH=$ISIS_ROOT/WebKit/Tools/qmake
export WEBKITOUTPUTDIR="WebKitBuild/isis-x86"

./Tools/Scripts/build-webkit --qt \
--release \
--video \
--no-webgl \
--no-webkit2 \
--qmake="${QMAKE}" \
--makeargs="-j$PROCOUNT" \
--qmakearg="DEFINES+=XP_UNIX" \
--qmakearg="DEFINES+=XP_WEBOS" \
--qmakearg="DEFINES+=PALM_DEVICE" \
--qmakearg="DEFINES+=MACHINE_DESKTOP" \
--qmakearg="DEFINES+=QT_WEBOS" \
--qmakearg="DEFINES+=WTF_USE_ZLIB=1" \
--qmakearg="DEFINES+=WTF_USE_GSTREAMER=1" \
--qmakearg="DEFINES+=ENABLE_GLIB_SUPPORT=1"

if [ "$?" != "0" ] ; then
   echo Failed to make $NAME
   exit 1
fi

pushd $WEBKITOUTPUTDIR/Release
make install
if [ "$?" != "0" ] ; then
   echo Failed to install $NAME
   exit 1
fi
popd
