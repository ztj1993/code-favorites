###############
# Name: ´´½¨²Ëµ¥
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use: PowerShell iex(New-Object Net.WebClient).DownloadString('https://dwz.cn/fVBAsA9x')
###############

if (($env:MenuFilePath -eq "") -or ($env:MenuFilePath -eq $null))
{
    Write-Warning -Message "var <MenuFilePath> undefined."
    exit
}

if (($env:MenuTargetPath -eq "") -or ($env:MenuTargetPath -eq $null))
{
    Write-Warning -Message "var <MenuTargetPath> undefined."
    exit
}

$WScriptShell = New-Object -COM WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($env:MenuFilePath)
$Shortcut.TargetPath = $env:MenuTargetPath

if (("$env:MenuIconLocation" -ne "") -and ($env:MenuIconLocation -ne $null))
{
    $Shortcut.IconLocation = $env:MenuIconLocation
}
if (("$env:MenuArguments" -ne "") -and ($env:MenuArguments -ne $null))
{
    $Shortcut.Arguments = $env:MenuArguments
}
if (("$env:MenuWorkingDirectory" -ne "") -and ($env:MenuWorkingDirectory -ne $null))
{
    $Shortcut.WorkingDirectory = $env:MenuWorkingDirectory
}

$Shortcut.Save()
