###############
# Name: Remove Apps
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use: PowerShell iex(New-Object Net.WebClient).DownloadString('http://dwz.cn/F8vHK45i')
###############

$reply = Read-Host "是否移除所有应用 [Y/n]"
if ($reply -match "[yY]")
{
    # get path permission
    takeown /f %ProgramFiles%\WindowsApps /a /r /d Y
    # get app permission
    icacls %ProgramFiles%\WindowsApps /grant "ALL APPLICATION PACKAGES:(OI)(CI)F" /t /q
    # delete all app
    Get-AppXProvisionedPackage -online | Remove-AppxProvisionedPackage -online 2>&1 | Out-Null
    Get-AppxPackage -AllUsers | Remove-AppxPackage 2>&1 | Out-Null
    exit 0
}

$Apps = @(
@{
    Name = "3dbuilder";
    DisplayName = "3D Builder";
}
@{
    Name = "officehub";
    DisplayName = "Office";
}
@{
    Name = "skypeapp";
    DisplayName = "Skype";
}
@{
    Name = "zunemusic";
    DisplayName = "Zune音乐";
}
@{
    Name = "solitairecollection";
    DisplayName = "微软纸牌";
}
@{
    Name = "zunevideo";
    DisplayName = "Zune视频";
}
@{
    Name = "bingfinance";
    DisplayName = "必应金融";
}
@{
    Name = "bingnews";
    DisplayName = "必应新闻";
}
@{
    Name = "onenote";
    DisplayName = "OneNote";
}
@{
    Name = "bingsports";
    DisplayName = "必应体育";
}
@{
    Name = "xboxapp";
    DisplayName = "Xbox";
}
@{
    Name = "Print3D";
    DisplayName = "Print 3D";
}
@{
    Name = "game";
    DisplayName = "游戏";
}
@{
    Name = "MarchofEmpires";
    DisplayName = "帝国霸略";
}
@{
    Name = "BubbleWitch3Saga";
    DisplayName = "泡泡魔女传奇";
}
)

foreach ($App in $Apps)
{
    $reply = Read-Host "是否禁用 - $( $App.DisplayName ) [Y/n]"
    if ($reply -match "[yY]")
    {
        Get-AppxPackage *$App.Name * | Remove-AppxPackage
    }
    else
    {
        Write-Warning -Message "跳过了 $( $Service.DisplayName ) 应用"
    }
}
