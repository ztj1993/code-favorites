#!/bin/bash

###############
# Name: 安装 PhpMyAdmin
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use: curl -sSL https://dwz.cn/lYYBmI5l > /tmp/PhpMyAdmin && bash /tmp/PhpMyAdmin
###############

### 定义变量
ShellDir=$(cd $(dirname $(readlink -f ${BASH_SOURCE[0]})) && pwd)
SoftwareVersion="4.8.3"
SoftwareUrl="https://files.phpmyadmin.net/phpMyAdmin/${SoftwareVersion}/phpMyAdmin-${SoftwareVersion}-all-languages.tar.gz"
SoftwarePackagePath="/tmp/phpMyAdmin-${SoftwareVersion}-all-languages.tar.gz"
SoftwareInstallPath="${ShellDir}/phpMyAdmin"

### 下载文件
sudo rm -rf ${SoftwarePackagePath}
sudo wget -O ${SoftwarePackagePath} ${SoftwareUrl}

### 解压文件
sudo rm -rf ${SoftwareInstallPath}
sudo mkdir -p ${SoftwareInstallPath}
sudo tar -xf ${SoftwarePackagePath} --strip-components 1 -C ${SoftwareInstallPath}
sudo chown -R 777 ${SoftwareInstallPath}

### 配置
echo "
<?php
\$cfg['LoginCookieValidity'] = 144000;
\$cfg['AllowArbitraryServer'] = true;
" | sudo tee ${SoftwareInstallPath}/config.inc.php
