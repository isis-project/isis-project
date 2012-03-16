#!/bin/sh

. ./common/envsetup.sh

. ./common/qmakesetup.sh

NAME=$1
PROCCOUNT=$2

cd $ISIS_ROOT/$NAME

export QMAKEPATH=$ISIS_ROOT/WebKit/Tools/qmake

#qmake $NAME.pro -o Makefile.$NAME "DEFINES+=XP_UNIX" "DEFINES+=XP_WEBOS" "DEFINES+=PALM_DEVICE" "DEFINES+=MACHINE_DESKTOP" "DEFINES+=QT_WEBOS" "DEFINES+=ENABLE_VIDEO=0" "CONFIG+=no_webkit2"
qmake $NAME.pro -o Makefile.$NAME DEFINES+=XP_UNIX DEFINES+=XP_WEBOS DEFINES+=PALM_DEVICE DEFINES+=MACHINE_DESKTOP DEFINES+=QT_WEBOS DEFINES+=ENABLE_VIDEO=0 CONFIG+=release

if [ "$?" != "0" ] ; then
   echo Failed to qmake $NAME
   exit 1
fi

make -f Makefile.$NAME -j$PROCCOUNT

if [ "$?" != "0" ] ; then
   echo Failed to make $NAME
   exit 1
fi


