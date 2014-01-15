build := MAKEFLAGS= wine nmake -f Makefile.msc

all: htget.exe

htget.exe: ../.lwp-stamp ../.msvc-stamp
	@$(build)

../.lwp-stamp ../.msvc-stamp:
	$(MAKE) -C ../utils

clean:
	@$(build) clean

.PHONY: clean

