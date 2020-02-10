@echo off

if [%1]==[skipscr] goto skipscr

echo Converting Fixed Screens
..\..\..\src\utils\png2scr ..\gfx\title.png ..\bin\title.scr > nul
..\..\..\src\utils\png2scr ..\gfx\ending.png ..\bin\ending.scr > nul

..\..\..\src\utils\apultra ..\bin\title.scr ..\bin\title.bin > nul
..\..\..\src\utils\apultra ..\bin\ending.scr ..\bin\ending.bin > nul

del ..\bin\*.scr > nul

:skipscr

echo Running The Librarian
..\..\..\src\utils\librarian2.exe list=..\bin\list.txt index=assets\librarian.h bins_prefix=..\bin\ rams_prefix=..\bin\ > nul

echo Making music
cd ..\mus
..\..\..\src\utils\pasmo ..\mus\WYZproPlay47aZXc.ASM ..\bin\RAM1.bin > nul
cd ..\dev

echo DONE
..\..\..\src\utils\printsize ..\bin\RAM1.bin
..\..\..\src\utils\printsize ..\bin\RAM3.bin
