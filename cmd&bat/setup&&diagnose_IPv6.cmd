@echo off rem This program is used to Setup&Fix IPv6 For HUST only.
@echo off rem Write by ctsepson@byhh-bbs at 2009-4-25 6:18:33. 
@echo off rem MOD by BluCola@byhh-bbs at 2009-05-03 22:10:34. 
:选择操作系统
@echo off
cls
echo.——————————————————————
echo.此脚本为华中科技大学（HUST）专用版，
echo.其它学校的请查看HUDBT的使用帮助的IPv6配置方法
echo.——————————————————————
echo.
echo.请选择您的操作系统：
echo.(1)Windows XP
echo.(2)Windows Vista或以上
SET /P osver=  请输入 ( ) 中的数字键并按回车:
if /I "%osver%"=="2" (
echo.您正在使用Windows Vista系统，请确定您已使用管理员身份运行该配置脚本
echo.（右键点击本文件，选择“以管理员身份运行”）
echo.按任意键以继续
pause >nul
)
:主菜单
@echo off 
cls
color 0a
echo.┌-----------------------------------------------------------------┐
echo.┆               IPv6安装配置检测工具 (For HUST only)              ┆
echo.├-----------------------------------------------------------------┤
echo.┆  　　　　　　　　　                                             ┆
echo.┆       (1) 查看IPv6状态 (看是否已安装、正确配置)                 ┆
echo.┆   　　　　　　　　　                                            ┆
echo.┆       (2) 安装IPv6 (Vista、Windows 7默认已安装不需再安装)       ┆
echo.┆  　　　　　　　　　                                             ┆
echo.┆       (3) ISATAP隧道方式接入IPv6                                ┆
echo.┆  　　　　　　　　　                                             ┆
echo.┆       (4) 修复因遭受他人RA宣告而无法正常使用IPV6                ┆
echo.┆  　　　　　　　　　                                             ┆
echo.┆  　　 (5) 退出程序                       　　　　　             ┆
echo.┆  　　　　　　　　　                                             ┆
echo.├-----------------------------------------------------------------┤
echo.
SET /P psn=  请输入 ( ) 中的数字键并按回车:
if /I "%psn%"=="1" goto 状态
if /I "%psn%"=="2" goto 安装
if /I "%psn%"=="3" goto 修复
if /I "%psn%"=="4" goto 修复RA宣告
if /I "%psn%"=="5" goto EX

:返回
goto 主菜单

:状态
cls
color 0f
echo.将尝试解析IPV6域名：
ping 6rank.edu.cn -6 -n 1
echo.
echo.若您看到该网址已被解析为：[2001:252:0:2::2000]则说明您的IPV6已正确配置。
pause
echo.以下是您的网络状态：
ipconfig
echo.
echo.*****************************************************************
echo.
echo.【注意】
echo.
echo.1、请检查“IP Address”栏是否有IPv6地址，如果没有，请安装IPv6
echo.   IPv6地址示例：2001:250:4000:8fff:0:5efe
echo.
echo.2、请检查您的IPv6 address的前缀，正常情况下应以2001:250:4000开头
echo.   如果是以2002开头则不能正常使用，请修复；
echo.   修复失败的请参考网站使用帮助部分。
echo.
echo.*****************************************************************
echo.
echo.现在按任意键返回主菜单。
pause >nul
goto 主菜单

:安装
cls
color 0b
echo.正在安装IPv6...
echo.
echo.你知道吗：安装了IPv6，今后就能从网上获取更多好资源。
echo.
echo.[1/3]安装IPv6服务：
if /I "%osver%"=="1" (
sc config 6to4 start=auto
net start 6to4
netsh int ipv6 install
) else (
sc config iphlpsvc start=auto
net start iphlpsvc
)
echo.[2/3]配置IPv6服务：
netsh int ipv6 6to4 set state disabled
echo.[3/3]设置IPv6隧道：
netsh int ipv6 isatap set router isatap.hust.edu.cn
netsh int ipv6 set prefixpolicy 2001::/16 30 1 
netsh int ipv6 set prefixpolicy 2002::/16 1000 1 persistent
netsh int ipv6 isatap set state enabled
echo.安装完成！请按任意键返回主菜单。
pause >nul
goto 主菜单

:修复
cls
color 0d
echo.正在修复IPv6...
echo.
echo.[1/4]我们先断开IPv6隧道连接
netsh interface ipv6 isatap set state disabled
echo.[2/4]然后重设正确的IPv6隧道地址
netsh int ipv6 isatap set router isatap.hust.edu.cn
echo.[3/4]最后我们再次重新启动隧道连接
netsh interface ipv6 isatap set state enabled
echo.[4/4]锁定IPv6防止变成错误地址
netsh int ipv6 6to4 set state disabled
if /I "%osver%"=="1" (
ipconfig /renew
) else (
ipconfig /renew6
)
echo.修复完成！请按任意键返回主菜单。
pause >nul
goto 主菜单

:修复RA宣告
cls
color 0d
echo.正在修复因遭受他人RA宣告而影响...
if /I "%osver%"=="1" (
netsh int ipv6 set prefixpolicy ::1/128 50 0 
netsh int ipv6 set prefixpolicy ::/0 40 1 
netsh int ipv6 set prefixpolicy 2001::/16 30 1 
netsh int ipv6 set prefixpolicy ::/96 20 3 
netsh int ipv6 set prefixpolicy ::ffff:0:0/96 10 4 
netsh int ipv6 set prefixpolicy 3ffe:831f::/32 5 5 
) else (
netsh int ipv6 set prefixpolicy ::1/128 50 0 
netsh int ipv6 add prefixpolicy ::/0 40 1 
netsh int ipv6 add prefixpolicy 2001::/16 30 1 
netsh int ipv6 add prefixpolicy ::/96 20 3 
netsh int ipv6 add prefixpolicy ::ffff:0:0/96 10 4 
netsh int ipv6 add prefixpolicy 3ffe:831f::/32 5 5 
)
echo.修复完成！按任意键修复IPv6。
pause >nul
goto 修复

:EX
exit