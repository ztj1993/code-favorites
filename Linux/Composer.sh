#!/bin/bash

###############
# Name: 安装 Composer
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use: curl -sSL https://dwz.cn/zuel6glQ > /tmp/Composer && bash /tmp/Composer
###############

### 定义变量
SoftwareUrl="https://getcomposer.org/composer.phar"
SoftwarePackagePath="/tmp/composer.phar"
SoftwareInstallPath="/usr/local/bin/composer"

### 环境处理
rm -rf ${SoftwarePackagePath}
rm -rf ${SoftwareInstallPath}

### 下载文件
wget -O ${SoftwarePackagePath} ${SoftwareUrl}

### 复制文件
cp ${SoftwarePackagePath} ${SoftwareInstallPath}

### 配置文件
chmod +x ${SoftwareInstallPath}
composer config -g secure-http false
