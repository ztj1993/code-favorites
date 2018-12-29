#!/bin/bash

###############
# Name: 安装 Nginx
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use: curl -sSL https://dwz.cn/75uVAyIJ > /tmp/Nginx && bash /tmp/Nginx
###############

### 设置变量
OS_VERSION=$(cat /etc/os-release | grep VERSION_ID | cut -d '"' -f 2 |  awk -F '.' '{ print $1 }')
PackageName="nginx-release-centos-${OS_VERSION}-0.el${OS_VERSION}.ngx.noarch"
PackageUri="http://nginx.org/packages/centos/${OS_VERSION}/noarch/RPMS"

### 安装包
rpm -Uvh "${PackageUri}/${PackageName}.rpm"

### 安装更新软件
yum makecache
yum install -y nginx

### 配置系统
id -u www >/dev/null 2>&1
[ $? -ne 0 ] && useradd -M -s /sbin/nologin www

### 配置软件
sed -i "s@^user.*@user www;@" /etc/nginx/nginx.conf

### 设置开机启动项
systemctl start nginx.service
systemctl enable nginx.service

### 移除无用包
yum remove -y ${PackageName}
