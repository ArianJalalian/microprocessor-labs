
.data 
    num dw 0     
    result dw 0 
    ten dw 10  
    counter dw 0  



main proc near: 
     
    call input ; input first number 
    push num ; save the number        
               
               
               
    mov dx, 10             
    mov ax, 200h  
    int 21h ; print a new line
             
             
             
    call input ; input second number 
    push num ; save the number 
    
    pop ax ; move second num to ax for powering     
    mul ax ; ax * ax for second num 
    
    mov bx, ax ; move low part of product to bx 
     
    pop ax ; move first num to ax for powering     
    mul ax ; ax * ax for first num   
    
    sub ax, bx ; ax = ax - bx 
    jnc print_diffrence ; cf flag is set in previous instruciton
    
    
    call print ; 0 is already in result 
    
    ret
    
    print_diffrence: 
        
        push ax  
        pop result ; result = ax which is the diffrence
          
        call print  
   
     
    ret    
    

main endp 

    

print proc near:           
             
          push ax ; store ax
          push dx ; store dx 
          
          
          
          mov dx, 10             
          mov ax, 200h  
          int 21h ; print a new line
          
          
            
          mov ax, result ; mov result to ax to be numerator
                  
          start_print: 
            
            mov dx, 0 ; empty dx
            div ten ; the remainder will be in dx 
                
            add dx, 48 ; making the ascii code 
            push dx ; save the digit 
            inc counter ; increment the counter
             
            cmp ax, 0 ; compare the quotient to 0 
            jnz start_print ; if it is not 0 repeat 
            
          end_print: 
            
            pop dx ; pop the digit 
            
            mov ax, 200h  
            int 21h ; print  
            
            dec counter ; decrement counter 
            cmp counter, 0 ; all of the digits are printed 
            
            jnz end_print ; repeat if counter != 0 
            
          
          pop dx ; restore dx 
          pop ax ; restore ax
          
                
          ret
          
print endp    

        

input proc near:       
    
    push ax ; saving ax 
    push bx ; saving bx
    
    push 0 ; current num
    
    start_input: 
    
        mov ah, 01h ; setting ah to input
		int	21h ; intrupt to input, result in al
		
		cmp al, 13 ; set zf 1 if al is an enter character  
        jz end_input ; if zero flag is 1 goto end 
        
        sub al, 48 ; ascii - 48 is the actual integer  
        pop bx ; loading current num to bx 
        
        mov ah, 0 ; set ah to 0 
        push ax ; saving the digit 
        
        mov al, 10 ; move 10 to ax for mulplying 
        mul bx ; multiplying current num by 10 and put it in ax
        
        
        pop bx ; popping saved digit back to bx
        
        add ax, bx ; making current num 
        
        push ax ; saving new current num 
          
    
        jmp start_input ; back to start
    
    end_input: 
        
        pop num ; inputed number now is in num     
    
    
    pop bx ; restore bx 
    pop ax ; restore ax  
    
    ret        
        
input endp     







