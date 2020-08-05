#!/bin/bash
COMPILE_ROOT=`pwd`


BUILD_PATH=${COMPILE_ROOT}/python
OUT_PATH=${COMPILE_ROOT}/pythonout

OPENSSL_PATH=${COMPILE_ROOT}/libresslout
OPENSSL_LIB_PATH=${COMPILE_ROOT}/libresslout/lib

LIBCRYPT_PATH=${COMPILE_ROOT}/libcryptout/include
LIBCRYPT_LIB_PATH=${COMPILE_ROOT}/libcryptout


LIBZ_PATH=${COMPILE_ROOT}/zlibout/include
LIBZ_LIB_PATH=${COMPILE_ROOT}/zlibout/lib

CROSS_COMPILER=arm-linux-androideabi-
CROSS_COMPILER_CLANG=armv7a-linux-androideabi26-

#prepare
mkdir -p ${BUILD_PATH}
mkdir -p ${OUT_PATH}


cd ${BUILD_PATH}

echo -e "ac_cv_file__dev_ptmx=yes\nac_cv_file__dev_ptc=no" > config.site

${COMPILE_ROOT}/../Python-3.8.3/configure --host=arm-linux-androideabi \
--build=x86_64-pc-linux-gnu \
--target=armv7a-linux-android \
LDFLAGS="-Wl,--allow-shlib-undefined -D__ANDROID_API__=26 -L${LIBCRYPT_LIB_PATH} -L${LIBCRYPT_PATH}"  \
CFLAGS="-D__ANDROID_API__=26 -I${LIBCRYPT_PATH} -I${LIBZ_PATH} -fPIC" \
CPPFLAGS="-D__ANDROID_API__=26 -I${LIBCRYPT_PATH} -I${LIBZ_PATH} -fPIC" \
--enable-shared \
--with-openssl=${OPENSSL_PATH} \
--enable-ipv6 \
--prefix=${OUT_PATH}

make -j4 2>&1 |tee build.log
echo "-----------build success!-------------"

make install
echo "-----------install success!-------------"

