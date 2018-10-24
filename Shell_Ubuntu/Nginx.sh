#!/bin/bash

###############
# Name: 安装最新版 Nginx
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use: curl -sSL https://dwz.cn/o17MNmN8 > /tmp/Nginx && bash /tmp/Nginx
###############

! which nginx &>/dev/null || exit 1

nginx_sources_list=/etc/apt/sources.list.d/nginx.list

wget -O /tmp/nginx_signing.key http://nginx.org/keys/nginx_signing.key
sudo apt-key add /tmp/nginx_signing.key

ubuntu_codename=`lsb_release --codename --short`

cat<<-Note >/tmp/nginx-stable.sources.list
#set nginx sources
deb http://nginx.org/packages/ubuntu/ $ubuntu_codename nginx
deb-src http://nginx.org/packages/ubuntu/ $ubuntu_codename nginx
Note

sudo mv /tmp/nginx.sources.list $nginx_sources_list

sudo apt-get -y update
sudo apt-get -y install nginx
