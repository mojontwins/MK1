@echo off
set Z88DK_PATH=c:\z88dk10
set PATH=%Z88DK_PATH%\bin;%PATH%
set Z80_OZFILES=%Z88DK_PATH%\Lib\
set ZCCCFG=%Z88DK_PATH%\Lib\Config\
zcc 
