;
; AMX Mouse Initialization
; Alvin Albrecht 01.2003
;

INCLUDE "SPconfig.def"

XLIB SPMouseAMXInit
XDEF SPAMXDX, SPAMXDY, SPAMXxcoord, SPAMXycoord
LIB SPInstallISR

; References:
;   1. http://www.breezer.demon.co.uk/spec/tech/hware.html
;      Has an excerpt of the Z80 Emulator's documentation on the AMX Mouse.
;      Information is incorrect about mouse buttons.  Used the Spectaculator
;      emulator as reference for button behaviour.
;   2. "Z80 Data Book," Mostek Microcomputer Corporation, August 1978.
;      Technical documentation of the Z80 PIO Chip.

; AMX Mouse
;
; The AMX mouse is interfaced to the Spectrum using a Z80 PIO chip
; configured in input mode.  Port A of the chip is associated
; with X movement and port B is associated with Y movement.  The
; mouse interface will generate an interrupt on port A or port B
; each time it is moved a distance of "one mickey" in the X or
; Y direction respectively.  It is the program's job to field
; these interrupts and update internal state representing the
; mouse's absolute position.  Once an interrupt has occurred,
; reading the data port (A or B) will return 0 (positive) or
; 1 (negative) to indicate movement direction.
;
; Needless to say you must have interrupt mode 2 enabled to
; catch AMX mouse interrupts.
;
; Port Addresses:
;
;   (Mapped to PIO chip)
;   $1f    Data Port A
;   $3f    Data Port B
;   $5f    Control Port A
;   $7f    Control Port B
;
;   (Separate from PIO chip)
;   $df    State of three mouse buttons: bit 7 = left, bit 6 = right active,
;          bit 5 = middle, active low.  The mouse buttons are either or both
;          not debounced or open collector.  The former adds random transitions
;          around a mouse press / depress and the latter adds random transitions
;          when the mouse is left unpressed, caused by ULA attribute bytes on
;          a floating bus.  You must take this into consideration when getting
;          a reliable read of the mouse buttons' state.
;
; Note that the AMX Mouse interface conflicts with the Kempston
; joystick interface ($1f), the Disciple disk interface ($1f) and
; the Multiface ($3f).

;
; Global Static Variables
;

.SPAMXDX                   ; change in X position for each interrupt received
IF DISP_HIRES
   defw $0080
ELSE
   defw $0100
ENDIF

.SPAMXDY                   ; change in Y position for each interrupt received
   defw $0100

.SPAMXxcoord               ; place mouse at top left corner of screen initially
   defw 0                  ; coords are 16 bit fixed point, with binary point
.SPAMXycoord               ; between two bytes (except HIRES mode where binary
   defw 0                  ; point is between bits 6 and 7 of 16 bit word).


; MouseAMXInit
;
; Initializes AMX interface and places vectors into the im 2
; interrupt vector table.  "InitIM2" should have been called
; first to create the table.  Once this is called you
; can read the xcoord, ycoord of the mouse directly from
; AMXxoord or AMXycoord.  Or you can use the MouseAMX subroutine.
;
; DISABLE INTERRUPTS BEFORE CALLING!
;
; enter: 
;        b  = im 2 vector for X interrupts (even, 0..254)
;        c  = im 2 vector for Y interrupts (even, 0..254)

.SPMouseAMXInit
   ld l,b
   ld de,XInterrupt
   call SPInstallISR             ; place ISR address into im 2 vector table

   ld l,c
   ld de,YInterrupt
   call SPInstallISR             ; place ISR address into im 2 vector table

   ld a,b
   out ($5f),a                   ; PIO vector for X
   ld a,$97
   out ($5f),a                   ; PIO enable interrupt generation for X
   ld a,$4f
   out ($5f),a                   ; PIO select input mode for X

   ld a,c
   out ($7f),a                   ; PIO vector for Y
   ld a,$97
   out ($7f),a                   ; PIO enable interrupt generation for Y
   ld a,$4f
   out ($7f),a                   ; PIO select input mode for Y
   ret


; interrupt service routines

.XInterrupt
   push af
   push de
   push hl

   ld de,(SPAMXDX)
   ld hl,(SPAMXxcoord)

   in a,($1f)
   or a
   jr z,posx
   sbc hl,de
   jp nc, contx
   ld hl,0
   jp contx

.posx
   add hl,de
   jp nc, contx
   ld hl,$ffff

.contx
   ld (SPAMXxcoord),hl
   pop hl
   pop de
   pop af
   ei
   reti


.YInterrupt
   push af
   push de
   push hl

   ld de,(SPAMXDY)
   ld hl,(SPAMXycoord)

   in a,($3f)
   or a
   jr z,posy
   add hl,de
   jp nc, conty
   ld hl,$ffff
   jp conty

.posy
   sbc hl,de
   jp nc, conty
   ld hl,0

.conty
   ld (SPAMXycoord),hl
   pop hl
   pop de
   pop af
   ei
   reti
