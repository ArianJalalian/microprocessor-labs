
.model small  
.stack 64

.code 



keypad_input proc near

	; CONFIG 8255
	mov al, 10000010B
	out 86H, al

	
	two_columns_enabled:
	    mov al, 010B   
	    out 80H, al ; outputing the enable two cols
	    in al, 82H ; inputing from rows
		
	    cmp al, 11111111B ; if it is all 1s then no button is pressed
	    je middle_column_enabled ; the middle column contains the selected button 
	    
	    cmp al, 11111101B ; check if the second button is selected 
	    je handling_the_even 
		
	    jmp handling_the_odd
	
	
	
	middle_column_enabled:
		mov al, 101B
		out 80H, al ; outputing the enable middle col 
		
		in al, 82H ; input from rows
		
		
		cmp al, 11111111B ; if it is all 1s then no button is pressed
		je two_columns_enabled ; the other columns contains the selected button
		
		cmp al, 11111101B ; check if the second button is selected  
		je handling_the_odd 
		
		jmp handling_the_even
	
	handling_the_odd: 
		mov bx, 1h ; if it is odd then 1 is stored
		mov ds:[8], bx
		ret
	handling_the_even: 
		mov bx, 2h ; if it is even then 2 is stored
		mov ds:[8], bx
		ret

keypad_input endp



  
cpy proc near  
    
    mov cx, 10   ;10 transfer needed
    mov si, 0 ;set source index 
    mov di, 0 ;set destination index
    
    loop1:
      mov ax, 2800h  ;set datasegment for read data from rom
      mov ds, ax
      mov dx, [si]         ;read and move data from rom to dx 
      ;;;;;;;;
      ;mov dx, 6754h   ;testing
      ;;;;;;;;;;;
      mov ax, 3800h  ;set datasegment for write data to ram
      mov ds, ax
      mov [di], dx         ;move data in dx to ram

      
      inc di   ;incease di 
      inc di
      inc si   ;increase si
      inc si
      
      dec cx    ;decrease the number of transfer needed
      cmp cx, 0 ;if number of transfers equals to 0, exit the loop
      jnz loop1
    ret
cpy endp


invcpy proc near 
    
    mov cx, 10 ;10 transfer needed
    mov si, 18 ;set source index
    mov di, 0 ;set destination index
    
    loop2:
      mov ax, 2800h  ;set datasegment for read data from rom
      mov es, ax
      mov dx, es:[si]
      mov ds:[di], dx
      
      inc di
      inc di
      dec si
      dec si
      
      dec cx
      cmp cx, 0
      jnz loop2
    ret
    
invcpy endp 


main proc near   


      mov ax, 3800h ; the starting address for ram
      mov ds, ax
	  
      mov bx, 0 
      mov ds:[8], bx ; proteus bug
  
       
       
      mainL:  
      
	 call keypad_input
      
	 cmp bx, 2h ; if it is even then cpy
	 je isEven 
      
      
	 isOdd : 
	    call invcpy 
	 jmp mainL
      
	 isEven : 
	    call cpy 
	 
     
      
      jmp mainL ; the infinite loop
	 
     
      
      
    ret
main endp
      end main