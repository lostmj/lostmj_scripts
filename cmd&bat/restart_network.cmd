rem 禁用网卡
netsh interface set interface name="本地连接" admin=DISABLED
rem 启用网卡
netsh interface set interface name="本地连接" admin=ENABLED