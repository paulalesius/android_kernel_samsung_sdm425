#!/bin/bash

TYPE=32

if [ "$TYPE" == "64" ]; then
	export TOOLCHAIN=$(pwd)/../toolchain/gcc/linux-x86/aarch64/aarch64-linux-android-4.8
	export CROSS_COMPILE=aarch64-linux-android-
	export ARCH=arm64
elif [ "$TYPE" == "32" ]; then
	export TOOLCHAIN=$(pwd)/../toolchain/gcc/linux-x86/arm/arm-linux-androideabi-4.8
	export CROSS_COMPILE=arm-linux-androideabi-
	export ARCH=arm
fi

export OUTDIR=$(pwd)/../target/kernel
export PATH=$TOOLCHAIN/bin:$PATH

export THREADS=$(nproc --all)
export COMMON_ARGS="-j$THREADS O=$OUTDIR arch=$ARCH CFLAGS_MODULE=-fno-pic arch=arm"
if [ "$1" == "build" ]; then
	make $COMMON_ARGS j4primelte_sea_open_defconfig
	make $COMMON_ARGS
elif [ "$1" == "rebuild" ]; then
	make $COMMON_ARGS
elif [ "$1" == "clean" ]; then
	make $COMMON_ARGS distclean
	make $COMMON_ARGS clean
else
	echo "./build_kernel.sh build|rebuild|clean"
fi
