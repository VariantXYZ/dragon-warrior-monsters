INCLUDE "game/src/common/constants.asm"
INCLUDE "game/src/common/macros.asm"

SECTION "rst00", ROM0[$0000]
Rst00::
  pop hl
  add a
  add l
  ld l, a
  ld a, $00
  adc h
  ld h, a
Rst08::
  ld a, [hli]
  ld h, [hl]
  ld l, a
  jp hl
  ld a, [hli]
  ld h, [hl]
  ld l, a
  ret

Rst10::
  ld a, [C_CurrentBank]
  push af
  ld a, h
  ld [$2100], a
Rst18::
  swap a
  rra
  and $03
  ld [$4100], a
Rst20::
  add hl, hl
  ld h, $00
  ld bc, $4001
  add hl, bc
  call Rst08 ; Why not just rst $8 here?
  pop af
  ld [$2100], a
  swap a
Rst30::
  rra
  and $03
  ld [$4100], a
  ret

  padend $38