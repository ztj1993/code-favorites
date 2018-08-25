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

# 下载应用
if (-Not(Test-Path $env:UbuntuDir/Ubuntu.zip))
{
    Invoke-WebRequest -Uri 'https://aka.ms/wsl-ubuntu-1604' -OutFile $env:UbuntuDir/Ubuntu.zip -UseBasicParsing
}

# 解压应用
if (-Not(Test-Path $env:UbuntuDir/Ubuntu))
{
    Expand-Archive $env:UbuntuDir/Ubuntu.zip $env:UbuntuDir/Ubuntu
}

# 清理旧的应用
$env:UbuntuDir/Ubuntu/ubuntu.exe clean

# 运行应用
$env:UbuntuDir/Ubuntu/ubuntu.exe
