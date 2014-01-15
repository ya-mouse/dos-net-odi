@echo off
if .%1 == . goto exit
echo Downloading %BOARD%/%1|%L%
htget %BOARD%/%1 | gzip -d -c >%1
:exit

