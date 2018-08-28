#!/bin/bash

###############
# Name: 设置 Privoxy
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use: curl -sSL http://dwz.cn/62Vd0UYa > /tmp/PrivoxySocks5 && bash /tmp/PrivoxySocks5
###############

### 设置 socks5
[ "${socks5}" == "" ] && echo -en ">>> Please enter the socks5: "
[ "${socks5}" == "" ] && read socks5

### 安装必要软件
sudo apt-get install -y privoxy
[ $? -ne 0 ] && echo ">>>>>> Error:$(basename ${BASH_SOURCE[0]%.*}) - ($LINENO)" && exit 1

### 设置监听
grep "^listen-address" /etc/privoxy/config > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "listen-address 0.0.0.0:8118" | sudo tee -a /etc/privoxy/config
else
    sudo sed -i "s@^listen-address.*@listen-address 0.0.0.0:8118@" /etc/privoxy/config
fi

### 设置代理
grep "^forward-socks5" /etc/privoxy/config > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "forward-socks5 / ${socks5} ." | sudo tee -a /etc/privoxy/config
else
    sudo sed -i "s@^forward-socks5.*@forward-socks5 / ${socks5} .@" /etc/privoxy/config
fi

### 重启服务
sudo service privoxy restart
