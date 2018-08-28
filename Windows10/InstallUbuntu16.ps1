###############
# Name: 安装 Ubuntu 16 版本
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
###############

$ProgressPreference = 'SilentlyContinue'

# 设置 Ubuntu 相关变量
if ( [String]::IsNullOrEmpty($env:UbuntuUri))
{
    $env:UbuntuUri = 'https://aka.ms/wsl-ubuntu-1604'
}
if ( [String]::IsNullOrEmpty($env:UbuntuInstallDir))
{
    $env:UbuntuInstallDir = $env:USERPROFILE + '\Ubuntu'
}
if ( [String]::IsNullOrEmpty($env:UbuntuDownloadPath))
{
    $env:UbuntuDownloadPath = $env:USERPROFILE + '\Ubuntu.zip'
}
echo 'Ubuntu app install dir: ' + $env:UbuntuInstallDir
echo 'Ubuntu app download path: ' + $env:UbuntuDownloadPath
echo 'Ubuntu app uri: ' + $env:UbuntuUri

# 下载应用
if (-Not(Test-Path $env:UbuntuDownloadPath))
{
    echo 'Ubuntu app downloading ......'
    Invoke-WebRequest -Uri $env:UbuntuUri -OutFile $env:UbuntuDownloadPath -UseBasicParsing
}

# 校验应用
if ((Get-FileHash $env:UbuntuDownloadPath -Algorithm MD5).Hash -ne 'F59BD7D5A8BE43E4E3F42C71640D2D17')
{
    echo 'File md5 check failure'
    exit (1)
}
else
{
    echo 'Ubuntu app check ok'
}

# 解压应用
if (-Not(Test-Path $env:UbuntuInstallDir))
{
    echo 'Ubuntu app unzip ......'
    Expand-Archive $env:UbuntuDir\Ubuntu.zip $env:UbuntuDir\Ubuntu
}
else
{
    echo 'Ubuntu app install dir exist, skip unzip'
}

# 清理旧的应用
echo 'Ubuntu app clean ......'
Start-Process $env:UbuntuInstallDir\ubuntu.exe clean -Wait

# 运行应用
echo 'Ubuntu app run ......'
Start-Process $env:UbuntuInstallDir\ubuntu.exe -Wait

# 安装完成
echo 'Ubuntu app install complete'
