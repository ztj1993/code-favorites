###############
# Name: auto source file
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use: PowerShell iex(New-Object Net.WebClient).DownloadString('https://dwz.cn/mPPBKOv2')
###############

function AutoSource($FilePath, $LocalPath, $RemoteUri)
{
    # 设置默认本地路径
    if (($LocalPath -eq "") -or ($LocalPath -eq $null))
    {
        $LocalPath = "$env:ScriptLocalPath"
    }
    # 设置默认远程路径
    if (($RemoteUri -eq "") -or ($RemoteUri -eq $null))
    {
        $RemoteUri = "$env:ScriptRemoteUri"
    }
    # 脚本执行
    if (Test-Path "$LocalPath/$FilePath")
    {
        . "$LocalPath/$FilePath"
    }
    else
    {
        iex(New-Object Net.WebClient).DownloadString("$RemoteUri/$FilePath")
    }
}
