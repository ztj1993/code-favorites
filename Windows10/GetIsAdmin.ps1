###############
# Name: 获取是否为管理员
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use: PowerShell -Command "PowerShell -Command (Invoke-WebRequest http://dwz.cn/XF8rOhGn).content"
###############

$windowsIdentity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$windowsPrincipal = new-object 'System.Security.Principal.WindowsPrincipal' $windowsIdentity
return $windowsPrincipal.IsInRole('Administrators')
