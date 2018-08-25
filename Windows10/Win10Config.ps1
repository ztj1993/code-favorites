###############
# Name: 配置 Windows10 & PowerShell
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use:
#     $url = 'http://dwz.cn/i50Ky2Yd'
#     $str = [Text.Encoding]::UTF8.GetString((Invoke-WebRequest $url).RawContentStream.ToArray())
#     PowerShell -Command $str
###############

# 请以管理员运行脚本
$url = 'http://dwz.cn/XF8rOhGn'
$str = [Text.Encoding]::UTF8.GetString((Invoke-WebRequest $url).RawContentStream.ToArray())
$isAdmin = PowerShell -Command $str
if ($isAdmin -eq 'False')
{
    echo 'Please run this script to the administrator'
    exit (1)
}

# 允许 PowerShell 运行文件
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force

# 启用 Windows 10 子系统 Linux
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
