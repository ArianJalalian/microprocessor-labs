
.data 
    num dw 0


input proc near:       
    
    push ax ; saving ax 
    push bx ; saving bx
    
    push 0 ; current num
    
    start: 
    
        mov ah, 01h ; setting ah to input
		int	21h ; intrupt to input, result in al
		
		cmp al, 13 ; set zf 1 if al is an enter character  
        jz end ; if zero flag is 1 goto end 
        
        sub al, 48 ; ascii - 48 is the actual integer  
        pop bx ; loading current num to bx 
        
        mov ah, 0 ; set ah to 0 
        push ax ; saving the digit 
        
        mov al, 10 ; move 10 to ax for mulplying 
        mul bx ; multiplying current num by 10 and put it in ax
        
        
        pop bx ; popping saved digit back to bx
        
        add ax, bx ; making current num 
        
        push ax ; saving new current num 
          
    
        jmp start ; back to start
    
    end: 
        
        pop num ; inputed number now is in num     
    
    
    pop bx ; restore bx 
    pop ax ; restore ax        
        
input endp     
    
    

ret




