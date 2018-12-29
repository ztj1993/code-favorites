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
[ $? -ne 0 ] && apt-get install -y dpkg-dev

### 清理设置目录
rm -rf /var/cache/apt/archives_mirror
mkdir /var/cache/apt/archives_mirror

### 制作映像源
cp /var/cache/apt/archives/*.deb ${MirrorDir}
dpkg-scanpackages ${MirrorDir} /dev/null | tee ${MirrorDir}/Packages
cat ${MirrorDir}/Packages | sed "s/Filename: \.\//Filename: /g"
sed -i "s@${MirrorDir}/@@" ${MirrorDir}/Packages
gzip ${MirrorDir}/Packages
