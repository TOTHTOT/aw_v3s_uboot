#!/bin/bash
###
 # @Description: uboot 的编译脚本
 # @Author: TOTHTOT
 # @Date: 2024-01-27 11:46:41
 # @LastEditTime: 2024-01-30 20:43:53
 # @LastEditors: TOTHTOT
 # @FilePath: /aw_v3s_uboot/build_uboot.sh
### 

# 需要配置的变量
SD_CARD_PATH="/dev/sdb"
DEFCONFIG_NAME="yyh_LicheePi_Zero_defconfig"

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
else
  # make失败，输出错误信息并退出
  echo "Make failed. Error encountered."
  exit 1
fi
