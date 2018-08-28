###############
# Name: 获取是否为管理员
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
###############

$windowsIdentity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$windowsPrincipal = new-object 'System.Security.Principal.WindowsPrincipal' $windowsIdentity
return $windowsPrincipal.IsInRole('Administrators')
