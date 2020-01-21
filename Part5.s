/* Program that counts consecutive 1’s */
.text
.global _start
_start:
MOV r10, #0
MOV r9, #0 
MOV r8, #0 
MOV r7, #0 
MOV r6, #0 
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
    CMP R1, #-1
    BEQ END // If reaches -1 TEST_NUM then branch to end
    MOV R5, #0 // R5 will hold the result for ones
    BL ONES
    /*Code for trailing and leading*/
    LDR R1, [R3] // reload data word into R1
    MOV R6, #0 // R6 will hold the result for leading
    BL LEADING
    
    LDR R1, [R3] // reload data word into R1
    MOV R7, #0 // R7 will hold the result for trailing
    BL TRAILING
    
    
    CMP R8, R5 //If the new result>old result go to store
    BLT STORE0 //Go to store for ones
    CMP R9, R6 //If the new result>old result go to store
    BLT STORE1 //Go to store for leading
    CMP R10, R7 //If the new result>old result go to store
    BLT STORE2 //Go to store for trailing
    ADD R3, R3, #4 // Shift to next word
	B LOOP
END: B END

STORE0:
    	MOV R8, R5       
   		B EXIT    
STORE1:
    	MOV R9, R6       
   		B EXIT 
STORE2:
    	MOV R10, R7       
   		B EXIT 

ONES:
	LOOP1: CMP R1, #0 // loop until the data contains no more 1’s
        BEQ EXIT
        LSR R2, R1, #1 // perform SHIFT, followed by AND
        AND R1, R1, R2
        ADD R5, #1 // count the string lengths so far
        B LOOP1
        
	EXIT:
    	MOV r2, #0 //reset r2 after shift
    	MOV PC,LR
        
LEADING:
	MOV r6,#0 //Initial number of leading zeros is zero
    MOV r11, #0 // counter
    
    LOOPL: 
    ADD r6,r6,#1 //Increase # of leading every loop
    CMP r11,#31 //Loop until you reach 16 bits
    BEQ EXIT
    AND r2,r1,#1 // Get current digit
    CMP r2,#1//If current digit is a one reset r6 to zero
    BEQ RESET
    LSR r1, r1, #1
    ADD r11, r11, #1
    B LOOPL

RESET:
	MOV r6,#0
    LSR r1, r1, #1
    ADD r11, r11, #1
	B LOOPL

TRAILING:
	MOV r2,#0
	MOV r7,#0// Initial number of trailing zeros is zero
    MOV r11, #0 // counter
    LOOPT: 
    AND r2, r1, #1// get current digit
    CMP r2, #1 // If current digit is 1 then exit
    BEQ EXIT
    ADD r7, #1 
    CMP r11, #31
    BEQ EXIT
    LSR r1, r1, #1 //Shift right one
    ADD r11, r11, #1 // increase counter
    B LOOPT
	
TEST_NUM: .word 0x0f00f000,0x1ffff,-1
.end
