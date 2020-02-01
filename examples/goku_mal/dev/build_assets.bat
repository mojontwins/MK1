@echo off

if [%1]==[skipscr] goto skipscr

..\..\..\src\utils\png2scr ..\gfx\title.png ..\bin\title.bin
..\..\..\src\utils\png2scr ..\gfx\marco.png ..\bin\marco.bin
..\..\..\src\utils\png2scr ..\gfx\ending.png ..\bin\ending.bin
..\..\..\src\utils\png2scr ..\gfx\logo.png ..\bin\logo.bin
..\..\..\src\utils\png2scr ..\gfx\dedicado.png ..\bin\dedicado.bin
..\..\..\src\utils\png2scr ..\gfx\controls.png ..\bin\controls.bin
..\..\..\src\utils\png2scr ..\gfx\intro1.png ..\bin\intro1.bin
..\..\..\src\utils\png2scr ..\gfx\intro2.png ..\bin\intro2.bin
..\..\..\src\utils\png2scr ..\gfx\intro3.png ..\bin\intro3.bin
..\..\..\src\utils\png2scr ..\gfx\intro4.png ..\bin\intro4.bin
..\..\..\src\utils\png2scr ..\gfx\intro5.png ..\bin\intro5.bin
..\..\..\src\utils\png2scr ..\gfx\intro6.png ..\bin\intro6.bin
..\..\..\src\utils\png2scr ..\gfx\intro7.png ..\bin\intro7.bin
..\..\..\src\utils\png2scr ..\gfx\zonaA.png ..\bin\zonaA.bin
..\..\..\src\utils\png2scr ..\gfx\zonaB.png ..\bin\zonaB.bin

..\..\..\src\utils\apultra ..\bin\title.bin ..\bin\titlec.bin
..\..\..\src\utils\apultra ..\bin\marco.bin ..\bin\marcoc.bin
..\..\..\src\utils\apultra ..\bin\ending.bin ..\bin\endingc.bin
..\..\..\src\utils\apultra ..\bin\logo.bin ..\bin\logoc.bin
..\..\..\src\utils\apultra ..\bin\dedicado.bin ..\bin\dedicadoc.bin
..\..\..\src\utils\apultra ..\bin\controls.bin ..\bin\controlsc.bin
..\..\..\src\utils\apultra ..\bin\intro1.bin ..\bin\intro1c.bin
..\..\..\src\utils\apultra ..\bin\intro2.bin ..\bin\intro2c.bin
..\..\..\src\utils\apultra ..\bin\intro3.bin ..\bin\intro3c.bin
..\..\..\src\utils\apultra ..\bin\intro4.bin ..\bin\intro4c.bin
..\..\..\src\utils\apultra ..\bin\intro5.bin ..\bin\intro5c.bin
..\..\..\src\utils\apultra ..\bin\intro6.bin ..\bin\intro6c.bin
..\..\..\src\utils\apultra ..\bin\intro7.bin ..\bin\intro7c.bin
..\..\..\src\utils\apultra ..\bin\zonaA.bin ..\bin\zonaAc.bin
..\..\..\src\utils\apultra ..\bin\zonaB.bin ..\bin\zonaBc.bin

:skipscr