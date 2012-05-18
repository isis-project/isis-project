#!/bin/bash

. ./common/envsetup.sh

. ./common/qmakesetup.sh

NAME=$1
PROCCOUNT=$2

cd $ISIS_ROOT/$NAME

export QMAKEPATH=$ISIS_ROOT/WebKit/Tools/qmake

mkdir -p WebKitBuild/isis-x86/Release
pushd WebKitBuild/isis-x86/Release

$QMAKE ../../../$NAME.pro -o Makefile.$NAME DEFINES+=XP_UNIX DEFINES+=XP_WEBOS DEFINES+=PALM_DEVICE DEFINES+=MACHINE_DESKTOP DEFINES+=QT_WEBOS DEFINES+=ENABLE_VIDEO=1 DEFINES+=WTF_USE_GSTREAMER=1 DEFINES+=ENABLE_GLIB_SUPPORT=1 CONFIG+=release

if [ "$?" != "0" ] ; then
   echo Failed to qmake $NAME
   exit 1
fi

make -f Makefile.$NAME -j$PROCCOUNT

if [ "$?" != "0" ] ; then
   echo Failed to make $NAME
   exit 1
fi

mkdir -p $LUNA_STAGING/imports
cp -p -R imports/QtWebKit $LUNA_STAGING/imports/
cp lib/libQtWebKit.so* $LUNA_STAGING/lib
cp -R include/QtWebKit $LUNA_STAGING/include
cd include/QtWebKit
for FILE in *.h ; do
   echo $FILE
   cp $ISIS_ROOT/$NAME/Source/WebKit/qt/Api/$FILE $LUNA_STAGING/include/QtWebKit/$FILE
done

popd
if [ ! -z "$PACKAGE" ]; then
    cd $ISIS_ROOT/$NAME
    dpkg-buildpackage -rfakeroot
    cd $STARTDIR
fi
