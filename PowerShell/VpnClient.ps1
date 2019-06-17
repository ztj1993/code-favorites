###############
# Name: Windows 10 VPN Client
# Author: Ztj
# Email: ztj1993@gmail.com
# Use: iex(new-object net.webclient).downloadstring('https://dwz.cn/CxHFkLgw')
###############

$Name = Read-Host -Prompt "Please enter VPN name"
$Server = Read-Host -Prompt "Please enter VPN server address"
$Psk = Read-Host -Prompt "Please enter VPN Pre-shared key"

REG ADD HKLM\SYSTEM\CurrentControlSet\Services\PolicyAgent /v AssumeUDPEncapsulationContextOnSendRule /t REG_DWORD /d 0x2 /f
REG ADD HKLM\SYSTEM\CurrentControlSet\Services\RasMan\Parameters /v ProhibitIpSec /t REG_DWORD /d 0x0 /f

Import-Module VpnClient
Add-VpnConnection -Name $Name -ServerAddress $Server -L2tpPsk $Psk -TunnelType L2tp -EncryptionLevel Required -AuthenticationMethod Chap,MSChapv2 -Force -RememberCredential -PassThru
