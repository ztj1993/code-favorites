#!/bin/bash

###############
# Name: Ubuntu 初始化脚本
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use: curl -sSL http://dwz.cn/PSqu4sDp > /tmp/UbuntuInit && bash /tmp/UbuntuInit
###############

### 设置环境变量
export RootNewPwd=123456
export BaseUri="https://raw.githubusercontent.com/ztj1993/CodeFavorites/master/Shell_Ubuntu"

### 配置系统
curl -sSL "${BaseUri}/Mirror.sh" > /tmp/Mirror && bash /tmp/Mirror
curl -sSL "${BaseUri}/SelfUserSudo.sh" > /tmp/SelfUserSudo && bash /tmp/SelfUserSudo
curl -sSL "${BaseUri}/AllowRootSsh.sh" > /tmp/AllowRootSsh && bash /tmp/AllowRootSsh

### 更新系统
sudo apt-get -y update
sudo apt-get -y upgrade
