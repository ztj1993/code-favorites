###############
# Name: auto source file
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use: PowerShell iex(New-Object Net.WebClient).DownloadString('https://dwz.cn/mPPBKOv2')
###############

function AutoContent($FilePath, $LocalPath, $RemoteUri)
{
    # 设置默认本地路径
    if (($LocalPath -eq "") -or ($LocalPath -eq $null))
    {
        $LocalPath = "$AutoLocalPath"
    }
    # 设置默认远程路径
    if (($RemoteUri -eq "") -or ($RemoteUri -eq $null))
    {
        $RemoteUri = "$AutoRemoteUri"
    }
    # 获取脚本内容
    if (Test-Path "$LocalPath/$FilePath")
    {
        $Content = (New-Object Net.WebClient).DownloadString("$LocalPath/$FilePath")
    }
    else
    {
        $Content = (New-Object Net.WebClient).DownloadString("$RemoteUri/$FilePath")
    }

    return $Content
}

function AutoSource($FilePath, $arguments, $LocalPath, $RemoteUri)
{
    $ScriptContent = AutoContent $FilePath $LocalPath $RemoteUri
    # 执行脚本
    if (($arguments -eq "") -or ($arguments -eq $null))
    {
        Invoke-Command -ScriptBlock ([ScriptBlock]::Create($ScriptContent))
    }
    else
    {
        Invoke-Command -ScriptBlock ([ScriptBlock]::Create($ScriptContent)) -ArgumentList $arguments
    }
}

