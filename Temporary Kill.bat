@echo Off
NET STOP CscService /Y 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\CscService" /v "Start" /t REG_DWORD /d "4" /f
NET STOP Ctes Manager /Y
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\Ctes Manager" /v "Start" /t REG_DWORD /d "4" /f
NET STOP CtesHostSvc /Y
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\CtesHostSvc" /v "Start" /t REG_DWORD /d "4" /f
NET STOP rpchdp /Y
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\rpchdp" /v "Start" /t REG_DWORD /d "4" /f
NET STOP rpcnet /Y
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\rpcnet" /v "Start" /t REG_DWORD /d "4" /f
NET STOP rpcnetp /Y
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\rpcnetp" /v "Start" /t REG_DWORD /d "4" /f
taskkill /f /im rpcnet.exe /t
taskkill /f /im rpcnetp.exe /t
taskkill /f /im Upgrd.exe /t
taskkill /f /im instw64.exe /t
DEL /F /Q /A C:\Windows\SysWOW64\cshost.dll
DEL /F /Q /A C:\Windows\SysWOW64\CTLojack.dll
DEL /F /Q /A C:\Windows\SysWOW64\DIAGDLL64.DLL
DEL /F /Q /A C:\Windows\SysWOW64\identprv.dll
DEL /F /Q /A C:\Windows\SysWOW64\pkgmgr.dll
DEL /F /Q /A C:\Windows\SysWOW64\pcnet.dll
DEL /F /Q /A C:\Windows\SysWOW64\wceprv.dll
DEL /F /Q /A C:\Windows\SysWOW64\instw64.exe
DEL /F /Q /A C:\Windows\SysWOW64\pkgslv.exe
DEL /F /Q /A C:\Windows\SysWOW64\rpcnet.exe
DEL /F /Q /A C:\Windows\SysWOW64\rpcnetp.exe
DEL /F /Q /A C:\Windows\SysWOW64\Upgrd.exe
DEL /F /Q /A C:\Windows\System32\cshost.dll
DEL /F /Q /A C:\Windows\System32\CTLojack.dll
DEL /F /Q /A C:\Windows\System32\DIAGDLL64.DLL
DEL /F /Q /A C:\Windows\System32\identprv.dll
DEL /F /Q /A C:\Windows\System32\pkgmgr.dll
DEL /F /Q /A C:\Windows\System32\pcnet.dll
DEL /F /Q /A C:\Windows\System32\wceprv.dll
DEL /F /Q /A C:\Windows\System32\instw64.exe
DEL /F /Q /A C:\Windows\System32\pkgslv.exe
DEL /F /Q /A C:\Windows\System32\rpcnet.exe
DEL /F /Q /A C:\Windows\System32\rpcnetp.exe
DEL /F /Q /A C:\Windows\System32\Upgrd.exe
RD /S /Q C:\ProgramData\CTES
RD /S /Q C:\ProgramData\Rpcnet
PAUSE