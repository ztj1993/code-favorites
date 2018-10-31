@echo off
title 禁用 ShellExperienceHost
cls
color 0A

rem 重启脚本并以管理员运行
%1 start "" mshta vbscript:CreateObject("Shell.Application").^
ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)^
(window.close)&&exit

taskkill /F /IM ShellExperienceHost.exe &
move "%windir%\SystemApps\ShellExperienceHost_cw5n1h2txyewy" "%windir%\SystemApps\ShellExperienceHost_cw5n1h2txyewy.bak"
