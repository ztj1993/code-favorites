###############
# Name: 配置 Windows10 & PowerShell
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use: PowerShell -Command "PowerShell -Command (Invoke-WebRequest http://dwz.cn/i50Ky2Yd).content"
###############

# 请以管理员运行脚本
$isAdmin = PowerShell -Command (Invoke-WebRequest 'http://dwz.cn/XF8rOhGn').content
if ($isAdmin -eq 'False')
{
    echo 'Please run this script to the administrator'
    exit (1)
}

# 允许 PowerShell 运行文件
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force

# 启用 Windows 10 子系统 Linux
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
