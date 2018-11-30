#!/bin/bash

###############
# Name: Debian 设置本地映像
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use: curl -sSL http://dwz.cn/KZhz0bjv > /tmp/Mirror && bash /tmp/Mirror
###############

### 设置镜像源
mirror_8="
deb http://mirrors.aliyun.com/debian/ jessie main non-free contrib
deb http://mirrors.aliyun.com/debian/ jessie-proposed-updates main non-free contrib
deb-src http://mirrors.aliyun.com/debian/ jessie main non-free contrib
deb-src http://mirrors.aliyun.com/debian/ jessie-proposed-updates main non-free contrib
"

mirror_9="
deb http://mirrors.aliyun.com/debian/ stretch main non-free contrib
deb-src http://mirrors.aliyun.com/debian/ stretch main non-free contrib
deb http://mirrors.aliyun.com/debian-security stretch/updates main
deb-src http://mirrors.aliyun.com/debian-security stretch/updates main
deb http://mirrors.aliyun.com/debian/ stretch-updates main non-free contrib
deb-src http://mirrors.aliyun.com/debian/ stretch-updates main non-free contrib
deb http://mirrors.aliyun.com/debian/ stretch-backports main non-free contrib
deb-src http://mirrors.aliyun.com/debian/ stretch-backports main non-free contrib
"

### 判断是否有匹配的镜像源
OS_VERSION=$(cat /etc/os-release | grep VERSION_ID | cut -d '"' -f 2 |  awk -F'.' '{ print $1 }')

echo "$(eval echo \"\${mirror_${OS_VERSION}}\")" | sudo tee /etc/apt/sources.list

sleep 2

sudo apt-get update

sleep 2
