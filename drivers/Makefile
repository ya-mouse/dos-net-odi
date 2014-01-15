DRIVERS=E1000ODI.COM \
	BX2.COM \
	BNX2EV.COM \
	PCNTNW.COM

all: drv.tgz

drv.tgz: $(DRIVERS)
	tar cfz $@ $^
	@touch ../.drivers-stamp

E1000ODI.COM: prodos.exe
	dd if=$^ of=prodos.cab bs=$$((0x000476b9)) skip=1
	cabextract -p prodos.cab -F PRO1000/DOS/e1000odi.com > $@
	@rm -f prodos.cab

BX2.COM: nw_odi16-5.0.0.zip
	unzip -p $^ Server/Netware/ODI16/NX2/bx2.com > $@

BNX2EV.COM: nw_odi16_ev-5.2.2.zip
	unzip -p $^ Server/Netware/ODI16/NX2_Ev/bnx2ev.com > $@

PCNTNW.COM: odiwkstn_dos.zip
	unzip -p $^ odiwkstn_dos.exe | \
	    dd of=odiwkstn_dos.cab bs=$$((0x000242a9)) skip=1
	cabextract -p odiwkstn_dos.cab -F PCNTNW.COM > $@
	@rm -f odiwkstn_dos.cab

prodos.exe:
	wget -c -O $@ http://downloadmirror.intel.com/4239/eng/PRODOS.exe

nw_odi16-5.0.0.zip:
	wget -c -O $@ http://www.broadcom.com/docs/driver_download/NXII/nw_odi16-5.0.0.zip

nw_odi16_ev-5.2.2.zip:
	wget -c -O $@ http://www.broadcom.com/docs/driver_download/NXII_10/nw_odi16_ev-5.2.2.zip

odiwkstn_dos.zip:
	wget -c -O $@ http://support.amd.com/us/Embedded_TechDownloads/odiwkstn_dos.zip

clean:
	@rm -f $(DRIVERS) drv.tgz ../.drivers-stamp

distclean: clean

.PHONY: all clean distlean

