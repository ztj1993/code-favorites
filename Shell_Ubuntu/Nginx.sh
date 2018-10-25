#!/bin/bash

###############
# Name: 安装 Nginx
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use: curl -sSL https://dwz.cn/o17MNmN8 > /tmp/Nginx && bash /tmp/Nginx
###############

### 设置镜像源
NginxMirror=${NginxMirror:-"deb http://nginx.org/packages/ubuntu/ $(lsb_release -sc) nginx"}
echo "${NginxMirror}" | sudo tee /etc/apt/sources.list.d/nginx.list
sudo apt-get -y update

### 导入密钥
wget -qO- http://nginx.org/keys/nginx_signing.key | apt-key add -

### 安装 Nginx
sudo apt-get -y install nginx

# 删除配置文件
sudo rm -rf /etc/apt/sources.list.d/nginx.list
