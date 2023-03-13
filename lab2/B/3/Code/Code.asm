.MODEL SMALL
.STACK 64
.DATA
.CODE 

delay proc near 
   
   ; a simple loop that does nothing but iteration 7000h 
   ; times to delay the process by approximatley 1 second
   
   mov bx, 7000h  
   delay_loop: 
      sub bx, 1 
      cmp bx, 0 
      jne delay_loop  
	        
    ret

delay endp



main proc near

	mov ax, @data
	mov ds, ax

	
	mov al, 92h
	out 86H, al ; config 8255
	
	mov al, 0feH 
	out 84H, al ; turn of the LED at first	


	button_is_pushed:  
	 
	    in al, 82H
	    cmp al, 0 ; if it is 0 then button is pushed and is transfering the 0 voltage from gnd
	    jne button_is_pushed 
	
	 get_n:
	
	    in al, 80H
	    mov bl, 11111111B ; input the port A which is connected to dip switch
	    XOR al, bl ; the input is active low so we should invert it
	    MOV cl, al 
	    mov ch, 0 ; cx now is the N presented by dip switch 
	
	jmp blink
	
	

	blink :  
	    
	    
	    mov al, 1
	    out 84h, al ; turn on the LED

	    call delay ; wait 1 second
	
	    mov al, 0
	    out 84h, al ; turn off the LED
	 
	    call delay ; wait 1 second
	  
	    loop blink ; decrement the cx, check if it is not 0 and repeat
	
	jmp button_is_pushed ; job is done
	
	
	infloop: 
	    jmp infloop

main endp
	end main
