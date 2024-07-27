#!/bin/bash
###
 # @Description: uboot 的编译脚本
 # @Author: TOTHTOT
 # @Date: 2024-01-27 11:46:41
 # @LastEditTime: 2024-07-26 23:09:08
 # @LastEditors: TOTHTOT
 # @FilePath: /aw_v3s_uboot/build_uboot.sh
### 

# 需要配置的变量
DEFCONFIG_NAME="yyh_LicheePi_Zero_defconfig"

SD_CARD_PATH=$1

# 检查是否设置了 SD_CARD_PATH 变量并且不为空
if [ -z "$SD_CARD_PATH" ]; then
  echo "Error: SD_CARD_PATH is not set or is empty. Aborting."
  exit 1
fi

# 检测是否存在/dev/sdb设备
if [ -e  $SD_CARD_PATH ]; then
  echo "${SD_CARD_PATH} exists. Proceeding with flashing..."
else
  echo "Error: ${SD_CARD_PATH} not found. Aborting."
  exit 1
fi

# 执行make命令
make $DEFCONFIG_NAME
make

# 检查make命令的返回值
if [ $? -eq 0 ]; then
  # make成功，执行下一步操作
  echo "Make successful. Flashing U-boot to ${SD_CARD_PATH}..."
  sudo dd if=u-boot-sunxi-with-spl.bin of=${SD_CARD_PATH} bs=1024 seek=8
  # 確保寫入成功
  sync
else
  # make失败，输出错误信息并退出
  echo "Make failed. Error encountered."
  exit 1
fi
