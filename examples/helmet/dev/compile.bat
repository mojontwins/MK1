@echo off

if [%1]==[help] goto :help

set game=helmet

if [%1]==[justcompile] goto :compile
if [%1]==[clean] goto :clean

cd ..\script
if not exist %game%.spt goto :noscript
echo Compilando script
..\..\..\src\utils\msc3_mk1.exe %game%.spt 24 > nul
copy msc.h ..\dev\my > nul
copy msc-config.h ..\dev\my > nul
copy scripts.bin ..\dev\ > nul
:noscript
cd ..\dev

if [%1]==[justscripts] goto :compile

echo Importando GFX
..\..\..\src\utils\ts2bin.exe ..\gfx\font.png notiles font.bin 7 >nul

..\..\..\src\utils\sprcnv.exe ..\gfx\sprites.png assets\sprites.h > nul

..\..\..\src\utils\sprcnvbin.exe ..\gfx\sprites_extra.png sprites_extra.bin 1 > nul
..\..\..\src\utils\sprcnvbin8.exe ..\gfx\sprites_bullet.png sprites_bullet.bin 1 > nul

..\..\..\src\utils\png2scr.exe ..\gfx\title.png ..\gfx\title.scr > nul
..\..\..\src\utils\png2scr.exe ..\gfx\marco.png ..\gfx\marco.scr > nul
..\..\..\src\utils\png2scr.exe ..\gfx\ending.png ..\gfx\ending.scr > nul
..\..\..\src\utils\png2scr.exe ..\gfx\loading.png loading.bin > nul
..\..\..\src\utils\apultra.exe ..\gfx\title.scr ..\bin\title.bin > nul
..\..\..\src\utils\apultra.exe ..\gfx\marco.scr ..\bin\marco.bin > nul
..\..\..\src\utils\apultra.exe ..\gfx\ending.scr ..\bin\ending.bin > nul

if [%1]==[justassets] goto :end

rem echo Running The Librarian
rem ..\utils\librarian2.exe list=..\bin\list.txt index=assets\librarian.h bins_prefix=..\bin\ rams_prefix=..\bin\ > nul

rem *** Música AY: Descomenta el player que vayas a usar (Wyz o Arkos) ***

rem echo Compilando musica 128k - Wyz Player
rem cd ..\mus
rem ..\utils\apultra.exe menu.mus menu.bin
rem ..\utils\apultra.exe level1.mus level1.bin
rem ..\utils\pasmo WYZproPlay47aZXc.ASM ..\bin\RAM1.bin 
rem cd ..\dev

rem echo Compilando musica 128k - Arkos Player
rem cd ..\mus_arkos
rem if [%1]==[nomus] goto :nomus
rem ..\utils\build_mus_bin.exe ram1.bin > nul
rem :nomus
rem copy ram1.bin ..\bin
rem copy arkos-addresses.h ..\dev\sound
rem cd ..\dev

:compile
echo Compilando guego (EN)
zcc +zx -vn mk1.c -O3 -crt0=crt.asm -o %game%_en.bin -lsplib2_mk2_bg.lib -zorg=24000 -DCHEAT > nul
rem zcc +zx -vn mk1.c -o %game%.bin -lsplib2_mk2.lib -zorg=24000 > nul
..\..\..\src\utils\printsize.exe %game%_en.bin
..\..\..\src\utils\printsize.exe scripts.bin

rem *** Tipo de cargador ***

echo Construyendo cinta
rem cambia LOADER por el nombre que quieres que salga en Program:
..\..\..\src\utils\bas2tap -a10 -sHELMET_EN loader\loader.bas loader.tap > nul
..\..\..\src\utils\bin2tap -o screen.tap -a 16384 loading.bin > nul
..\..\..\src\utils\bin2tap -o main.tap -a 24000 %game%_en.bin > nul
copy /b loader.tap + screen.tap + main.tap %game%_en.tap > nul

echo Compilando guego (ES)
zcc +zx -vn mk1.c -O3 -crt0=crt.asm -o %game%_es.bin -lsplib2_mk2_bg.lib -zorg=24000 -DLANG_ES -DCHEAT > nul
rem zcc +zx -vn mk1.c -o %game%.bin -lsplib2_mk2.lib -zorg=24000 > nul
..\..\..\src\utils\printsize.exe %game%_es.bin
..\..\..\src\utils\printsize.exe scripts.bin

