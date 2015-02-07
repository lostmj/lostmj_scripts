echo off
:begin
set /A host_name=
set /p host_name=Please input the host name(default:www.google.com):


echo The host is : %host_name%

if %host_name% == 0 ( echo input none and then look www.google.com && set host_name="www.google.com" ) else (echo The host is : %host_name%)
rem pause>null
echo ...............................................................................
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo This cmd is looking for ipv6 NS server
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
nslookup %host_name% 2001:470:20::2

echo ...............................................................................
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo This cmd is looking for ipv4 NS server
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
nslookup %host_name% 202.120.224.6

rem 从begin标签出，再次运行
::goto begin
pause