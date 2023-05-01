	area partaq1, code, readonly
		entry
		export __main
__main

	mov r0, #15  
	mov r1, #2  
	mov r10, #0
	mov r6, #2	

checkIsPrime
	cmp r1, r0  
	bgt theEnd 
	
	mov r2, #2 
	mov r7, #1
	
loop0
	cmp r2, r1  
	beq endloop0 
	
    ; check prime here
	sdiv r3, r1, r2  
	mul r4, r3, r2   
	sub r5, r4, r1  
	cmp r5, #0      
	bne endloop1
		
	mov r7, #0   
	b endloop0  
					
endloop1
	add r2, #1 
	b loop0 
		
endloop0
	cmp r7, #0 
	beq check_again  
	
	
	
	push {r1}
	mov r6, #2	 
	
loop2 
	mul r10,r1,r6         
	cmp r10,r0                  
	bge check_again             
	push {r10}                  
	add r6,#1                 
	b loop2
	
check_again
	add r1, #1    
	b checkIsPrime  

	
		
theEnd

loop b loop
	end