rem *** Tipo de cargador ***

echo Construyendo cinta
rem cambia LOADER por el nombre que quieres que salga en Program:
..\..\..\src\utils\bas2tap -a10 -sHELMET_ES loader\loader.bas loader.tap > nul
..\..\..\src\utils\bin2tap -o screen.tap -a 16384 loading.bin > nul
..\..\..\src\utils\bin2tap -o main.tap -a 24000 %game%_es.bin > nul
copy /b loader.tap + screen.tap + main.tap %game%_es.tap > nul


rem echo Construyendo cinta 128k
rem ..\..\..\src\utils\imanol.exe ^
rem in=loader\loaderzx.asm-orig ^
rem out=loader\loader.asm ^
rem ram1_length=?..\bin\RAM1.bin ^
rem ram3_length=?..\bin\RAM3.bin ^
rem mb_length=?%game%.bin  > nul

rem ..\utils\pasmo.exe loader\loader.asm ..\bin\loader.bin loader.txt

rem cambia LOADER por el nombre que quieres que salga en Program:
rem ..\..\..\src\utils\GenTape.exe %game%.tap ^
rem basic 'LOADER' 10 ..\bin\loader.bin ^
rem data                loading.bin ^
rem data                ..\bin\RAM1.bin ^
rem data                ..\bin\RAM3.bin ^
rem data                %game%.bin

if [%1]==[andtape] goto :tape
if [%2]==[andtape] goto :tape


:tapedone
if [%1]==[justcompile] goto :end
if [%1]==[noclean] goto :end

:clean
echo Limpiando
del loader.tap > nul
del screen.tap > nul
del main.tap > nul
del ..\gfx\*.scr > nul
del *.bin > nul

goto :end 

:tape
echo Construyendo cintas definitivas en ..\show

..\..\..\src\utils\png2scr.exe ..\gfx\preloading.png preloading.bin > nul

del ..\bin\pre_scrc.bin > nul
..\..\..\src\utils\zx7.exe preloading.bin ..\bin\pre_scrc.bin
del ..\bin\scrc.bin > nul
..\..\..\src\utils\zx7.exe loading.bin ..\bin\scrc.bin
del ..\bin\game_enc.bin > nul
..\..\..\src\utils\zx7.exe %game%_en.bin ..\bin\game_enc.bin
del ..\bin\game_esc.bin > nul
..\..\..\src\utils\zx7.exe %game%_es.bin ..\bin\game_esc.bin

..\..\..\src\utils\imanol.exe ^
    in=loader\loaderzx48_2scr_zx7.asm-orig ^
    out=loader\loader.asm ^
    preloadingcomplength=?..\bin\pre_scrc.bin ^
    loadingcomplength=?..\bin\scrc.bin ^
    mainbincomplength=?..\bin\game_enc.bin

..\..\..\src\utils\pasmo.exe loader\loader.asm ..\bin\loader.bin loader.txt

..\..\..\src\utils\GenTape.exe ..\show\mojon_twins--sgt-helmet-definitivaw--EN.tap ^
    basic 'SGT.HELMET' 10 ..\bin\loader.bin ^
    data              ..\bin\pre_scrc.bin ^
    data              ..\bin\scrc.bin ^
    data              ..\bin\game_enc.bin

..\..\..\src\utils\imanol.exe ^
    in=loader\loaderzx48_2scr_zx7.asm-orig ^
    out=loader\loader.asm ^
    preloadingcomplength=?..\bin\pre_scrc.bin ^
    loadingcomplength=?..\bin\scrc.bin ^
    mainbincomplength=?..\bin\game_esc.bin

..\..\..\src\utils\pasmo.exe loader\loader.asm ..\bin\loader.bin loader.txt

..\..\..\src\utils\GenTape.exe ..\show\mojon_twins--sgt-helmet-definitivaw--ES.tap ^
    basic 'SGT.HELMET' 10 ..\bin\loader.bin ^
    data              ..\bin\pre_scrc.bin ^
    data              ..\bin\scrc.bin ^
    data              ..\bin\game_esc.bin

del loader\loader.asm > nul
del loader.txt > nul

goto :tapedone

:help
echo "compile.bat [help|justcompile|clean|justscripts|justassets|noclean] [andtape]"

:end
echo Hecho!
