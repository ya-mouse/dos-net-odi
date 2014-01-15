@echo off
set L=tee -a c:\flash.log
set PATH=a:\utils;a:\net;a:\vc
set EXCELAN=a:\net
rdisk /S15 /:C

smbiosd /T=0 | sed -n "s,^BIOS Version:[ ]+\(.+\),BIOS=\1,p"   | sed "s, ,_,g" | aset -f
smbiosd /T=1 | sed -n "s,^Product Name:[ ]+\(.+\),BOARD1=\1,p" | sed "s, ,_,g" | aset -f
smbiosd /T=2 | sed -n "s,^Product Name:[ ]+\(.+\),BOARD2=\1,p" | sed "s, ,_,g" | aset -f
smbiosd /T=0 | sed -n "s,^BIOS Release Date:[ ]+\([0-9/]+\).*,BDATE='\1',p"   | %COMSPEC% /C cdate.bat | aset -f

echo BIOS: %BIOS% Date: %BDATE%|%L%
echo BOARD: %BOARD1% / %BOARD2%|%L%
pciscan -x -v a:\utils\ndis.map|%L%
call net start
if errorlevel 1 goto error

c:\
goto exit

:error
echo.
echo FATAL: Could not start the Network!!!|%L%
echo.
goto exit

:exit

