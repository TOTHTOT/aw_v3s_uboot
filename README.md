# 全志V3s配置项

## nfs配置:

```shell
- sudo vim /etc/exports
  #添加nfs目录
  /home/yyh/Learn/aw_v3s/nfs *(rw,sync,no_root_squash)

- 烧写Uboot到sd指定位置
  sudo dd if=u-boot-sunxi-with-spl.bin of=/dev/sdb bs=1024 seek=8
```

## Linux 5.2.x内核配置保存位置

```shell
# Image位置
./arch/arm/boot/zImage

# 设备树位置
./arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dtb

# buildroot配置文件保存位置
./configs/yyh_lichee_zero_defconfig

# 使用apt-get 安装的交叉编译器位置
/usr/lib/gcc-cross/arm-linux-gnueabihf/7.5.0/include
```

## uboot配置网络信息

```shell
setenv ipaddr 192.168.0.110 # 开发板的 IP 地址
setenv serverip 192.168.0.101 # TFTP 服务器的 IP 地址
setenv netmask 255.255.255.0 # 子网掩码
setenv gatewayip 192.168.0.1 # 网关 IP 地址
```

## 通过tftp从Ubuntu的tftp目录下载zImage和设备树的命令

- bootcmd:

```shell
setenv bootcmd 'setenv bootm_boot_mode sec;tftp 41000000 ./aw_v3s/zImage;tftp 41800000 ./aw_v3s/sun8i-v3s-licheepi-zero.dtb;bootz 0x41000000 - 0x41800000'
```

## 使用正点原子的rgb屏幕:

```shell
setenv bootcmd 'setenv bootm_boot_mode sec;tftp 41000000 ./aw_v3s/zImage;tftp 41800000 ./aw_v3s/sun8i-v3s-licheepi-zero-with-1024x600-lcd.dtb;bootz 0x41000000 - 0x41800000'
```

## 通过nfs挂载文件系统bootargs

```shell
setenv bootargs "root=/dev/nfs nfsroot=192.168.0.101:/home/yyh/Learn/aw_v3s/nfs,nfsvers=2 rw ip=192.168.0.110:192.168.0.101:192.168.0.1:255.255.255.0::eth0:off init=/linuxrc console=ttyS0,115200""
```

## 通过tf卡挂在文件系统

```shell

```

## 设置PS1命令提示符

- /etc/profile, 注释掉关于PS1的代码

```shell
export PS1="\[\e[32;1m\][\[\e[33;1m\]\u\[\e[31;1m\]@\[\e[33;1m\]\h \[\e[36;1m\]\w\[\e[32;1m\]]\[\e[34;1m\]\$ \[\e[0m\]"
```
