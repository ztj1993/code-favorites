###############
# Name: 配置 Windows10 & PowerShell
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
###############

# 请以管理员运行脚本
$windowsIdentity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$windowsPrincipal = new-object 'System.Security.Principal.WindowsPrincipal' $windowsIdentity
$isAdmin = $windowsPrincipal.IsInRole('Administrators')
if (-not($isAdmin))
{
    echo 'Please run this script to the administrator'
    exit (1)
}

# 允许 PowerShell 运行文件
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force

# 启用 Windows 10 子系统 Linux
$FeatureName = 'Microsoft-Windows-Subsystem-Linux'
if ((Get-WindowsOptionalFeature -Online -FeatureName $FeatureName).State -ne 'Enabled')
{
    Enable-WindowsOptionalFeature -Online -FeatureName $FeatureName
}
