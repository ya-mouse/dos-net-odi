@echo off
a:\

:: Options
if .%1 == .         goto help
if .%1 == .help     goto help
if .%1 == .stop     goto stop
if .%1 == .start    goto start
if .%1 == .Save     goto save
if exist c:\net\eth.bat goto done

:: Internal Calls
if .%1 == .LSL      goto lsl
if .%1 == .Loop     goto Loop
if .%1 == .Driver   goto Driver
if .%1 == .Protocol goto Protocol
goto exit

:init
set ii=0
call logme %0 LSL
md c:\net
for %%e in (%PCI0% %PCI1% %PCI2% %PCI3% %PCI4% %PCI5%) do call logme %0 Loop %%e
goto cleanup

:start
if not exist c:\net\eth.bat goto init
mem /c | xgrep -l TCPIP >nul
if errorlevel 0 goto exit
call c:\net\eth.bat
del  c:\net\eth.bat
set ii=0
call logme %0 LSL
for %%e in (%PCI0% %PCI1% %PCI2% %PCI3% %PCI4% %PCI5%) do call %0 Loop %%e load
goto cleanup

:Loop
aset ii=%ii%+1
echo Link Support>a:\net.cfg
echo   Max Boards 12>>a:\net.cfg
echo   mempool 8192>>a:\net.cfg
echo   buffers 8 2048>>a:\net.cfg
echo.>>a:\net.cfg

set i=0
set ETH=%2
for %%e in (%PCI0% %PCI1% %PCI2% %PCI3% %PCI4% %PCI5%) do call %0 Driver %%e

echo Protocol TCPIP>>a:\net.cfg
echo   PATH A:\NET\TCP>>a:\net.cfg

set i=0
for %%e in (%PCI0% %PCI1% %PCI2% %PCI3% %PCI4% %PCI5%) do call %0 Protocol %%e

echo.
if exist c:\net\%ETH%.com goto load
echo Unpacking %ETH% driver
cd c:\net
c:\
tar xv.f a:\net\drv.tgz %ETH%.COM
if errorlevel 1 goto exit
cd c:\
a:\

:load
echo Loading %ETH% driver for ETH%ii%
c:\net\%ETH%.com
if errorlevel 1 goto exit

if .%3 == .load if .%ii% == .%iisave% goto tcpip
call %0 Save

:: eliminate file creation
if not exist c:\net\%ETH%.bat goto setboard
:loadboard
call c:\net\%ETH%.bat
aset nboard=%nboard%+1
echo @set nboard=%nboard%>c:\net\%ETH%.bat
goto tcpip

:setboard
echo @set nboard=1>c:\net\%ETH%.bat
goto loadboard

:tcpip
xgrep -h bind net.cfg
tcpip
:: WRND: for lazy Huawei switch
if errorlevel 1 goto retry

:ping
ping 192.168.1.1
if errorlevel 1 goto unload
goto done

:retry
choice /T:Y,20 Retry... >NUL
if errorlevel 2 goto exit1
tcpip
if errorlevel 1 goto exit1
goto ping

:unload
tcpip u
goto exit1

:lsl
echo Link Support>a:\net.cfg
echo   Max Boards 12>>a:\net.cfg
echo   mempool 8192>>a:\net.cfg
echo   buffers 8 2048>>a:\net.cfg

lsl
:: FIXME: check for errorlevel
goto exit

:Driver
aset i=%i%+1
echo Link Driver %ETH%>>a:\net.cfg
echo   Frame Ethernet_802.2>>a:\net.cfg
echo   Frame Ethernet_II>>a:\net.cfg
echo.>>a:\net.cfg
goto exit

:Protocol
aset i=%i%+1
set nboard=1
if exist c:\net\%ETH%.bat call c:\net\%ETH%.bat
if not %ii% == %i% goto exit
echo   bind %ETH% #%nboard% ETHERNET_II ETH%ii%>>a:\net.cfg
goto exit

:save
echo @set iisave=%ii%>c:\net\eth.bat
goto exit

:cleanup
if .%ii% == . goto exit
if exist c:\net\eth.bat call c:\net\eth.bat
del c:\net\*.bat
if not .%iisave% == . call %0 Save
set ii=
set iisave=
goto done

:stop
mem /c | xgrep -l TCPIP >nul
if errorlevel 1 goto exit
tcpip u|%L%
for %%e in (%PCI5% %PCI4% %PCI3% %PCI2% %PCI1% %PCI0%) do if exist c:\net\%%e.com c:\net\%%e.com u|%L%
lsl u|%L%
goto exit

:help
echo Network script to bootup network using Nowell TCP/IP stack over ODI drivers.
echo Usage: net [commands]
echo.
echo Commands:
echo    start     configure NIC if any, start network
echo    stop      unload all previously loaded drivers
echo    help      this help screen
echo.
echo Please report bugs & requests to Anton D. Kachalov %[ASCII 60]%Lmouse@yandex-team.ru%[ASCII 62]%
goto exit

:done
set done=0
if exist c:\net\eth.bat set done=1
echo DONE! %done%|%L%
aset -e -n x:=%done% eq 0
set done=
goto exit

:exit1
del c:\net\eth.bat

:exit

