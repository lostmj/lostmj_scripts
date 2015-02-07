@echo off
color 0a
title 自动填写IP
echo.
echo		------------------选择IP地址------------------------
echo		1.宿舍使用的IP地址 
echo		2.图书馆使用的IP地址
echo		3.4楼IP地址
echo		4.有线上网
echo		5.ping 192.168.0.1
echo		6.ping www.baidu.com

echo		----------------------------------------------------
echo.
:again
set /p input=请输入要设置的IP地址类型：
if "%input%"=="1" (

netsh interface ip set address 本地连接 static 10.130.103.173 255.255.255.0 10.130.103.1 1 >nul
echo.
echo 正在设置DNS……
netsh interface ip set dns 本地连接 static 110.85.11.99 primary
netsh interface ip add dns 本地连接 110.85.11.98 index=2
netsh interface  
echo 成功将网卡地址设置为宿舍网路使用的IP地址
pause
goto end
)


if "%input%"=="2" (

netsh interface ip set address 本地连接 static 10.140.20.25 255.255.255.0 10.140.20.1 1 >nul
echo.
echo 成功将网卡地址设置为基地网路使用的IP地址
pause
goto end
)

if "%input%"=="3" (

netsh interface ip set address 本地连接 static 192.168.60.206 255.255.255.0 192.168.60.1 1 >nul
echo.
echo 成功将网卡地址设置为宿舍网路使用的IP地址
pause
goto end
)

if "%input%"=="4" (

netsh interface ip set address 本地连接 static 192.168.61.13 255.255.255.0 192.168.61.1 1 >nul
echo.
echo 成功将网卡地址设置为基地网路使用的IP地址
pause
goto end
)


if "%input%"=="5" (
ping 192.168.0.1
echo.
echo 成功将网卡地址设置为基地网路使用的IP地址
pause
goto end
)

if "%input%"=="6" (
ping www.baidu.com
echo.
echo 成功将网卡地址设置为基地网路使用的IP地址
pause
goto end
)


pause >nul
ping  www.baidu.com
goto again
:end
