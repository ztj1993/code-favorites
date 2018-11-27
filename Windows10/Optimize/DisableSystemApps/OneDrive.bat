@echo off
title 删除 OneDrive
cls
color 0A

rem 重启脚本并以管理员运行
%1 start "" mshta vbscript:CreateObject("Shell.Application").^
ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)^
(window.close)&&exit

::提示用户操作
echo.
echo 即将删除OneDrive，是否继续？
echo.
echo 是：请按任意键继续。
echo 否：点击右上角，关闭本窗口。
echo.
echo 如有安全软件弹出拦截提示，放行即可。
pause

:: 结束进程 (不结束无法删除文件)
taskkill /f /im OneDrive.exe
taskkill /f /im explorer.exe

:: 调用卸载功能
if exist %SYSTEMROOT%\SysWOW64\OneDriveSetup.exe (
    %SYSTEMROOT%\SysWOW64\OneDriveSetup.exe /uninstall
) else (
    %SYSTEMROOT%\System32\OneDriveSetup.exe /uninstall
)

:: 删除本地文件
rd  /s /q "%USERPROFILE%\OneDrive"
rd  /s /q "%LOCALAPPDATA%\Microsoft\OneDrive"
rd  /s /q "%PROGRAMDATA%\Microsoft OneDrive"

:: 移除侧边栏 OneDrive 图标
reg delete "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f
reg delete "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f

:: 重启 explorer
start explorer

Pause
