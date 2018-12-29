#!/bin/bash

###############
# Name: 添加具有管理员权限的用户
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use: curl -sSL https://dwz.cn/bMNlRccw > /tmp/AdminUserAdd && bash /tmp/AdminUserAdd
###############

### 设置变量
[ "${AdminUserName}" == "" ] && echo -en ">>> Please enter the username: "
[ "${AdminUserName}" == "" ] && read AdminUserName

### 创建用户
id -u ${AdminUserName} > /dev/null 2>&1
[ $? -ne 0 ] && useradd -m ${AdminUserName}

### 赋予用户管理员权限
echo "${AdminUserName} ALL=(ALL) ALL" | tee -a /etc/sudoers
