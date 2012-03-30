#!/bin/sh

. ./common/envsetup.sh

NAME=$1
PROCCOUNT=$2

cd $ISIS_ROOT/$NAME

if [ ! -s ".qmake.cache" ] ; then
   echo Configuring Qt
   ./configure --prefix=$LUNA_STAGING -qpa -opensource -no-cups -no-nis -no-exceptions -no-accessibility -no-qt3support -no-xmlpatterns -no-multimedia -no-phonon -no-phonon-backend -no-webkit -confirm-license -make 'libs tools' -opengl desktop
fi

if [ ! -s "lib/libQtCore.so" ] ; then
   echo Building Qt
   make --jobs=$PROCCOUNT
   if [ "$?" != "0" ] ; then
      echo Failed to make $NAME
      exit 1
   fi
fi

if [ ! -s "$LUNA_STAGING/lib/libQtCore.so" ] ; then
   echo Installing Qt
   make install
   if [ "$?" != "0" ] ; then
      echo Failed to install $NAME
      exit 1
   fi
fi

if [ ! -s "$LUNA_STAGING/plugins/plaftorms/libqxlib.so" ] ; then
   cd src/plugins/platforms/xlib
   make
   if [ "$?" != "0" ] ; then
      echo Failed to make qt libqxlib.so
      exit 1
   fi
   cd $ISIS_ROOT/$NAME
   cp plugins/platforms/libqxlib.so $LUNA_STAGING/plugins/platforms/
fi
