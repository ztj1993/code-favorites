
###############
# Name: 安装 Ubuntu 16 版本
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use: PowerShell -Command "PowerShell -Command (Invoke-WebRequest http://dwz.cn/hqp2PM1S).content"
###############

$ProgressPreference = 'SilentlyContinue'

# 下载应用
if (-Not(Test-Path ~/Ubuntu.zip)) {
    Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1604 -OutFile ~/Ubuntu.zip -UseBasicParsing
}

# 解压应用
if (-Not(Test-Path ~/Ubuntu)) {
    Expand-Archive ~/Ubuntu.zip ~/Ubuntu
}

# 清理旧的应用
~/Ubuntu/ubuntu.exe clean

# 运行应用
~/Ubuntu/ubuntu.exe
