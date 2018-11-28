#!/bin/bash

###############
# Name: 设置代理用户
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use: curl -sSL https://dwz.cn/RW9xcUW0 > /tmp/ProxyUser && bash /tmp/ProxyUser
###############

[ "${user}" == "" ] && echo -en ">>> Please enter the User Name: "
[ "${user}" == "" ] && read user
[ "${password}" == "" ] && echo -en ">>> Please enter the User Password: "
[ "${password}" == "" ] && read password

### 写入代理登陆脚本
echo '
#!/bin/sh

stty erase ^H
stty kill ^U
echo -en "SSH to Host :"
read host
echo -en "UserName: "
read username
/usr/bin/ssh $host -l $username
' | sudo tee /usr/bin/proxylogin
sudo chmod 755 /usr/bin/proxylogin

### 创建代理用户组
sudo groupadd -f proxy

### 创建自定义代理用户
id -u ${user} >/dev/null 2>&1
if [ $? -ne 0 ]; then
    sudo useradd -M -g proxy -s /usr/bin/proxylogin ${user}
    echo ${password} | sudo passwd ${user} --stdin  &>/dev/null
else
    echo ">>>>> Error: the username exists"
    exit 1
fi
