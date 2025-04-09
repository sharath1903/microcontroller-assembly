ORG 00H          ; Start of program memory

; Main Program
MAIN: 
    MOV TMOD, #01H        ; Set Timer 0 in Mode 1 (16-bit timer mode)

AGAIN1: 
    MOV P1, #0FFH         ; Set all pins of Port 1 to HIGH
    ACALL DELAY           ; Call delay subroutine
    MOV P1, #00H          ; Set all pins of Port 1 to LOW
    ACALL DELAY           ; Call delay subroutine
    SJMP AGAIN1           ; Repeat the loop forever

; Delay Subroutine (5ms)
DELAY: 
    MOV TL0, #00H         ; Load Timer 0 low byte
    MOV TH0, #0EEH        ; Load Timer 0 high byte for ~5ms delay
    SETB TR0              ; Start Timer 0
AGAIN: 
    JNB TF0, AGAIN        ; Wait until Timer 0 overflows (TF0 = 1)
    CLR TR0               ; Stop Timer 0
    CLR TF0               ; Clear Timer 0 overflow flag
    RET                   ; Return from subroutine

END