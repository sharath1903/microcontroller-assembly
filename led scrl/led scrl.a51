ORG 0000H

MOV P2, #00H
MOV P3, #00H

MAIN:
    CALL INIT_LCD
    MOV DPTR, #MSG
    CALL DISPLAY

HERE:
    SJMP HERE

;----------------------------------
INIT_LCD:
    MOV A, #38H      ; Function set
    ACALL LCD_CMD
    MOV A, #0EH      ; Display ON, cursor ON
    ACALL LCD_CMD
    MOV A, #01H      ; Clear display
    ACALL LCD_CMD
    MOV A, #06H      ; Entry mode
    ACALL LCD_CMD
    MOV A, #80H      ; Set DDRAM address to 0x00 (start of first line)
    ACALL LCD_CMD
    RET

;----------------------------------
LCD_CMD:
    MOV P2, A
    CLR P3.0         ; RS = 0 for command
    CLR P3.1         ; RW = 0 for write
    SETB P3.2        ; EN = 1
    ACALL DELAY
    CLR P3.2         ; EN = 0
    ACALL DELAY
    RET

;----------------------------------
LCD_DATA:
    MOV P2, A
    SETB P3.0        ; RS = 1 for data
    CLR P3.1         ; RW = 0 for write
    SETB P3.2        ; EN = 1
    ACALL DELAY
    CLR P3.2         ; EN = 0
    ACALL DELAY
    RET

;----------------------------------
DISPLAY:
NEXT_CHAR:
    CLR A
    MOVC A, @A+DPTR
    JZ SCROLL
    ACALL LCD_DATA
    INC DPTR
    SJMP NEXT_CHAR

SCROLL:
    ACALL DELAY
    MOV A, #1CH      ; Scroll display
    ACALL LCD_CMD
    SJMP SCROLL

;----------------------------------
DELAY:
    MOV R5, #255
D1: MOV R6, #255
D2: DJNZ R6, D2
    DJNZ R5, D1
    RET

;----------------------------------
MSG: DB 'MANI', 0

END
