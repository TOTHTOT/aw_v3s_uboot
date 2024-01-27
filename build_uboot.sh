#!/bin/bash

# 检测是否存在/dev/sdb设备
if [ -e "/dev/sdb" ]; then
  echo "/dev/sdb exists. Proceeding with flashing..."
else
  echo "Error: /dev/sdb not found. Aborting."
  exit 1
fi

# 执行make命令
make yyh_LicheePi_Zero_defconfig
make

# 检查make命令的返回值
if [ $? -eq 0 ]; then
  # make成功，执行下一步操作
  echo "Make successful. Flashing U-boot to /dev/sdb..."
  sudo dd if=u-boot-sunxi-with-spl.bin of=/dev/sdb bs=1024 seek=8
else
  # make失败，输出错误信息并退出
  echo "Make failed. Error encountered."
  exit 1
fi
