VOLNAME=EINSTELLUNG
DOS622_LIST=SYS.COM|COMMAND.COM|MEM.EXE|HIMEM.SYS|FORMAT.COM

SUBDIRS=utils htget drivers

export MTOOLSRC=mtools.conf

all: $(SUBDIRS) 6.22.dos .drivers-stamp
	@mdir a:

$(SUBDIRS):
	$(MAKE) -C $@ $(MAKECMDGOALS)

6.22.dos: Makefile boot622.exe
	@rm -f .config-stamp .utils-stamp .drivers-stamp
	dd if=boot622.exe of=boot622.zip bs=$$((0x0019C24)) skip=1
	dd if=/dev/zero of=boot622.zip bs=3 seek=$$((0x0E7B4F/3)) count=1 conv=notrunc
	unzip -p boot622.zip boot622.IMA > $@
	mlabel -N 0004C0DE a:$(VOLNAME)
	@rm -f boot622.zip
	mdir | sed -n 's,^\([A-Z0-9]\+\)[ ]\+\([^ ]\+\).*,\1.\2,p' | \
		egrep -v "^($(DOS622_LIST))" | \
		xargs mdel
	mmd UTILS NET NET/TCP NET/DRV VC
	mmove MEM.EXE FORMAT.COM SYS.COM UTILS

.config-stamp: autoexec.bat config.sys hosts resolv.conf ndis.map
	cat autoexec.bat | todos | mcopy -Do - a:AUTOEXEC.BAT
	cat config.sys   | todos | mcopy -Do - a:CONFIG.SYS
	cat hosts        | todos | mcopy -Do - a:NET/TCP/HOSTS
	cat resolv.conf  | todos | mcopy -Do - a:NET/TCP/RESOLV.CFG
	cat ndis.map     | todos | mcopy -Do - a:UTILS/NDIS.MAP
	@touch .config-stamp

.utils-stamp: .config-stamp htget/htget.exe logme.bat net.bat cdate.bat cdate.sed save_as.bat unpack.bat
	for f in TCPIP.EXE PING.EXE; do \
	    7z x -so utils/tcp1607.exe $$f  | mcopy -Do - a:NET/$$f; \
	done
	7z x -so utils/tcp16.exe PING.MSG   | mcopy -Do - a:NET/PING.MSG
	unzip -p utils/nwlwp50.zip LSL.COM  | mcopy -Do - a:NET/LSL.COM
	unzip -p utils/ters151f.zip T.COM   | mcopy -Do - a:UTILS/EDIT.COM
	unzip -p utils/gzip124.zip GZIP.EXE | mcopy -Do - a:UTILS/GZIP.EXE
	unzip -p utils/tar320g.zip TAR.EXE  | mcopy -Do - a:UTILS/TAR.EXE
	unzip -p utils/sed15x.zip SED.EXE   | mcopy -Do - a:UTILS/SED.EXE
	unzip -p utils/shut12.zip SHUTDOWN.COM | mcopy -Do - a:UTILS/SHUTDOWN.COM
	unzip -p utils/smbiosd.zip SMBIOSD.EXE | mcopy -Do - a:UTILS/SMBIOSD.EXE
	unzip -p utils/xgrp103x.zip BIN/XGREP.COM  | mcopy -Do - a:UTILS/XGREP.COM
	unzip -p utils/pciscan110.zip pciscan.exe  | mcopy -Do - a:UTILS/PCISCAN.EXE
	unzip -p utils/drivers-2010-06-16.zip RDISK.COM | mcopy -Do - a:UTILS/RDISK.COM
	for f in ASET STRINGS TEE; do \
		unzip -p utils/rutils40.zip $$f.EXE | mcopy -Do - a:UTILS/$$f.EXE; \
	done
	for f in VC.COM VC.INI VC.EXT; do \
		unzip -p utils/vc405sw.zip $$f | mcopy -Do - a:VC/$$f; \
	done
	mcopy -Do utils/choice.com a:UTILS/CHOICE.COM
	mcopy -Do htget/htget.exe a:UTILS/HTGET.EXE
	cat net.bat     | todos | mcopy -Do - a:NET/NET.BAT
	cat logme.bat   | todos | mcopy -Do - a:UTILS/LOGME.BAT
	cat cdate.bat   | todos | mcopy -Do - a:UTILS/CDATE.BAT
	cat cdate.sed   | todos | mcopy -Do - a:UTILS/CDATE.SED
	cat save_as.bat | todos | mcopy -Do - a:UTILS/SAVE_AS.BAT
	cat unpack.bat  | todos | mcopy -Do - a:UTILS/UNPACK.BAT
	@touch .utils-stamp

.drivers-stamp: .utils-stamp
	mcopy -Do drivers/drv.tgz a:NET/DRV.TGZ
	@touch .drivers-stamp

test: all
	qemu -fda 6.22.dos -boot a

clean: $(SUBDIRS)
	@rm -f 6.22.dos boot622.zip .config-stamp .utils-stamp

distclean: clean $(SUBDIRS)

.PHONY: all clean $(SUBDIRS)

.DELETE_ON_ERROR: 6.22.dos

