#!/bin/bash

###############
# Name: 选择菜单
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use: curl -sSL http://dwz.cn/iRtqAy8Z > /tmp/SelectMenu && source /tmp/SelectMenu
###############

[ "${SelectMenuItems}" == "" ] && echo ">>>>> Error: SelectMenuItems var do not exist" && exit 1
SelectMenuTitle=${SelectMenuTitle:-"Please select menu"}

echo "----- ${SelectMenuTitle} -----"
for Index in ${!SelectMenuItems[@]}
do
    echo " ${Index}) ${SelectMenuItems[${Index}]}"
done

read -p "Please enter index：" SelectMenuIndex

SelectMenuItem="${SelectMenuItems[${SelectMenuIndex}]}"
