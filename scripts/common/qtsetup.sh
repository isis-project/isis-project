#!/bin/sh

export QTDIR=$ISIS_ROOT/qt
QMAKE=$LUNA_STAGING/bin/qmake

#if [ -z "$QTDIR" ] ; then
#   BUILD_QT=true
#fi

#build_qt()
#{
#   [ -z "${BUILD_QT}" ] && return 1 || return 0
#}

qt_clone()
{
   git clone -b 4.8 https://git.gitorious.org/qt/qt.git $ISIS_ROOT/qt
#   [ "$?" == "0" ] || echo "Failed to checkout: qt"
}

qt_download()
{
   local QT_FTP="ftp://ftp.qt.nokia.com/qt/source"
   local QT_SRC="qt-everywhere-opensource-src-4.8.1"
   local QT_TGZ="$QT_SRC.tar.gz"

   echo downloading Qt from: $QT_FTP/$QT_TGZ
   curl -C - $QT_FTP/$QT_TGZ -o $ISIS_ROOT/$QT_TGZ
   [ "$?" == "0" ] || fail "Failed to download: $QT_TGZ"

   tar xzvf $ISIS_ROOT/$QT_TGZ -C $ISIS_ROOT
   [ "$?" == "0" ] || fail "Failed to untar: $QT_TGZ"

   mv $ISIS_ROOT/$QT_SRC $ISIS_ROOT/qt
   [ "$?" == "0" ] || fail "Failed to rename: $QT_SRC to qt"
}

get_qt()
{
   if [ ! -d $ISIS_ROOT/qt ] ; then
#      qt_clone
#      [ "$?" == "0" ] || qt_download
      qt_download
   else
      echo found $ISIS_ROOT/qt
   fi
}
