@echo off
if .%1 == . goto exit
echo Unpacking %BOARD%%1|%L%
htget %BOARD%%1 | tar xv.f -
:exit

