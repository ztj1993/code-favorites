#!/bin/bash

###############
# Name: 制作本地源
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use: curl http://dwz.cn/UnyZAXjf > /tmp/LocalMirror && bash /tmp/LocalMirror
###############

### 设置 Root 用户密码
[ "${BasePath}" == "" ] && echo -en ">>> Please enter the base path:"
[ "${BasePath}" == "" ] && read BasePath

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
