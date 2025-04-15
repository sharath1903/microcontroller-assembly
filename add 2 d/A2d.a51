ORG 0000H        ; Starting address

LOW_BYTE:
    MOV A, #5FH      ; Load lower byte into accumulator
    ADD A, #0B4H     ; Add immediate value
    MOV R7, A        ; Store result in R7

HIGH_BYTE:
    MOV A, #2EH      ; Load upper byte into accumulator
    ADDC A, #0A3H    ; Add immediate value with carry
    MOV R6, A        ; Store result in R6

LOOP:
    SJMP LOOP        ; Infinite loop to end program

END                 ; End of program
