#!/bin/bash

###############
# Name: CentOS 设置本地映像
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use: curl -sSL http://dwz.cn/XfSHAWyR > /tmp/Mirror && bash /tmp/Mirror
###############

### 设置变量
OS_VERSION=$(cat /etc/os-release | grep VERSION_ID | cut -d '"' -f 2 |  awk -F'.' '{ print $1 }')
DateTime=`date +%Y-%m-%d-%H-%M-%S`

### 设置镜像源
if [ "${OS_VERSION}" == "7" ]; then
    mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup.${DateTime}
    curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
fi

sleep 2

### 生成缓存
yum makecache

sleep 2
