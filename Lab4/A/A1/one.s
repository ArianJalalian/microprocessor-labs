.data
.balign 4 
	example: .asciz "HelLO wOrLD AGaIn iN MicrOpRoCeEsSoR\0"
	countOfChar: .skip 127				@ use this array to store the repetition of each char
	
.text 
.global main 
	main:
		ldr r0, =example 				@ load example string address to r0
		ldr r4, =example
			
	check_each_char:
		ldr r1, =countOfChar			@ load array address
		ldrb r2, [r0]					@ load each char to r2
		cmp r2, #0  					@ if char == '/0' => string is done 
		beq end_
		cmp r2, '['						@ if char < '[' (char <= 'Z'), check second condition
		blt check_second_condition
		b continue 

	check_second_condition:
		cmp r2, '@'						@ if char > '@' (char >= 'A'), convert to lowercase 
		bgt lower_case 
		b continue 
	
	lower_case: 
		add r2, #32 					@ uppercase char converts to lowercase 
		strb r2, [r0]					@ store lowercase char to example string 
		
	continue:
		add r1, r2 						@ find char in the array
		ldrb r3, [r1]					@ load repetetion of the char
		add r3, #1 
		strb r3, [r1]					@ store the new count 
		add r0, #1						@ go to the next char
		b check_each_char
		
	end_:
		swi 0
	
		