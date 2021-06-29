;
; Static Huffman Encoder
; Alvin Albrecht 03.2003
;

XLIB SPHuffEncode

; enter: hl = addr of encoder array (array indexed by symbols pointing at decoder tree leaves)
;         c = symbol to encode
;        de = memory address to write encoded symbol to
;         a = next bit in de to write to (bit mask)
; exit : hl = memory address to write next encoded symbol to
;         c = next bit in hl to write to (bit mask)
; uses : af, bc, de, hl, b', de', hl'

.SPHuffEncode
   ld b,0
   add hl,bc
   add hl,bc         ; hl = &encoder[c] contains pointer to symbol's leaf node
   ld c,a            ; c = next memory bit to write to
   ld a,(hl)
   inc hl
   ld h,(hl)
   ld l,a            ; hl = decoder tree leaf for symbol
   push hl
   exx
   pop hl            ; hl = decoder tree leaf for symbol
   ld b,0            ; b = # of encoded bits on stack

.encode
   ld e,(hl)
   inc hl
   ld a,(hl)
   or a
   jp nz, notdone    ; if parent of this node is NULL (msb), done encoding!
   ld a,b            ; a = # of encoded bits on stack
   exx
   ex de,hl          ; hl = memory address to write symbol to
   or a
   ret z             ; if no encoded bits, return done

   ld b,a
.writeloop
   pop af
   ld a,c
   jr nz, encoderight
   cpl               ; encode a left movement in tree by writing a 0 bit
   and (hl)
   ld (hl),a
   jp cont
.encoderight
   or (hl)           ; encode a right movement in tree by writing a 1 bit
   ld (hl),a
.cont
   srl c             ; move to next bit in memory
   jp nc, cont2      ; if byte still not filled
   inc hl            ; move on to next memory byte
   ld c,$80          ; start with first bit in byte
.cont2
   djnz writeloop
   ret

.notdone
   ld d,a            ; de = parent node
   inc de
   inc de            ; de = parent.left
   dec hl            ; hl = child
   ld a,(de)         ; find out if hl is a left child or right child
   cp l
   inc de            ; de = parent.left+1
   jr nz, foundchild
   ld a,(de)
   cp h
.foundchild
   push af           ; save: nz = right child, z = left child
   inc b             ; one more encoded bit on stack
   ld hl,-3
   add hl,de         ; hl = parent
   jp encode         ; on to the next encoded bit
