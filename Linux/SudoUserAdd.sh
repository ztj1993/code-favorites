#!/bin/bash

###############
# Name: 添加具有 sudo 权限的用户
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use: curl -sSL https://dwz.cn/bMNlRccw > /tmp/SudoUserAdd && bash /tmp/SudoUserAdd
###############

### 设置变量
[ "${SudoUserName}" == "" ] && echo -en ">>> Please enter the username: "
[ "${SudoUserName}" == "" ] && read SudoUserName

### 创建用户
id -u ${SudoUserName} > /dev/null 2>&1
[ $? -ne 0 ] && sudo useradd -m ${SudoUserName}

### 赋予用户 sudo 权限
echo "${SudoUserName} ALL=(ALL) ALL" | sudo tee /etc/sudoers
