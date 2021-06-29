
Sprite Pack V2.2

Game Engine for Sinclair and Timex Computers
Alvin Albrecht 09.2003

http://www.geocities.com/aralbrec
The website is still a mess but is being worked on.  A
nearly complete tutorial is now available there.

SP supports four different video modes: the normal
Spectrum display mode (256x192 pixel, 32x24 colour),
the Timex hi-colour mode (256x192 pixel, 32x192 colour),
the Timex hi-res mode (512x192 pixel monochrome)
and the Timex dual screen mode (double buffered Spectrum
display).  You must select the appropriate mode you
are interested in prior to compiling the library.
Needless to say, you will need a Timex machine or an
emulated Timex machine to run programs using anything
other than the Spectrum display mode.


Installation Steps:

To compile a fresh library with customizable settings.
(Some versions of the library have been compiled for
you already -- see below).
1. Edit "SPconfig.def" file to select lib configuration.
2. Run "Makefile.bat" to compile lib.

To copy the lib into standard directories so that it
can be found by the linker.
3. Enter "copy splib2.lib \z88dk\lib\clibs"
4. Enter "copy spritepack.h \z88dk\include"

NOTE to non-msdos users: the "makefile" batch program needs
modification to work on anything else.  Yes, I will get
a real makefile utility sometime in the future.  A few
pre-compiled libraries are sitting in the main directory
for your convenience.  "splib2a.lib", "splib2b.lib",
"splib2c.lib" and "splib2d.lib" are pre-compiled libraries
supporting the Spectrum, dual-screen, hi-colour and
hi-res video modes respectively.  Rename the lib
of interest to "splib2.lib" and copy it to the correct
destination directory as in step 3 above.  The default
settings used are in the file "SPconfig.def".

Now compile C or assembler programs as usual, remembering
to include the "spritepack.h" header in your source files and
to link to the library with "-lsplib2" in the compile command.
Eg: zcc +zx -vn myprog.c -o myprog.bin -lsplib2 -lndos

You have the right to use and abuse this software as
you see fit but please include an acknowledgement in
your projects.


IMPORTANT:

The following functions use the IY register:

sp_PrintString()

sp_IterateSprChar()
sp_MoveSprAbs*()
sp_MoveSprRel*()

sp_IntRect()
sp_IntIntervals()
sp_IntLargeRect()

sp_IterateDList()
sp_Invalidate()
sp_Validate()

Basic's interrupt service routine expects the IY
register to remain unchanged.  This means that if
any of these functions are called, interrupts must
either be disabled or you must replace the Basic
ISR with one of your own.  Otherwise your programs
will crash.


CREDITS:

February 6, 2003
  Chris Cowley for much improved Kempston Mouse support based
  on code found in his Basic mouse driver.  The improved code
  causes the mouse to stay within screen boundaries rather
  than loop across screen boundaries.  It also allows pixel size
  mouse movements in the 512x192 hi-res mode.
  .\input\SPMouseKempston.asm

March 29, 2003
  Nick Fleming for the 32-bit random number generator
  and an unsigned 32-bit multiply routine, both spotted
  in his 2003 crap games competition entry 'Nun Chaser'.
  .\miscellaneous\SPRandom32.asm
  .\miscellaneous\SPMultUnsigned.asm

August 29, 2003
   Jonathan Needle, author of Spectaculator, for providing
   information on the AMX mouse.
   .\input\SPMouseAMXInit.asm
