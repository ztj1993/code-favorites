#!/bin/bash

###############
# Name: 安装 Php 多版本
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use: curl -sSL http://dwz.cn/VGuW5dDf > /tmp/Php && bash /tmp/Php
###############

### 设置源路径
[ "${AptMirrorUri}" == "" ] && echo -en ">>> Please enter the apt mirror uri: "
[ "${AptMirrorUri}" == "" ] && read AptMirrorUri
AptMirrorUri=${AptMirrorUri:-http://ppa.launchpad.net/ondrej/php/ubuntu}

### 设置镜像源
echo "deb ${AptMirrorUri} $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php.list
sudo apt-get -y update

# 安装 7.1
php7.1 -v > /dev/null 2>&1
if [ $? -ne 0 ]; then
    sudo apt-get install -y php7.1-fpm php7.1-mysql php7.1-curl php7.1-gd php7.1-mbstring php7.1-mcrypt php7.1-xml
    sudo apt-get install -y php7.1-zip php7.1-dev
    sudo apt-get install -y libapache2-mod-php7.1
else
    echo ">>>>> Info: The php 7.1 has been installed"
fi

# 安装 5.6
php5.6 -v > /dev/null 2>&1
if [ $? -ne 0 ]; then
    sudo apt-get install -y php5.6-fpm php5.6-mysql php5.6-curl php5.6-gd php5.6-mbstring php5.6-mcrypt php5.6-xml
    sudo apt-get install -y php5.6-zip php5.6-dev
    sudo apt-get install -y libapache2-mod-php5.6
else
    echo ">>>>> Info: The php 5.6 has been installed"
fi

# 选择主版本
if [ "${PhpMainVersion}" == "" ]; then
    SelectMenuItems=("7.1", "5.6")
    SelectMenuTitle="请选择主 PHP 版本"
    curl -sSL http://dwz.cn/tJvCyBGb > /tmp/SelectMenu && source /tmp/SelectMenu
    MainVersion=${SelectMenuItem}
fi
[ "${PhpMainVersion}" == "" ] && echo ">>>>> Error: You selected the version does not exist" && exit 1

# 设置 Apache
apache2 -v > /dev/null 2>&1
if [ $? -eq 0 ]; then
    sudo a2dismod php7.1
    sudo a2dismod php5.6
    sudo a2enmod php${PhpMainVersion}
    sudo service apache2 restart
fi

# 设置 Cli
sudo update-alternatives --set php /usr/bin/php${PhpMainVersion}
sudo update-alternatives --set phpize /usr/bin/phpize${PhpMainVersion}
sudo update-alternatives --set php-config /usr/bin/php-config${PhpMainVersion}

# 删除配置文件
rm -rf /etc/apt/sources.list.d/php.list
