###############
# Name: auto source file
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use: PowerShell iex(New-Object Net.WebClient).DownloadString('https://dwz.cn/mPPBKOv2')
###############

function AutoSource($FilePath, $arguments, $LocalPath, $RemoteUri)
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
    # 获取脚本内容
    if (Test-Path "$LocalPath/$FilePath")
    {
        $Script = (New-Object Net.WebClient).DownloadString("$LocalPath/$FilePath")
    }
    else
    {
        $Script = (New-Object Net.WebClient).DownloadString("$RemoteUri/$FilePath")
    }
    # 执行脚本
    if (($arguments -eq "") -or ($arguments -eq $null))
    {
        Invoke-Command -ScriptBlock ([ScriptBlock]::Create($Script))
    }
    else
    {
        Invoke-Command -ScriptBlock ([ScriptBlock]::Create($Script)) -ArgumentList $arguments
    }
}
