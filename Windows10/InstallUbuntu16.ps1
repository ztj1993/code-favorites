###############
# Name: 安装 Ubuntu 16 版本
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use:
#     $url = 'http://dwz.cn/hqp2PM1S'
#     $str = [Text.Encoding]::UTF8.GetString((Invoke-WebRequest $url).RawContentStream.ToArray())
#     PowerShell -Command $str
###############

$ProgressPreference = 'SilentlyContinue'

# 设置 Ubuntu 安装目录
if ( [String]::IsNullOrEmpty($env:UbuntuDir))
{
    $env:UbuntuDir = $env:USERPROFILE
}

# 设置 Ubuntu 应用包下载地址
if ( [String]::IsNullOrEmpty($env:UbuntuUri))
{
    $env:UbuntuUri = 'https://aka.ms/wsl-ubuntu-1604'
}

# 下载应用
if (-Not(Test-Path $env:UbuntuDir\Ubuntu.zip))
{
    Invoke-WebRequest -Uri $env:UbuntuUri -OutFile $env:UbuntuDir\Ubuntu.zip -UseBasicParsing
}

if (-Not(Test-Path $env:UbuntuDir\Ubuntu.zip))
{
    echo 'File download error'
    exit (1)
}

# 校验应用
if ((Get-FileHash $env:UbuntuDir\Ubuntu.zip -Algorithm MD5).Hash -ne 'F59BD7D5A8BE43E4E3F42C71640D2D17')
{
    echo 'File md5 check failure'
    exit (1)
}

# 解压应用
Expand-Archive $env:UbuntuDir\Ubuntu.zip $env:UbuntuDir\Ubuntu

# 清理旧的应用
PowerShell -Command $env:UbuntuDir\Ubuntu\ubuntu.exe clean

# 运行应用
PowerShell -Command $env:UbuntuDir\Ubuntu\ubuntu.exe
