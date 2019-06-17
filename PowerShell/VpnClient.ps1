###############
# Name: Windows 10 创建 VPN 客户端
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
###############

$Name = Read-Host -Prompt '请输入 VPN 名称'
$Server = Read-Host -Prompt '请输入 VPN 服务器地址'
$Psk = Read-Host -Prompt '请输入 VPN 预共享密钥'

REG ADD HKLM\SYSTEM\CurrentControlSet\Services\PolicyAgent /v AssumeUDPEncapsulationContextOnSendRule /t REG_DWORD /d 0x2 /f
REG ADD HKLM\SYSTEM\CurrentControlSet\Services\RasMan\Parameters /v ProhibitIpSec /t REG_DWORD /d 0x0 /f

Import-Module VpnClient
Add-VpnConnection -Name $Name -ServerAddress $Server -L2tpPsk $Psk -TunnelType L2tp -EncryptionLevel Required -AuthenticationMethod Chap,MSChapv2 -Force -RememberCredential -PassThru
