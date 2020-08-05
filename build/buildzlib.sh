#!/bin/bash
COMPILE_ROOT=`pwd`


BUILD_PATH=${COMPILE_ROOT}/zlib
OUT_PATH=${COMPILE_ROOT}/zlibout
SRC_PATH=${COMPILE_ROOT}/../zlib-1.2.11


mkdir -p ${BUILD_PATH}
mkdir -p ${OUT_PATH}

pushd ${BUILD_PATH}


${SRC_PATH}/configure \
--static \
--prefix=${OUT_PATH}

make -j8 2>&1 |tee build.log
echo "-----------build success!-------------"

make install
echo "-----------install success!-------------"
popd

