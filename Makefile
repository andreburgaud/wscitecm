TARGETOS = BOTH
!include <win32.mak>

lflags  = /NODEFAULTLIB /INCREMENTAL:NO /RELEASE /NOLOGO
dlllflags = $(lflags) -entry:_DllMainCRTStartup$(DLLENTRY) -dll

all: wscitecm.dll

wscitecm.dll: wscitecm.obj wscitecm.res
	$(implib) -machine:$(CPU) -def:wscitecm.def $** -out:wscitecm.lib
	$(link) $(dlllflags) -base:0x1C000000 -out:$*.dll $** $(olelibsdll) shell32.lib msvcrt.lib wscitecm.lib comctl32.lib wscitecm.exp
	mt -manifest $*.manifest -outputresource:$*.dll;2

.cpp.obj:
	$(cc) $(cflags) $(cvarsdll) $*.cpp

wscitecm.res: wscitecm.rc
	$(rc) $(rcflags) $(rcvars) wscitecm.rc

clean:
	-1 del wscitecm.dll wscitecm.lib wscitecm.dll.manifest wscitecm.obj wscitecm.exp wscitecm.res

zip:
	-1 del *.zip
	perl abpack.pl