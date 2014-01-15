@echo off
if not .%1 == . goto params
sed -n -f a:\utils\cdate.sed
goto exit
:params
echo %1 | sed -n -f a:\utils\cdate.sed
:exit
