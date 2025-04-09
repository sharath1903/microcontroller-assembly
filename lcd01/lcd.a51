ORG 0000H

MOV P2, #00H    ; Configure P2 as output (LCD data)
MOV P3, #00H    ; Configure P3 as output (Control pins)

CALL INIT_LCD   ; Initialize LCD

; Display "Hi! Welcome"
MOV DPTR, #MSG  ; Load message address
CALL DISPLAY_STR

HERE: SJMP HERE ; Infinite loop

; ---------- LCD Initialization -------------
INIT_LCD:
    MOV A, #38H  ; Function Set: 8-bit mode, 2 lines, 5x8 font
    CALL CMD_WR
    MOV A, #0CH  ; Display ON, Cursor OFF
    CALL CMD_WR
    MOV A, #01H  ; Clear Display
    CALL CMD_WR
    MOV A, #06H  ; Entry Mode: Auto Increment
    CALL CMD_WR
    RET

; ---------- Command Write Function -------------
CMD_WR:
    MOV P2, A    ; Send command to LCD
    CLR P3.0     ; RS = 0 (Command mode)
    CLR P3.1     ; RW = 0 (Write)
    SETB P3.2    ; Enable high
    ACALL DELAY
    CLR P3.2     ; Enable low
    ACALL DELAY
    RET

; ---------- Data Write Function -------------
DATA_WR:
    MOV P2, A    ; Send data to LCD
    SETB P3.0    ; RS = 1 (Data mode)
    CLR P3.1     ; RW = 0 (Write)
    SETB P3.2    ; Enable high
    ACALL DELAY
    CLR P3.2     ; Enable low
    ACALL DELAY
    RET

; ---------- Display String Function -------------
DISPLAY_STR:
    CLR A
    MOVC A, @A+DPTR ; Load first character
    JZ EXIT_STR     ; If null terminator, exit
    CALL DATA_WR    ; Send character to LCD
    INC DPTR        ; Move to next character
    SJMP DISPLAY_STR

EXIT_STR:
    RET

; ---------- Delay Function -------------
DELAY:
    MOV R7, #255
DELAY_LOOP1:
    MOV R6, #255
DELAY_LOOP2:
    DJNZ R6, DELAY_LOOP2
    DJNZ R7, DELAY_LOOP1
    RET

; ---------- Message Data -------------
MSG: DB "sharath", 0  ; String with null terminator

END
