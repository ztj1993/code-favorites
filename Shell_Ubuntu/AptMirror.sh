#!/bin/bash

###############
# Name: 制作本地源
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use: curl -sSL http://dwz.cn/BFLKMuNv > /tmp/LocalMirror && bash /tmp/LocalMirror
###############

### 设置本地源路径
[ "${AptMirrorBasePath}" == "" ] && echo -en ">>> Please enter the base path: "
[ "${AptMirrorBasePath}" == "" ] && read AptMirrorBasePath
AptMirrorBasePath=${AptMirrorBasePath:-/var/spool/apt-mirror}

### 安装软件
type apt-mirror > /dev/null 2>&1
[ $? -ne 0 ] && sudo apt-get install -y apt-mirror

### 设置配置文件
echo "
set base_path ${AptMirrorBasePath}
set run_postmirror 0
set nthreads 20
set _tilde 0
" | sudo tee /etc/apt/mirror.list

### 设置文件存储路径
[ ! -d ${AptMirrorBasePath} ] && sudo mkdir ${AptMirrorBasePath}
[ ! -d ${AptMirrorBasePath}/mirror ] && sudo cp -fR /var/spool/apt-mirror/* ${AptMirrorBasePath}
