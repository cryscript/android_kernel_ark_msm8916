KERNEL_DIR=$PWD
export ARCH=arm
export SUBARCH=arm

export KBUILD_BUILD_USER="Fedor917"
export KBUILD_BUILD_HOST="Zanovo"

export CROSS_COMPILE=/media/fedor917/Fedor917/android/AEX/prebuilts/gcc/linux-x86/arm/arm-eabi-4.8/bin/arm-eabi-
#export STRIP=STRIP=/home/fedor917/android/aarch64-linux-android-4.9/bin/aarch64-linux-android-strip
MODULES_DIR=$KERNEL_DIR/out_modules

make peach_defconfig
#make oldconfig
make menuconfig
#make -j8
make mrproper

