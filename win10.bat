chcp 65001

@echo off
setlocal enabledelayedexpansion
rem 磁盘清理
echo 磁盘清理开始.
rem 添加所有磁盘清理项
echo 添加所有磁盘清理项开始.
rem 添加清理Temporary Setup Files
echo 添加清理Temporary Setup Files.
start /wait reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Active Setup Temp Folders" /v StateFlags0099 /t reg_dword /d 2 /f
rem 添加清理DirectX着色器缓存
echo 添加清理DirectX着色器缓存.
start /wait reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\D3D Shader Cache" /v StateFlags0099 /t reg_dword /d 2 /f
rem 添加清理传递优化文件
echo 添加清理传递优化文件.
start /wait reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Delivery Optimization Files" /v StateFlags0099 /t reg_dword /d 2 /f
rem 添加清理诊断数据查看器数据库文件
echo 添加清理诊断数据查看器数据库文件.
start /wait reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Diagnostic Data Viewer database files" /v StateFlags0099 /t reg_dword /d 2 /f
rem 添加清理已下载的程序文件
echo 添加清理已下载的程序文件.
start /wait reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Downloaded Program Files" /v StateFlags0099 /t reg_dword /d 2 /f
rem 添加清理Internet临时文件
start /wait reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Internet Cache Files" /v StateFlags0099 /t reg_dword /d 2 /f
rem 添加清理语言资源文件
echo 添加清理语言资源文件.
start /wait reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Language Pack" /v StateFlags0099 /t reg_dword /d 2 /f
rem 添加清理旧的Chkdsk文件
echo 添加清理旧的Chkdsk文件.
start /wait reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Old ChkDsk Files" /v StateFlags0099 /t reg_dword /d 2 /f
rem 添加清理回收站
echo 添加清理回收站.
start /wait reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Recycle Bin" /v StateFlags0099 /t reg_dword /d 2 /f
rem 添加清理RetailDemo Offline Content
echo 添加清理RetailDemo Offline Content.
start /wait reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\RetailDemo Offline Content" /v StateFlags0099 /t reg_dword /d 2 /f
rem 添加清理设置日志文件
echo 添加清理设置日志文件.
start /wait reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Setup Log Files" /v StateFlags0099 /t reg_dword /d 2 /f
rem 添加清理系统错误内存转储文件
echo 添加清理系统错误内存转储文件.
start /wait reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\System error memory dump files" /v StateFlags0099 /t reg_dword /d 2 /f
rem 添加清理系统错误小型转储文件
echo 添加清理系统错误小型转储文件.
start /wait reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\System error minidump files" /v StateFlags0099 /t reg_dword /d 2 /f
rem 添加清理临时文件
echo 添加清理临时文件.
start /wait reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Temporary Files" /v StateFlags0099 /t reg_dword /d 2 /f
rem 添加清理缩略图
echo 添加清理缩略图.
start /wait reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Thumbnail Cache" /v StateFlags0099 /t reg_dword /d 2 /f
rem 添加清理Windows更新清理
echo 添加清理Windows更新清理.
start /wait reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Update Cleanup" /v StateFlags0099 /t reg_dword /d 2 /f
rem 添加清理用户文件历史记录
echo 添加清理用户文件历史记录.
start /wait reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\User file versions" /v StateFlags0099 /t reg_dword /d 2 /f
rem 添加清理Microsoft Defender防病毒
echo 添加清理Microsoft Defender防病毒.
start /wait reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Defender" /v StateFlags0099 /t reg_dword /d 2 /f
rem 添加清理Windows错误报告和反馈诊断
echo 添加清理Windows错误报告和反馈诊断.
start /wait reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Error Reporting Files" /v StateFlags0099 /t reg_dword /d 2 /f
rem 添加所有磁盘清理项结束
echo 添加所有磁盘清理项结束. 
rem 清理所有驱动器
start /wait cleanmgr /sagerun:99
echo 清理所有驱动器结束.
rem 获取驱动器并磁盘整理
echo list volume>%temp%\vl.vbs
for /f "tokens=1,2,3,4* delims= " %%a in ('diskpart /s %temp%\vl.vbs^|findstr "磁盘分区"^|findstr /v "系统保留"') do (
set driver=%%c
echo 整理!driver!盘开始.
start /wait /b chkdsk /scan /forceofflinefix !driver!:
echo 整理!driver!盘结束.
)
rem 查询非系统盘的最大可用空间驱动器
echo 查询非系统盘的最大可用空间驱动器开始.
set maxSize=
set maxVol=
set maxUnit=
set winVol=!windir:~0,1!
for /f "tokens=1,2,3,4* delims= " %%a in ('diskpart /s %temp%\vl.vbs^|findstr "磁盘分区"^|findstr /v "系统保留"') do (
if not "%%c" equ "!winVol!" (  
echo select volume %%c>%temp%\v3.vbs 
echo detail volume>>%temp%\v3.vbs
for /f "tokens=1,2* delims=:" %%x in ('diskpart /s %temp%\v3.vbs^|findstr "卷可用空间"') do (
set temp=%%y
set leftSize=!temp:~2,-2!
set maxUnit=!temp:~-2!
if "!maxSize!" equ "" (
set maxSize=!leftSize!
set maxVol=%%c
) else (
if "!maxSize!" lss "!leftSize!" (
set maxSize=!leftSize!
set maxVol=%%c
)
)
)
)
)
echo 非系统盘最大可用空间!maxSize!,单位!maxUnit!,虚拟内存要设置的驱动器!maxVol!.
echo 查询非系统盘的最大可用空间驱动器结束.
rem 设置虚拟内存
echo 设置!maxVol!盘由系统管理的虚拟内存
reg add "HKLM\System\CurrentControlSet\Control\Session Manager\Memory Management" /v PagingFiles /t REG_MULTI_SZ /d "!maxVol!:\pagefile.sys 0 0" /f
echo 优化结束.
pause