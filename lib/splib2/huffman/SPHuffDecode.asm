;
; Static Huffman Decoder
; Alvin Albrecht 03.2003
;

XLIB SPHuffDecode

; enter: hl = root of decoder tree
;        de = memory address of encoded message
;         c = next bit in de's byte to interpret (bit mask)
; exit :  a = next decoded symbol
;        de and c are updated for decoding the next symbol
; uses : af, c, de, hl

.nextcodebit
   srl c              ; move mask right one bit
   jp nc, SPHuffDecode
   inc de             ; move on to next byte
   ld c,$80

.SPHuffDecode
   inc hl
   inc hl
   inc hl             ; hl = root.left+1
   ld a,(hl)          ; if msb of left pointer = 0 then this is a leaf
   or a
   jp nz, notleaf
   dec hl             ; a leaf, decoded symbol is stored at root.left
   ld a,(hl)
   ret                ; return with a = decoded symbol, de = next address, c = next bit

.notleaf
   ld a,(de)          ; get current byte
   and c              ; mask off bit
   jr z, goleft       ; if code bit is 0, move left along tree

   inc hl
   ld a,(hl)
   inc hl
   ld h,(hl)
   ld l,a             ; hl = root.right
   jp nextcodebit

.goleft
   ld a,(hl)
   dec hl
   ld l,(hl)
   ld h,a             ; hl = root.left
   jp nextcodebit
