/* Program that counts consecutive 1’s */
.text
.global _start
_start:
MOV r5, #0 // Initially the highest number of consecutive 1s is 0
MOV r4, #0
MOV r3, #0
MOV r2, #0
MOV r1, #0
MOV r0, #0
LDR R3,=TEST_NUM // load the address of TEST_NUM

LOOP:
    LDR R1, [R3] // load the data word into R1
    //LDR R1, TEST_NUM
    CMP R1, #0
    BLT END // If reaches -1 TEST_NUM then branch to end
    MOV R0, #0 // R0 will hold the result
    BL ONES
    /*Code for trailing and leading*/
    
    ADD R3, R3, #4 // Shift to next word
    CMP R5, R0 //If the new result>old result go to store
    BLT STORE //Go to store for ones
	B LOOP
	STORE:
    	MOV R5, R0       
   		B LOOP    
    
END: B END


ONES:
	LOOP1: CMP R1, #0 // loop until the data contains no more 1’s
        BEQ EXIT
        LSR R2, R1, #1 // perform SHIFT, followed by AND
        AND R1, R1, R2
        ADD R0, #1 // count the string lengths so far
        B LOOP1
        
	EXIT:
    	MOV PC,LR
        
	
TEST_NUM: .word 0xff800, 0xff, 0xa,-1
.end
