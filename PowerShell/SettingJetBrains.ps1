###############
# Name: ≈‰÷√ JetBrains
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use: PowerShell iex(New-Object Net.WebClient).DownloadString('http://dwz.cn/DK8BgkHx')
###############

if (($env:IdeaConfigFilePath -eq "") -or ($env:IdeaConfigFilePath -eq $null))
{
    Write-Warning -Message "var <IdeaConfigFilePath> undefined."
    exit
}

if (($env:IdeaConfigDirPath -eq "") -or ($env:IdeaConfigDirPath -eq $null))
{
    Write-Warning -Message "var <IdeaConfigDirPath> undefined."
    exit
}

if (-Not(Test-Path $env:IdeaConfigFilePath))
{
    Write-Warning -Message "var <IdeaConfigFilePath> does not exist, Please check: $env:IdeaConfigFilePath"
    exit
}

if (-Not(Test-Path $env:IdeaConfigDirPath))
{
    Write-Warning -Message "var <IdeaConfigDirPath> does not exist, Please check: $env:IdeaConfigDirPath"
    exit
}

$Content = Get-Content -Path $env:IdeaConfigFilePath
$Content = $Content -replace "# idea.config.path", "idea.config.path"
$Content = $Content -replace "# idea.system.path", "idea.system.path"
$Content = $Content -replace "# idea.plugins.path", "idea.plugins.path"
$Content = $Content -replace "# idea.log.path", "idea.log.path"

$Content = $Content -replace "idea.config.path=(.*)", "idea.config.path=$env:IdeaConfigDirPath/config"
$Content = $Content -replace "idea.system.path=(.*)", "idea.system.path=$env:IdeaConfigDirPath/system"

$Content | Out-File $env:IdeaConfigFilePath -encoding ASCII
