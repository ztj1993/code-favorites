###############
# Name: ≈‰÷√ JetBrains
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use: PowerShell iex(New-Object Net.WebClient).DownloadString('http://dwz.cn/DK8BgkHx')
###############

if (($env:IdeaConfigFilePath -eq "") -or ($env:IdeaConfigFilePath -eq $null))
{
    Write-Warning -Message "var <IdeaConfigFilePath> undefined."
    return 1
}

if (($env:IdeaConfigDirPath -eq "") -or ($env:IdeaConfigDirPath -eq $null))
{
    Write-Warning -Message "var <IdeaConfigDirPath> undefined."
    return 1
}

if (-Not(Test-Path $IdeaConfigFilePath))
{
    Write-Warning -Message "var <IdeaConfigFilePath> does not exist, Please check: $IdeaConfigFilePath"
    return 1
}

if (-Not(Test-Path "$IdeaConfigDirPath"))
{
    Write-Warning -Message "var <IdeaConfigDirPath> does not exist, Please check: $IdeaConfigDirPath"
    return 1
}

$Content = Get-Content -Path $IdeaConfigFilePath
$Content = $Content -replace "# idea.config.path", "idea.config.path"
$Content = $Content -replace "# idea.system.path", "idea.system.path"
$Content = $Content -replace "# idea.plugins.path", "idea.plugins.path"
$Content = $Content -replace "# idea.log.path", "idea.log.path"

$Content = $Content -replace "idea.config.path=(.*)", "idea.config.path=$env:IdeaConfigDirPath/config"
$Content = $Content -replace "idea.system.path=(.*)", "idea.system.path=$env:IdeaConfigDirPath/system"

$Content | Out-File $IdeaConfigFilePath -encoding ASCII
