INCLUDE "game/src/common/constants.asm"
INCLUDE "game/src/common/macros.asm"

SECTION "interrupts", ROM0[$40]
IntVblank::
  di
  jp $036e

  db $01,$1A,$18,$B8

IntLCD::
  jp $2eea

  db $fa,$90,$cd,$18,$b0

IntTimer::
  reti

  db $fa,$02,$c0,$b7,$c9

  padend $0058

IntSerial::
  jp $2edd
  reti

  padend $0060

IntJoypad::
  reti