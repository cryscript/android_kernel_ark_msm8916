#!/bin/bash
cd ..
rm -rf modules
export CONFIG_FILE="peach_defconfig"
export ARCH="arm"
export CROSS_COMPILE="arm-eabi-"
export TOOL_CHAIN_PATH="/media/fedor917/Fedor917/android/AEX/prebuilts/gcc/linux-x86/arm/arm-eabi-4.8/bin/"
export CONFIG_ABS_PATH="arch/${ARCH}/configs/${CONFIG_FILE}"
export PATH=$PATH:${TOOL_CHAIN_PATH}
export objdir="/media/fedor917/Fedor917/android/build/kernel/obj"
export sourcedir="/media/fedor917/Fedor917/android/RR-N/kernel/ark/msm8916"
cd $sourcedir
compile() {
  make O=$objdir ARCH=arm CROSS_COMPILE=${TOOL_CHAIN_PATH}/${CROSS_COMPILE}  $CONFIG_FILE -j4 
  make O=$objdir -j6
}
module(){
  mkdir modules
  find . -name '*.ko' -exec cp -av {} modules/ \;
  # strip modules 
  ${TOOL_CHAIN_PATH}/${CROSS_COMPILE}strip --strip-unneeded modules/*
  #mkdir modules/qca_cld
  #mv modules/wlan.ko modules/qca_cld/qca_cld_wlan.ko
}
dtbuild(){
  cd $sourcedir
  ./tools/dtbToolCM -2 -o $objdir/arch/arm64/boot/dt.img -s 4096 -p $objdir/scripts/dtc/ $objdir/arch/arm64/boot/dts/
}
compile 
#cd ../
#module
dtbuild
