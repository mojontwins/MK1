@echo off
call setenv.bat
if [%1]==[install] goto install
if [%1]==[onlyasm] goto onlyasm

cd cwrapper
copy ..\SPconfig.def .
rem gencompile "zcc +zx -vn -make-lib -I.." sp_c.lst
gencompile "zcc +zx -vn -c -I.." sp_c.lst
del SPconfig.def
cd ..

:onlyasm
rem z80asm -I. -d -ns -nm -Mo -DFORzx -xsplib2_mk2 @sp.lst
z80asm -I. -d  -DFORzx -xsplib2_mk2 @sp.lst

goto end

:install
echo Copying
copy splib2_mk2*.lib %Z88DK_PATH%\lib\clibs
copy spritepack.h %Z88DK_PATH%\include\

echo done!

:end