ORG 0000H

START:
    MOV R0, #00H

MAIN:
    MOV A, R0
    MOV P2, A
    ACALL DELAY
    INC R0
    CJNE R0, #64H, NEXT
    MOV R0, #00H

NEXT:
    SJMP MAIN

DELAY:
    MOV R2, #255
D1: MOV R3, #255
D2: DJNZ R3, D2
    DJNZ R2, D1
    RET

END
