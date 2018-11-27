@echo off
title 禁用 PeopleExperienceHost
cls
color 0A

rem 重启脚本并以管理员运行
%1 start "" mshta vbscript:CreateObject("Shell.Application").^
ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)^
(window.close)&&exit

taskkill /F /IM PeopleExperienceHost.exe &
move "%windir%\SystemApps\Microsoft.Windows.PeopleExperienceHost_cw5n1h2txyewy" "%windir%\SystemApps\Microsoft.Windows.PeopleExperienceHost_cw5n1h2txyewy.bak"

Pause
