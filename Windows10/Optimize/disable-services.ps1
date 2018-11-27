###############
# Name: 禁用服务
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
###############

$Services = @(
@{
    Name = "diagnosticshub.standardcollector.service";
    DisplayName = "Microsoft (R) 诊断中心标准收集器服务";
    Intro = "建议禁用，诊断中心标准收集器服务";
}
@{
    Name = "DiagTrack";
    DisplayName = "Connected User Experiences and Telemetry";
    Intro = "建议禁用，用于改进 Windows 平台的体验和质量";
}
@{
    Name = "dmwappushservice";
    DisplayName = "dmwappushsvc";
    Intro = "建议禁用，WAP 推消息路由服务";
}
@{
    Name = "lfsvc";
    DisplayName = "Geolocation Service";
    Intro = "按需禁用，用于获取当然位置信息的服务，禁用将无法定位等";
}
@{
    Name = "MapsBroker";
    DisplayName = "Downloaded Maps Manager";
    Intro = "按需禁用，供应用程序访问已下载地图的服务，禁用应用程序将无法访问地图";
}
@{
    Name = "NetTcpPortSharing";
    DisplayName = "Net.Tcp Port Sharing Service";
    Intro = "建议禁用，提供通过 net.tcp 协议共享 TCP 端口的功能";
}
@{
    Name = "RemoteAccess";
    DisplayName = "Routing and Remote Access";
    Intro = "建议禁用，在局域网以及广域网环境中为企业提供路由服务";
}
@{
    Name = "RemoteRegistry";
    DisplayName = "Remote Registry";
    Intro = "建议禁用，允许远程修改注册表";
}
@{
    Name = "SharedAccess";
    DisplayName = "Internet Connection Sharing (ICS)";
    Intro = "建议禁用，为家庭和小型办公网络提供网络地址转换、寻址、名称解析和/或入侵保护服务";
}
@{
    Name = "TrkWks";
    DisplayName = "Distributed Link Tracking Client";
    Intro = "建议禁用，维护某个计算机内或某个网络中的计算机的 NTFS 文件之间的链接";
}
@{
    Name = "WbioSrvc";
    DisplayName = "Windows Biometric Service";
    Intro = "按需禁用，生物识别服务";
}
@{
    Name = "WlanSvc";
    DisplayName = "WLAN AutoConfig";
    Intro = "按需禁用，有无线网卡建议开启";
}
@{
    Name = "WMPNetworkSvc";
    DisplayName = "Windows Media Player Network Sharing Service";
    Intro = "按需禁用，即插即用设备与其他网络播放机和媒体设备共享媒体库";
}
@{
    Name = "WSearch";
    DisplayName = "Windows Search";
    Intro = "按需禁用，为文件、电子邮件和其他内容提供内容索引、属性缓存和搜索结果";
}
@{
    Name = "XblAuthManager";
    DisplayName = "Xbox Live 身份验证管理器";
    Intro = "建议禁用";
}
@{
    Name = "XblGameSave";
    DisplayName = "Xbox Live 游戏保存";
    Intro = "建议禁用";
}
@{
    Name = "XboxNetApiSvc";
    DisplayName = "Xbox Live 网络服务";
    Intro = "建议禁用";
}
@{
    Name = "DusmSvc";
    DisplayName = "数据使用量";
    Intro = "建议禁用";
}
@{
    Name = "vmms";
    DisplayName = "Hyper-V 虚拟机管理";
    Intro = "建议禁用";
}
@{
    Name = "CDPSvc";
    DisplayName = "连接设备平台服务";
    Intro = "建议禁用";
}
)

foreach ($Service in $Services)
{
    $reply = Read-Host "是否禁用 - $( $Service.DisplayName ) --- $( $Service.Intro ) [Y/n]"
    if ($reply -match "[yY]")
    {
        Get-Service -Name $Service.Name | Set-Service -StartupType Disabled
    }
    else
    {
        Write-Warning -Message "跳过了 $( $Service.DisplayName ) 服务"
    }
}
