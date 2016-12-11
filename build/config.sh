#!/bin/bash
current_dir=`pwd`
build_dir=$current_dir/build_dir
if ! [ -e  $build_dir ];then
    mkdir -p $build_dir
fi
source_dir=`readlink -f "$current_dir/../source"`
root_dir=`readlink -f "$current_dir/../"`
external_libs_dir=`readlink -f "$root_dir/../../Documents/transcoder_dev/external_libs"`
echo $external_libs_dir

export FREETYPE_CFLAGS="-I$external_libs_dir/freetype2-linux/include"
export FREETYPE_LIBS="-L$external_libs_dir/freetype2-linux/lib -lfreetype"
export EXPAT_CFLAGS="-I$external_libs_dir/expat-linux/include"
export EXPAT_LIBS="-L$$external_libs_dir/expat-linux/lib -lexpat"

cd $build_dir
$source_dir/configure \
    --prefix=$build_dir \
    --disable-shared \
    --enable-static \
    --disable-docs  \
    --with-expat="$external_libs_dir/expat-linux"

make && make install
cd -
