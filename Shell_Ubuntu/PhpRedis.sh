#!/bin/bash

###############
# Name: 安装 Php Redis
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use: curl -sSL http://dwz.cn/4EssYNkn > /tmp/PhpRedis && bash /tmp/PhpRedis
###############

### 设置变量
PhpVersion=$(php-config --version)
PhpVersion=${PhpVersion:0:3}
phpEtcPath=/etc/php/${PhpVersion}

### 判断环境
type phpize > /dev/null 2>&1
[ $? -ne 0 ] && echo ">>>>>> Error: Please install php-dev first." && exit 1
type git > /dev/null 2>&1
[ $? -ne 0 ] && echo ">>>>>> Error: Please install git first." && exit 1

### 拉取代码
[ ! -d /tmp/phpredis ] && git clone https://github.com/phpredis/phpredis.git /tmp/phpredis
cd /tmp/phpredis

### 编译模块
phpize
[ $? -ne 0 ] && echo ">>>>>> Error:$(basename ${BASH_SOURCE[0]%.*}) - ($LINENO)" && exit 1
./configure
[ $? -ne 0 ] && echo ">>>>>> Error:$(basename ${BASH_SOURCE[0]%.*}) - ($LINENO)" && exit 1
make
[ $? -ne 0 ] && echo ">>>>>> Error:$(basename ${BASH_SOURCE[0]%.*}) - ($LINENO)" && exit 1
sudo make install
[ $? -ne 0 ] && echo ">>>>>> Error:$(basename ${BASH_SOURCE[0]%.*}) - ($LINENO)" && exit 1

### 配置软件
echo "extension=redis.so" | sudo tee ${phpEtcPath}/mods-available/redis.ini
for dir in $(ls ${phpEtcPath})
do
    [ "${dir}" == "mods-available" ] && continue
    if [ -d ${phpEtcPath}/${dir}/conf.d ]; then
        sudo rm -rf ${phpEtcPath}/${dir}/conf.d/redis.ini
        sudo ln -s ${phpEtcPath}/mods-available/redis.ini ${phpEtcPath}/${dir}/conf.d/redis.ini
    fi
done
