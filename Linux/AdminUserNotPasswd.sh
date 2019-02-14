#!/bin/bash

###############
# Name: 设置用户免密码执行管理命令
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use: curl -sSL https://dwz.cn/q0WvEdo5 > /tmp/AdminUserNotPasswd && bash /tmp/AdminUserNotPasswd
###############

### 设置变量
[ "${UserName}" == "" ] && echo -en ">>> Please enter the username: "
[ "${UserName}" == "" ] && read UserName

### 配置户免密码权限
echo "${UserName} ALL = (root) NOPASSWD:ALL" | tee /etc/sudoers.d/${UserName}
[ $? -ne 0 ] && echo ">>>>>> Error:$(basename ${BASH_SOURCE[0]%.*}) - ($LINENO)" && exit 1
chmod 0440 /etc/sudoers.d/${UserName}
[ $? -ne 0 ] && echo ">>>>>> Error:$(basename ${BASH_SOURCE[0]%.*}) - ($LINENO)" && exit 1
