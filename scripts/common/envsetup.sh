#!/bin/bash

STARTDIR=$PWD

while [ "$PWD" != "/" -a "$ISIS_ROOT" = "" ] ; do
   if [ -d ./isis-project ] ; then
      ISIS_ROOT=$PWD
   else
      cd ..
   fi
done

echo $ISIS_ROOT

export LUNA_STAGING=$ISIS_ROOT/staging

. $ISIS_ROOT/isis-project/scripts/common/qtsetup.sh

cd $STARTDIR

fail()
{
   cd $STARTDIR
   echo $1
   exit 1
}
