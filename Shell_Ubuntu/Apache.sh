#!/bin/bash

###############
# Name: 安装 Php 多版本
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use: curl -sSL http://dwz.cn/noqEPYs6 > /tmp/SelectMenu && bash /tmp/Apache
###############

# 安装 Apache
apache2 -v > /dev/null 2>&1
if [ $? -ne 0 ]; then
    sudo apt-get install -y apache2
else
    echo ">>>>> Info: The apache2 has been installed"
fi

# 设置 Apache2
grep "^AcceptFilter http none" /etc/apache2/apache2.conf > /dev/null 2>&1
[ $? -ne 0 ] && echo "AcceptFilter http none" | sudo tee -a /etc/apache2/apache2.conf
grep "^AcceptFilter https none" /etc/apache2/apache2.conf > /dev/null 2>&1
[ $? -ne 0 ] && echo "AcceptFilter https none" | sudo tee -a /etc/apache2/apache2.conf
