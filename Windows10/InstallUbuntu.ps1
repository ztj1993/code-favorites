###############
# Name: Install Windows 10 SubSystem Ubuntu16
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
###############

# 设置 Ubuntu 变量
if ( [String]::IsNullOrEmpty($env:UbuntuPackagePath))
{
    $env:UbuntuPackagePath = Read-Host "Please enter package path"
}
if ( [String]::IsNullOrEmpty($env:UbuntuInstallPath))
{
    $env:UbuntuInstallPath = Read-Host "Please enter install path"
}

# 变量提示
echo 'Ubuntu package path: ' + $env:UbuntuPackagePath
echo 'Ubuntu install path: ' + $env:UbuntuInstallPath

### 校验变量
if (-Not(Test-Path $env:UbuntuPackagePath))
{
    Write-Warning -Message "Ubuntu package path does not exist"
    return
}

# 校验应用
if ((Get-FileHash $env:UbuntuPackagePath -Algorithm MD5).Hash -ne 'F59BD7D5A8BE43E4E3F42C71640D2D17')
{
    Write-Warning -Message "Ubuntu package file md5 check failure"
    return
}

# 解压应用
if (-Not(Test-Path $env:UbuntuInstallPath\ubuntu.exe))
{
    echo 'Ubuntu app unzip ......'
    Expand-Archive $env:UbuntuPackagePath $env:UbuntuInstallPath
}

# 清理旧的应用
if (Test-Path $env:UbuntuInstallPath\rootfs)
{
    echo 'Ubuntu app clean ......'
    Start-Process $env:UbuntuInstallPath\ubuntu.exe clean -Wait
}

# 运行应用
echo 'Ubuntu app run ......'
Start-Process $env:UbuntuInstallPath\ubuntu.exe -Wait

# 安装完成
echo 'Ubuntu app install complete'
