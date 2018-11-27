###############
# Name: 移除应用
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
###############

$reply = Read-Host "是否移除所有应用 [Y/n]"
if ($reply -match "[yY]")
{
    # 获取所有权
    takeown /f %ProgramFiles%\WindowsApps /a /r /d Y
    # 获取应用所有权
    icacls %ProgramFiles%\WindowsApps /grant "ALL APPLICATION PACKAGES:(OI)(CI)F" /t /q
    # 删除所有应用
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
    DisplayName = "";
}
@{
    Name = "solitairecollection";
    DisplayName = "";
}
@{
    Name = "zunevideo";
    DisplayName = "";
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
