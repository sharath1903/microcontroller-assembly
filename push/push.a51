ORG 0000H        ; Start of program
MOV P1, #00H     ; Set Port 1 as output (LED OFF initially)
MOV P3, #0FFH    ; Set Port 3 as input (Enable internal pull-ups)

MAIN:
    JB P3.3, MAIN       ; Wait until button is pressed (Active LOW)
    ACALL DEBOUNCE      ; Call debounce routine

    JB P3.3, MAIN       ; If button released early, ignore
    CPL P1.0            ; Toggle LED (Complement P1.0)
    
WAIT_RELEASE:
    JNB P3.3, WAIT_RELEASE ; Wait until button is released
    ACALL DEBOUNCE          ; Call debounce routine
    SJMP MAIN               ; Repeat loop

; Debounce Routine (Simple delay)
DEBOUNCE:
    MOV R3, #50       ; Load delay counter
DELAY_LOOP:
    DJNZ R3, DELAY_LOOP
    RET               ; Return to main program

END