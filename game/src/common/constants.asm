; Game specific
C_CurrentBank       EQU $4000

H_RegJoyp           EQU $ff00
H_RegSB             EQU $ff01
H_RegSC             EQU $ff02
H_RegDIV            EQU $ff04
H_RegTIMA           EQU $ff05
H_RegTMA            EQU $ff06
H_RegTAC            EQU $ff07
H_RegIF             EQU $ff0f
H_RegNR10           EQU $ff10
H_RegNR11           EQU $ff11
H_RegNR12           EQU $ff12
H_RegNR13           EQU $ff13
H_RegNR14           EQU $ff14
H_RegNR21           EQU $ff16
H_RegNR22           EQU $ff17
H_RegNR23           EQU $ff18
H_RegNR24           EQU $ff19
H_RegNR30           EQU $ff1a
H_RegNR31           EQU $ff1b
H_RegNR32           EQU $ff1c
H_RegNR33           EQU $ff1d
H_RegNR34           EQU $ff1e
H_RegNR41           EQU $ff20
H_RegNR42           EQU $ff21
H_RegNR43           EQU $ff22
H_RegNR44           EQU $ff23
H_RegNR50           EQU $ff24
H_RegNR51           EQU $ff25
H_RegNR52           EQU $ff26
H_RegLCDC           EQU $ff40
H_LCDStat           EQU $ff41
H_RegSCY            EQU $ff42
H_RegSCX            EQU $ff43
H_RegLY             EQU $ff44
H_RegLYC            EQU $ff45
H_RegDMA            EQU $ff46
H_RegBGP            EQU $ff47
H_RegOBP0           EQU $ff48
H_RegOBP1           EQU $ff49
H_RegWY             EQU $ff4a
H_RegWX             EQU $ff4b
H_RegKEY1           EQU $ff4d
H_RegVBK            EQU $ff4f
H_RegHDMA1          EQU $ff51
H_RegHDMA2          EQU $ff52
H_RegHDMA3          EQU $ff53
H_RegHDMA4          EQU $ff54
H_RegHDMA5          EQU $ff55
H_RegRP             EQU $ff56
H_RegBGPI           EQU $ff68
H_RegBGPD           EQU $ff69
H_RegOBPI           EQU $ff6a
H_RegOBPD           EQU $ff6b
H_RegSVBK           EQU $ff70
H_RegIE             EQU $ffff

H_PushOAM           EQU $ff80

; Joypad
H_JPInputHeldDown   EQU $ff8c
H_JPInputChanged    EQU $ff8d

H_VBlankCompleted   EQU $ff92

H_SoundEffect       EQU $ffa1

M_JPInputA          EQU $1
M_JPInputB          EQU $2
M_JPInputSelect     EQU $4
M_JPInputStart      EQU $8
M_JPInputRight      EQU $10
M_JPInputLeft       EQU $20
M_JPInputUp         EQU $40
M_JPInputDown       EQU $80

X_MBC5SRAMEnable    EQU $0000
X_MBC5ROMBankLow    EQU $2000
X_MBC5ROMBankHigh   EQU $3000
X_MBC5SRAMBank      EQU $4000