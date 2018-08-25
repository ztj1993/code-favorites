###############
# Name: 获取是否为管理员
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use:
#     $url = 'http://dwz.cn/XF8rOhGn'
#     $str = [Text.Encoding]::UTF8.GetString((Invoke-WebRequest $url).RawContentStream.ToArray())
#     PowerShell -Command $str
###############

$windowsIdentity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$windowsPrincipal = new-object 'System.Security.Principal.WindowsPrincipal' $windowsIdentity
return $windowsPrincipal.IsInRole('Administrators')
