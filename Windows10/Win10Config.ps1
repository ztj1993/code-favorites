###############
# Name: Config Windows10
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use: PowerShell iex(New-Object Net.WebClient).DownloadString('http://dwz.cn/i50Ky2Yd')
###############

# Is Administrator
$windowsIdentity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$windowsPrincipal = New-Object System.Security.Principal.WindowsPrincipal($windowsIdentity)
$isAdmin = $windowsPrincipal.IsInRole('Administrators')
if (-not($isAdmin))
{
    echo 'Please run this script to the administrator'
    exit (1)
}

# Allow execution of powershell file
$isExecFile = Get-ExecutionPolicy
if ($isExecFile -ne 'RemoteSigned')
{
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force
}

# Enabling Windows 10 Subsystem
$FeatureName = 'Microsoft-Windows-Subsystem-Linux'
if ((Get-WindowsOptionalFeature -Online -FeatureName $FeatureName).State -ne 'Enabled')
{
    Enable-WindowsOptionalFeature -Online -FeatureName $FeatureName
}
