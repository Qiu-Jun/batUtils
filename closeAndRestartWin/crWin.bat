CHCP 65001
@echo off

set /p bol=输入1：关机2重启
if %bol% == 1 (
    echo 1
    shutdown -s -t 0
) else if %bol% == 2 (
    echo 2
    shutdown -r -t 0
)

exit