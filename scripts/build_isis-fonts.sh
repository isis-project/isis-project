#!/bin/bash

. ./common/envsetup.sh

mkdir -p $LUNA_STAGING/lib/fonts

cd $ISIS_ROOT/$1
cp -pv -t $LUNA_STAGING/lib/fonts \
Roboto-Regular.ttf \
Roboto-Bold.ttf \
Roboto-Italic.ttf \
Roboto-BoldItalic.ttf \
DroidSerif-Regular.ttf \
DroidSerif-Bold.ttf \
DroidSerif-Italic.ttf \
DroidSerif-BoldItalic.ttf \
DroidSans.ttf \
DroidSans-Bold.ttf \
DroidSansMono.ttf \
DroidNaskh-Regular.ttf \
DroidSansEthiopic-Regular.ttf \
DroidSansHebrew-Regular.ttf \
DroidSansHebrew-Bold.ttf \
DroidSansThai.ttf \
DroidSansArmenian.ttf \
DroidSansGeorgian.ttf \
DroidSansJapanese.ttf \
NanumGothic.ttf \
NanumMyeongjo.ttf \
DroidSansFallback.ttf \
system_fonts.xml \
fallback_fonts.xml


