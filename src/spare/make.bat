@echo off
echo ### COMPILANDO SCRIPT ###
cd ..\script
msc gokumal.spt msc.h 25
copy *.h ..\dev
cd ..\dev
echo -------------------------------------------------------------------------------
echo ### GENERANDO BINARIOS ###
echo * Building reubica
..\utils\pasmo reubica.asm reubica.bin
echo * Building levels
cd ..\levels
call makelevels.bat
copy *.bin ..\bin
echo * Building RAM3 AND RAM4 AND RAM6
cd ..\bin
..\utils\apack.exe level1.bin level1c.bin
..\utils\apack.exe level2.bin level2c.bin
..\utils\apack.exe level3.bin level3c.bin
..\utils\apack.exe level4.bin level4c.bin
..\utils\apack.exe level5.bin level5c.bin
del level1.bin
del level2.bin
del level3.bin
del level4.bin
del level5.bin
librarian.exe
copy RAM3.bin ..\dev\ram3.bin
copy RAM4.bin ..\dev\ram4.bin
copy RAM6.bin ..\dev\ram6.bin
copy librarian.h ..\dev
echo -------------------------------------------------------------------------------
echo ### COMPILANDO WYZ PLAYER ###
cd ..\mus
..\utils\pasmo WYZproPlay47aZX.ASM ram1.bin
copy ram1.bin ..\dev
cd ..\dev
echo -------------------------------------------------------------------------------
echo ### COMPILANDO GUEGO ###
rem zcc +zx -vn gokumal.c -o gokumal.bin -lndos -lsplib2 -zorg=24200
zcc +zx -vn gokumal.c -o gokumal.bin -lsplib2 -zorg=24200
echo -------------------------------------------------------------------------------
echo ### CONSTRUYENDO CINTA ###
..\utils\bas2tap -a10 -sLOADER loader.bas loader.tap
..\utils\bin2tap -o reubica.tap -a 25000 reubica.bin
..\utils\bin2tap -o ram1.tap -a 32768 ram1.bin
..\utils\bin2tap -o ram3.tap -a 32768 ram3.bin
..\utils\bin2tap -o ram4.tap -a 32768 ram4.bin
..\utils\bin2tap -o ram6.tap -a 32768 ram6.bin
..\utils\bin2tap -o screen.tap -a 16384 loading.bin
..\utils\bin2tap -o main.tap -a 24200 gokumal.bin
copy /b loader.tap + screen.tap + reubica.tap + ram1.tap + ram3.tap + ram4.tap + ram6.tap + main.tap gokumal.tap
echo -------------------------------------------------------------------------------
echo ### LIMPIANDO ###
del loader.tap
del screen.tap
del main.tap
del reubica.tap
del ram1.bin
del ram3.bin
del ram4.bin
del ram6.bin
del ram1.tap
del ram3.tap
del ram4.tap
del ram6.tap
del gokumal.bin
del zcc_opt.def
echo -------------------------------------------------------------------------------
echo ### DONE ###
