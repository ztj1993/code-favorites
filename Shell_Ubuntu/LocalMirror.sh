#!/bin/bash

###############
# Name: 制作本地源
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use: curl -sSL http://dwz.cn/UnyZAXjf > /tmp/LocalMirror && bash /tmp/LocalMirror
###############

### 设置 Root 用户密码
[ "${BasePath}" == "" ] && echo -en ">>> Please enter the base path: "
[ "${BasePath}" == "" ] && read BasePath
BasePath=${BasePath:-/var/spool/apt-mirror}

sudo apt-get install -y apt-mirror

echo "
set base_path ${BasePath}
set run_postmirror 0
set nthreads 20
set _tilde 0

deb http://ppa.launchpad.net/ondrej/php/ubuntu xenial main
clean http://ppa.launchpad.net/ondrej/php/ubuntu
" | sudo tee /etc/apt/mirror.list

echo "
file://${BasePath}/mirror/ppa.launchpad.net/ondrej/php/ubuntu
" | sudo tee /etc/apt/sources.list.d/php.list

[ ! -d ${BasePath} ] && sudo mkdir ${BasePath}
[ ! -d ${BasePath}/mirror ] && sudo cp -fR /var/spool/apt-mirror/* ${BasePath}
