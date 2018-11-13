#!/bin/bash

###############
# Name: 安装 Ppa 软件
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
###############

### 设置快速安装
if [ "${1}" == "mqtt" ]; then
    SoftwareName="mqtt"
    UserName="mosquitto-dev"
    ProjectName="mosquitto-ppa"
    ProjectKey="5E64E954262C4500"
    Packages="mosquitto mosquitto-clients"
fi

if [ "${1}" == "python37" ]; then
    SoftwareName="python37"
    UserName="jonathonf"
    ProjectName="python-3.7"
    ProjectKey="8CF63AD3F06FC659"
    Packages="python3.7"
fi

### 设置变量
[ "${SoftwareName}" == "" ] && echo -en ">>> Please enter the software name: "
[ "${SoftwareName}" == "" ] && read SoftwareName

[ "${UserName}" == "" ] && echo -en ">>> Please enter the user name: "
[ "${UserName}" == "" ] && read UserName

[ "${ProjectName}" == "" ] && echo -en ">>> Please enter the project name: "
[ "${ProjectName}" == "" ] && read ProjectName

[ "${ProjectKey}" == "" ] && echo -en ">>> Please enter the project key: "
[ "${ProjectKey}" == "" ] && read ProjectKey

[ "${Packages}" == "" ] && echo -en ">>> Please enter the packages: "
[ "${Packages}" == "" ] && read Packages

### 设置镜像源
echo "
deb http://ppa.launchpad.net/${UserName}/${ProjectName}/ubuntu $(lsb_release -sc) main
" | sudo tee "/etc/apt/sources.list.d/${SoftwareName}.list"

### 设置项目密钥
sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com ${ProjectKey}

### 安装软件
sudo apt-get -y update
sudo apt-get install -y ${Packages}

### 清理文件
sudo rm rf "/etc/apt/sources.list.d/${SoftwareName}.list"
