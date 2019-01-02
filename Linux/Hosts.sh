#!/bin/bash

###############
# Name: 设置 Hosts
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Params: <Action>[add|del] 要执行的动作
# Params: <Host>[hostname] 主机名称
# Params: <Ip>[ip] 网络地址
# Return=0: 执行成功
# Return=1: 执行失败
# Output: 失败消息
# Use: curl -sSL https://dwz.cn/yjbQR8F5 > /tmp/Hosts && bash /tmp/Hosts
###############

### 定义帮助文本
if [ "${1}" == "" ]; then
    echo ">>> Params: <Action>[add|del] 要执行的动作"
    echo ">>> Params: <Host>[hostname] 主机名称"
    echo ">>> Params: <Ip>[ip] 网络地址"
    exit 0
fi

### 设置变量
Action="${1}"
Host="${2}"
Ip="${3}"

### 添加逻辑
function add(){
    ### 如果存在域名配置，则跳过
    cat /etc/hosts | grep "^${Ip}\s*${Host}" > /dev/null 2>&1
    [ $? -eq 0 ] && exit 0

    ### 注释掉域名配置
    sed -i -e "s/^[0-9]\S*\s*${Host}/# &/" /etc/hosts

    ### 如果存在域名配置，但被注释，则取消注释
    Str=$(cat /etc/hosts | grep "^#\s*${Ip}\s*${Host}" | head -n 1)
    [ -n "${Str}" ] && sed -i -e "/${Str}/s/#\s*//" /etc/hosts && exit 0

    ### 追加域名配置
    echo "${Ip}   ${Host}" | tee -a /etc/hosts
}

### 删除逻辑
function del(){
    ### 注释掉域名配置
    sed -i -e "s/^[0-9]\S*\s*${Host}/# &/" /etc/hosts
}

### 调用函数
${Action}
