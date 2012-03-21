#!/bin/sh

build_target()
{

ROOT=$1
NAME=$2
PROCCOUNT=$3
MAKENAME=$4
MAKEINSTALL=$5

if [ -n "$MAKENAME" ] ; then
   MAKENAME=.$MAKENAME
fi

if [ -z "$MAKEINSTALL" ] ; then
   MAKEINSTALL=install
fi

cd $ROOT/$NAME

make -f Makefile$MAKENAME -j$PROCCOUNT

if [ "$?" != "0" ] ; then
   echo Failed to make $NAME
   exit 1
fi

make -f Makefile$MAKENAME $MAKEINSTALL

if [ "$?" != "0" ] ; then
   echo Failed to install $NAME
   exit 1
fi

}
