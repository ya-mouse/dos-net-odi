@echo off
set RC=0
echo Running %1 %2 %3 %4 %5 %6 %7 %8 %9
%COMSPEC% /C %1 %2 %3 %4 %5 %6 %7 %8 %9>c:\flashlog.sav
:: Save ERRORLEVEL
if errorlevel 1 set RC=1
echo %1 %2 %3 %4 %5 %6 %7 %8 %9 exited with %RC%>>c:\flashlog.sav
tee -c -a c:\flash.log c:\flashlog.sav
del c:\flashlog.sav
:: Restore ERRORLEVEL
aset -e -n x:=%RC% eq 1
set RC=

