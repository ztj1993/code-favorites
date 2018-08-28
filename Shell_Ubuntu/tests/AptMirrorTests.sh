#!/bin/bash

###############
# Name: 制作本地源测试脚本
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 设置变量
ShellPath=$(cd $(dirname $(readlink -f "${BASH_SOURCE[0]}")) && pwd )
export AptMirrorBasePath="/var/spool/apt-mirror-tests"
export AptMirrorBaseDeb="deb http://nginx.org/packages/ubuntu/ $(lsb_release -sc) nginx"
export AptMirrorLocalPath="${AptMirrorBasePath}/mirror/nginx.org/packages/ubuntu"
export AptMirrorLocalUri="file://${AptMirrorLocalPath}"

### 执行脚本
# bash ${ShellPath}/../AptMirror.sh

### 验证安装
echo "deb ${AptMirrorLocalUri} $(lsb_release -sc) nginx" | sudo tee /etc/apt/sources.list.d/nginx.list
sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com ABF5BD827BD9BF62
sudo apt-get update
sudo apt-get install nginx
