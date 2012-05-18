#!/bin/bash

. ./common/envsetup.sh

cd $ISIS_ROOT/$1/$1

NAME=webbrowser
PROCCOUNT=$2

MAKEFILE=Makefile.$NAME

$QMAKE "DEFINES+=ISIS_DESKTOP" $NAME.pro -o Makefile.$NAME

if [ "$?" != "0" ] ; then
   echo Failed to qmake $NAME
   exit 1
fi

make -f Makefile.$NAME -j$PROCCOUNT

if [ "$?" != "0" ] ; then
   echo Failed to make $NAME
   exit 1
fi

make -f Makefile.$NAME install

if [ "$?" != "0" ] ; then
   echo Failed to install $NAME
   exit 1
fi


