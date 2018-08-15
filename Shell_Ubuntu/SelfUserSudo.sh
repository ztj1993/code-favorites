#!/bin/bash

###############
# Name: 设置当前用户免 sudo 密码
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use: curl -sSL https://raw.githubusercontent.com/ztj1993/CodeFavorites/master/Shell_Ubuntu/SelfUserSudo.sh | sh
###############

UserName="$USER"

### 配置当前用户免密码权限
echo "${UserName} ALL = (root) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/${UserName}
[ $? -ne 0 ] && echo ">>>>>> Error:$(basename ${BASH_SOURCE[0]%.*}) - ($LINENO)" && exit 1
sudo chmod 0440 /etc/sudoers.d/${UserName}
[ $? -ne 0 ] && echo ">>>>>> Error:$(basename ${BASH_SOURCE[0]%.*}) - ($LINENO)" && exit 1