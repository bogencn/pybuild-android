#!/bin/bash
COMPILE_ROOT=`pwd`


BUILD_PATH=${COMPILE_ROOT}/libressl
OUT_PATH=${COMPILE_ROOT}/libresslout
SRC_PATH=${COMPILE_ROOT}/../libressl-3.0.2

mkdir -p ${BUILD_PATH}
mkdir -p ${OUT_PATH}
export CPPFLAGS="-D__ANDROID_API__=26 -I${LIBCRYPT_PATH} -I${LIBZ_PATH} -fPIC"
pushd ${BUILD_PATH}


${SRC_PATH}/configure \
--host=arm-linux-androideabi \
--build=x86_64-pc-linux-gnu \
--enable-shared=no \
--prefix=${OUT_PATH}

make -j4 2>&1 |tee build.log
echo "-----------build success!-------------"

make install
echo "-----------install success!-------------"
popd

