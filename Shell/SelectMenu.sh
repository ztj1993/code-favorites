#!/bin/bash

###############
# Name: 选择菜单
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use: curl -sSL http://dwz.cn/iRtqAy8Z > /tmp/SelectMenu && source /tmp/SelectMenu
###############

### 使用示例
if false ; then
    SelectMenuItems=("7.1", "5.6")
    SelectMenuTitle="请选择主 PHP 版本"
    curl -sSL http://dwz.cn/iRtqAy8Z > /tmp/SelectMenu && source /tmp/SelectMenu
    MainVersion=${SelectMenuItem}
fi

### 设置判断变量
[ "${SelectMenuItems}" == "" ] && echo ">>>>> Error: SelectMenuItems var do not exist" && exit 1
SelectMenuTitle=${SelectMenuTitle:-"Please select menu"}

### 显示提示
echo "----- ${SelectMenuTitle} -----"
for Index in ${!SelectMenuItems[@]}
do
    echo " ${Index}) ${SelectMenuItems[${Index}]}"
done

### 设置并获取选择的菜单项
read -p "Please enter index：" SelectMenuIndex
SelectMenuItem="${SelectMenuItems[${SelectMenuIndex}]}"
