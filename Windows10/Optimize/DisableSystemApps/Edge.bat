@echo off
title 禁用 Edge
cls
color 0A

rem 重启脚本并以管理员运行
%1 start "" mshta vbscript:CreateObject("Shell.Application").^
ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)^
(window.close)&&exit

taskkill /F /IM MicrosoftEdge.exe &
taskkill /F /IM MicrosoftEdgeCP.exe &
move "%windir%\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe" "%windir%\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe.bak"
