#!/bin/bash

###############
# Name: 安装 PhpUnit
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use: curl -sSL https://dwz.cn/RmP7RLuL > /tmp/PhpUnit && bash /tmp/PhpUnit
###############

### 定义变量
SoftwareUrl="https://phar.phpunit.de/phpunit.phar"
SoftwarePackagePath="/tmp/phpunit.phar"
SoftwareInstallPath="/usr/local/bin/phpunit"

### 环境处理
rm -rf ${SoftwarePackagePath}
rm -rf ${SoftwareInstallPath}

### 下载文件
wget -O ${SoftwarePackagePath} ${SoftwareUrl}

### 复制文件
cp ${SoftwarePackagePath} ${SoftwareInstallPath}

### 配置文件
chmod +x ${SoftwareInstallPath}
