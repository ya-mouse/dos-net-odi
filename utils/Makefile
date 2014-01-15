UTILS=tcp1607.exe \
	tcp16.exe \
	nwlwp50.zip \
	drivers-2010-06-16.zip \
	ters151f.zip \
	tar320g.zip \
	gzip124.zip \
	sed15x.zip \
	smbiosd.zip \
	pciscan110.zip \
	shut12.zip \
	vc405sw.zip \
	choice.com \
	xgrp103x.zip \
	rutils40.zip \
	

all: $(UTILS) ../.msvc-stamp ../.lwp-stamp

../.msvc-stamp: msvc-1.52c.tar.bz2
	./unpack msvc $^
	@touch $@

../.lwp-stamp: novell-lwpdost-devel-2004.10.06-1.zip
	./unpack lwp $^
	@touch $@

boot622.exe:
	wget -c -O $@ http://boot.oldos.net/boot622.exe

tcp1607.exe:
	wget -c -O $@ ftp://ftp.oldskool.org/pub/misc/DESQ/tcp1607.exe

tcp16.exe:
	wget -c -O $@ ftp://ftp.oldskool.org/pub/misc/DESQ/tcp16.exe

drivers-2010-06-16.zip:
	wget -c -O $@ http://de.rpmfind.net/pub/mirror/freedos/files/util/system/udma+drivers/drivers-2010-06-16.zip

ters151f.zip:
	wget -c -O $@ http://www.oldskool.org/guides/texteditors/ters151f.zip

tar320g.zip:
	wget -c -O $@ ftp://garbo.uwasa.fi/pc/unix/tar320g.zip

gzip124.zip:
	wget -c -O $@ ftp://garbo.uwasa.fi/pc/unix/gzip124.zip

sed15x.zip:
	wget -c -O $@ ftp://garbo.uwasa.fi/pc/unix/sed15x.zip

smbiosd.zip:
	wget -c -O $@ ftp://ftp.sudleyplace.com/sudleyplace/smbiosd.zip

pciscan110.zip:
	wget -c -O $@ ftp://dl.xs4all.nl/pub/mirror/nu2files/pciscan110.zip

shut12.zip:
	wget -c -O $@ http://www.opus.co.tt/dave/shut12.zip

vc405sw.zip:
	wget -c -O $@ http://vc.kiev.ua/download/vc405sw.zip

choice.com:
	wget -c -O $@ http://white55.narod.ru/soft/choice.com

xgrp103x.zip:
	wget -c -O $@ http://www.ibiblio.org/pub/micro/pc-stuff/freedos/files/util/file/xgrep/xgrp103x.zip

rutils40.zip:
	wget -c -O $@ http://www.softdoc.de/rickie/body/eng/download/rutils40.zip

nwlwp50.zip:
	@echo Please manually download nwlwp50.zip file from:
	@echo
	@echo "    http://ifolder.ru/18574826"
	@echo
	@false

msvc-1.52c.tar.bz2:
	@echo Please manually download MSVC++ 1.52c files from:
	@echo
	@echo "    http://letitbit.net/download/1027015/3549.3d4077e0d769920769c1b20c1c/Visual_C_1_200.part1.rar.html"
	@echo "    http://letitbit.net/download/1027015/3612.3082c74ada867f241d6e3457c0/Visual_C_1_200.part2.rar.html"
	@echo "    http://letitbit.net/download/1027015/2945.2871a26a4ff3858a82fd2a1233/Visual_C_1_200.part3.rar.html"
	@echo
	@false

novell-lwpdost-devel-2004.10.06-1.zip:
	@echo Please manually download novell-lwpdost-devel-2004.10.06-1.zip file from:
	@echo
	@echo "    http://ifolder.ru/18101515"
	@echo
	@false

clean:
	@rm -f ../.msvc-stamp ../.lwp-stamp

distclean: clean
	@rm -f boot622.exe $(UTILS)

.PHONY: all clean distclean

