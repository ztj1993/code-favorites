#!/bin/bash

###############
# Name: 制作本地源
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use: curl -sSL https://raw.githubusercontent.com/ztj1993/CodeFavorites/master/Shell_Ubuntu/LocalMirror.sh | sh
###############

sudo apt-get install -y apt-mirror

echo "
deb http://ppa.launchpad.net/ondrej/php/ubuntu xenial main

clean http://ppa.launchpad.net/ondrej/php/ubuntu
" | sudo tee /etc/apt/mirror.list

echo "
file:///var/spool/apt-mirror/mirror/ppa.launchpad.net/ondrej/php/ubuntu
" | sudo tee /etc/apt/sources.list.d/php.list
