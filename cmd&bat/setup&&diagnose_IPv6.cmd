@echo off rem This program is used to Setup&Fix IPv6 For HUST only.
@echo off rem Write by ctsepson@byhh-bbs at 2009-4-25 6:18:33. 
@echo off rem MOD by BluCola@byhh-bbs at 2009-05-03 22:10:34. 
:ѡ�����ϵͳ
@echo off
cls
echo.��������������������������������������������
echo.�˽ű�Ϊ���пƼ���ѧ��HUST��ר�ð棬
echo.����ѧУ����鿴HUDBT��ʹ�ð�����IPv6���÷���
echo.��������������������������������������������
echo.
echo.��ѡ�����Ĳ���ϵͳ��
echo.(1)Windows XP
echo.(2)Windows Vista������
SET /P osver=  ������ ( ) �е����ּ������س�:
if /I "%osver%"=="2" (
echo.������ʹ��Windows Vistaϵͳ����ȷ������ʹ�ù���Ա������и����ýű�
echo.���Ҽ�������ļ���ѡ���Թ���Ա������С���
echo.��������Լ���
pause >nul
)
:���˵�
@echo off 
cls
color 0a
echo.��-----------------------------------------------------------------��
echo.��               IPv6��װ���ü�⹤�� (For HUST only)              ��
echo.��-----------------------------------------------------------------��
echo.��  ������������������                                             ��
echo.��       (1) �鿴IPv6״̬ (���Ƿ��Ѱ�װ����ȷ����)                 ��
echo.��   ������������������                                            ��
echo.��       (2) ��װIPv6 (Vista��Windows 7Ĭ���Ѱ�װ�����ٰ�װ)       ��
echo.��  ������������������                                             ��
echo.��       (3) ISATAP�����ʽ����IPv6                                ��
echo.��  ������������������                                             ��
echo.��       (4) �޸�����������RA������޷�����ʹ��IPV6                ��
echo.��  ������������������                                             ��
echo.��  ���� (5) �˳�����                       ����������             ��
echo.��  ������������������                                             ��
echo.��-----------------------------------------------------------------��
echo.
SET /P psn=  ������ ( ) �е����ּ������س�:
if /I "%psn%"=="1" goto ״̬
if /I "%psn%"=="2" goto ��װ
if /I "%psn%"=="3" goto �޸�
if /I "%psn%"=="4" goto �޸�RA����
if /I "%psn%"=="5" goto EX

:����
goto ���˵�

:״̬
cls
color 0f
echo.�����Խ���IPV6������
ping 6rank.edu.cn -6 -n 1
echo.
echo.������������ַ�ѱ�����Ϊ��[2001:252:0:2::2000]��˵������IPV6����ȷ���á�
pause
echo.��������������״̬��
ipconfig
echo.
echo.*****************************************************************
echo.
echo.��ע�⡿
echo.
echo.1�����顰IP Address�����Ƿ���IPv6��ַ�����û�У��밲װIPv6
echo.   IPv6��ַʾ����2001:250:4000:8fff:0:5efe
echo.
echo.2����������IPv6 address��ǰ׺�����������Ӧ��2001:250:4000��ͷ
echo.   �������2002��ͷ��������ʹ�ã����޸���
echo.   �޸�ʧ�ܵ���ο���վʹ�ð������֡�
echo.
echo.*****************************************************************
echo.
echo.���ڰ�������������˵���
pause >nul
goto ���˵�

:��װ
cls
color 0b
echo.���ڰ�װIPv6...
echo.
echo.��֪���𣺰�װ��IPv6�������ܴ����ϻ�ȡ�������Դ��
echo.
echo.[1/3]��װIPv6����
if /I "%osver%"=="1" (
sc config 6to4 start=auto
net start 6to4
netsh int ipv6 install
) else (
sc config iphlpsvc start=auto
net start iphlpsvc
)
echo.[2/3]����IPv6����
netsh int ipv6 6to4 set state disabled
echo.[3/3]����IPv6�����
netsh int ipv6 isatap set router isatap.hust.edu.cn
netsh int ipv6 set prefixpolicy 2001::/16 30 1 
netsh int ipv6 set prefixpolicy 2002::/16 1000 1 persistent
netsh int ipv6 isatap set state enabled
echo.��װ��ɣ��밴������������˵���
pause >nul
goto ���˵�

:�޸�
cls
color 0d
echo.�����޸�IPv6...
echo.
echo.[1/4]�����ȶϿ�IPv6�������
netsh interface ipv6 isatap set state disabled
echo.[2/4]Ȼ��������ȷ��IPv6�����ַ
netsh int ipv6 isatap set router isatap.hust.edu.cn
echo.[3/4]��������ٴ����������������
netsh interface ipv6 isatap set state enabled
echo.[4/4]����IPv6��ֹ��ɴ����ַ
netsh int ipv6 6to4 set state disabled
if /I "%osver%"=="1" (
ipconfig /renew
) else (
ipconfig /renew6
)
echo.�޸���ɣ��밴������������˵���
pause >nul
goto ���˵�

:�޸�RA����
cls
color 0d
echo.�����޸�����������RA�����Ӱ��...
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
echo.�޸���ɣ���������޸�IPv6��
pause >nul
goto �޸�

:EX
exit