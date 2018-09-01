#!/bin/bash

###############
# Name: 制作镜像源
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use: curl -sSL http://dwz.cn/Y1PxZtyb > /tmp/AllowRootSsh && bash /tmp/AllowRootSsh
###############

### 设置变量
MirrorDir="/var/cache/apt/archives_mirror"

### 安装软件
type dpkg-scanpackages > /dev/null 2>&1
[ $? -ne 0 ] && sudo apt-get install -y dpkg-dev

### 清理设置目录
sudo rm -rf /var/cache/apt/archives_mirror
sudo mkdir /var/cache/apt/archives_mirror

### 制作映像源
sudo cp /var/cache/apt/archives/*.deb ${MirrorDir}
dpkg-scanpackages ${MirrorDir} /dev/null | sudo tee ${MirrorDir}/Packages && sudo gzip ${MirrorDir}/Packages
