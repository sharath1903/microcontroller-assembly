ORG 00H

MAIN:
    MOV TMOD, #01H     
    MOV R2, #76        

AGAIN:
    MOV P1, #0FFH      
    ACALL DELAY        
    MOV P1, #00H       
    ACALL DELAY        
    SJMP AGAIN         

DELAY:
    MOV TH0, #00H      
    MOV TL0, #00H      
    SETB TR0           

WAIT_OVERFLOW:
    JNB TF0, WAIT_OVERFLOW 
    CLR TF0            
    CLR TR0            
    DJNZ R2, DELAY     
    RET

END
