@echo off
color 0a
title �Զ���дIP
echo.
echo		------------------ѡ��IP��ַ------------------------
echo		1.����ʹ�õ�IP��ַ 
echo		2.ͼ���ʹ�õ�IP��ַ
echo		3.4¥IP��ַ
echo		4.��������
echo		5.ping 192.168.0.1
echo		6.ping www.baidu.com

echo		----------------------------------------------------
echo.
:again
set /p input=������Ҫ���õ�IP��ַ���ͣ�
if "%input%"=="1" (

netsh interface ip set address �������� static 10.130.103.173 255.255.255.0 10.130.103.1 1 >nul
echo.
echo ��������DNS����
netsh interface ip set dns �������� static 110.85.11.99 primary
netsh interface ip add dns �������� 110.85.11.98 index=2
netsh interface  
echo �ɹ���������ַ����Ϊ������·ʹ�õ�IP��ַ
pause
goto end
)


if "%input%"=="2" (

netsh interface ip set address �������� static 10.140.20.25 255.255.255.0 10.140.20.1 1 >nul
echo.
echo �ɹ���������ַ����Ϊ������·ʹ�õ�IP��ַ
pause
goto end
)

if "%input%"=="3" (

netsh interface ip set address �������� static 192.168.60.206 255.255.255.0 192.168.60.1 1 >nul
echo.
echo �ɹ���������ַ����Ϊ������·ʹ�õ�IP��ַ
pause
goto end
)

if "%input%"=="4" (

netsh interface ip set address �������� static 192.168.61.13 255.255.255.0 192.168.61.1 1 >nul
echo.
echo �ɹ���������ַ����Ϊ������·ʹ�õ�IP��ַ
pause
goto end
)


if "%input%"=="5" (
ping 192.168.0.1
echo.
echo �ɹ���������ַ����Ϊ������·ʹ�õ�IP��ַ
pause
goto end
)

if "%input%"=="6" (
ping www.baidu.com
echo.
echo �ɹ���������ַ����Ϊ������·ʹ�õ�IP��ַ
pause
goto end
)


pause >nul
ping  www.baidu.com
goto again
:end
