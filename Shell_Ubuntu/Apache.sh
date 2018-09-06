#!/bin/bash

###############
# Name: 安装 Apache
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use: curl -sSL http://dwz.cn/noqEPYs6 > /tmp/Apache && bash /tmp/Apache
###############

# 配置 Apache 安装源
if [ "${AptMirrorApacheDeb}" != "" ]; then
    echo "${AptMirrorApacheDeb}" | sudo tee /etc/apt/sources.list.d/apache.list
    sudo apt-get -y update
fi

# 安装 Apache
apache2 -v > /dev/null 2>&1
if [ $? -ne 0 ]; then
    sudo apt-get install -y apache2
else
    echo ">>>>> Info: The apache2 has been installed"
fi

# 解决：Protocol not available: AH00076: Failed to enable APR_TCP_DEFER_ACCEPT
grep "^AcceptFilter http none" /etc/apache2/apache2.conf > /dev/null 2>&1
[ $? -ne 0 ] && echo "AcceptFilter http none" | sudo tee -a /etc/apache2/apache2.conf
grep "^AcceptFilter https none" /etc/apache2/apache2.conf > /dev/null 2>&1
[ $? -ne 0 ] && echo "AcceptFilter https none" | sudo tee -a /etc/apache2/apache2.conf
