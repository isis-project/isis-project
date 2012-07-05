#!/bin/bash

export QTDIR=$ISIS_ROOT/qt
QMAKE=$LUNA_STAGING/bin/qmake

qt_download()
{
   local QT_HTTP="http://releases.qt-project.org/qt4/source"
   local QT_SRC="qt-everywhere-opensource-src-4.8.2"
   local QT_TGZ="$QT_SRC.tar.gz"

   echo downloading Qt from: $QT_HTTP/$QT_TGZ
   curl -C - $QT_HTTP/$QT_TGZ -o $ISIS_ROOT/$QT_TGZ
   [ "$?" == "0" ] || fail "Failed to download: $QT_TGZ"

   echo Extracting $QT_TGZ
   tar xzf $ISIS_ROOT/$QT_TGZ -C $ISIS_ROOT
   [ "$?" == "0" ] || fail "Failed to untar: $QT_TGZ"

   mv $ISIS_ROOT/$QT_SRC $ISIS_ROOT/qt
   [ "$?" == "0" ] || fail "Failed to rename: $QT_SRC to qt"
}

get_qt()
{
   if [ ! -d $ISIS_ROOT/qt ] ; then
      qt_download
   else
      echo found $ISIS_ROOT/qt
   fi
}
