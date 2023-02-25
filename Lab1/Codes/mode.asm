org 100h

.data 

array dw 1h,1h,2h,5h,5h,5h,5h,7h,7h,7h
num dw 10 
                           
                           

.code              


calculate_mode proc near: 
    
    ; mov ax, @data
  ;mov ds, ax 
    
    size dw 0
    
    mov ax, num 
    add ax, ax 
    sub ax, 2   
    push ax 
    pop size
    
    
    
    mode dw 0 ; will contain the mode at any stage of iteration 
    ctr dw 1 ; keeps the track of how many times a value is observed
    max dw 0 ; max observation of an element at any stage of iteration 
    
    mov si, 0 ; points to elements of array 
    mov ax, array[si]  
    push ax 
    pop mode ; mode = array[0] 
    
    mov si, 2 ; point to second element
    
    while1: 
        
        push si ; set the paramether 
        push size ; set the paramether 
        
        call is_greater ; result will be in stack      
        pop ax ; result                            
        
        
        sub ax, 1 ; zero flag will be 1 if pointer >= size 
        jnz endwhile1   
        
          
         
        push array[si] ; set the paramether 
        push array[si - 2] ; set the paramether 
        
        call is_equal ; result will be in stack        
        pop ax ; result                                                               
        
        sub ax, 1 ; zero flag will be 1 if the numbers are diffrent 
        jnz else 
        jz if 
        
        
            if: 
                inc ctr  ; increment ctr 
                add si, 2 ; increment ctr  
                jmp while1 ; go back to while
            
            
            else:       
                push max ; set the paramether 
                push ctr ; set the paramether 
        
                call is_greater ; result will be in stack      
                pop ax ; result   
                
                sub ax, 1 ; zero flag will be 1 ctr is greater than max
                jz update1       
                
                push 1 
                pop ctr ; ctr = 1 
                
                add si, 2 ; increment ctr  
                jmp while1 ; go back to while  
                    
                    update1: 
                        push ctr  
                        pop max ; max = ctr 
                        
                        push array[si - 2] 
                        pop mode ; mode = array[i - 1]   
                        
                        push 1 
                        pop ctr ; ctr = 1 
                
                        add si, 2 ; increment ctr  
                        jmp while1 ; go back to while  
                        
      
                           
                          
    endwhile1:             
        
            push max ; set the paramether 
            push ctr ; set the paramether 
        
            call is_greater ; result will be in stack      
            pop ax ; result   
                
            sub ax, 1 ; zero flag will be 1 ctr is greater than max
            jz update2       
            
            push mode ; return mode 
            
            MOV AH, 4CH
            MOV AL, 01 ;your return code.
            INT 21H
            
            update2: 
                push ctr  
                pop max ; max = ctr 
                        
                push array[si - 2] 
                pop mode ; mode = array[i - 1]        
        
            push mode ; return mode 
                
            MOV AH, 4CH
            MOV AL, 01 ;your return code.
            INT 21H
        
        


calculate_mode endp



is_equal proc near: 
    
    ; paramathers are the two top elements in stack 
    ; ( with respect to returning address )
    ; return will be 1 if the numbers are equal and 
    ; will be stored in stack as well 
    
    pop dx ; the returning address 
    
    pop ax ; one of the numbers 
    pop cx ; the other one 
    
    
    sub ax, cx ; the ax will be 0 if ax and cx are equal 
    
    
    jz equal ; equality 
    
    
    push 0 ; return 0 
    push dx ; returning address 
    ret
    
    
    equal: 
        
        push 1 ; return 1  
        push dx ; returning address
        
    ret       

is_equal endp  
          
          
          
is_greater proc near: 
    
    ; paramathers are the two top elements in stack 
    ; return will be 1 if the top one is greater than 
    ; the bottom one, and it will be stored in stack 
    ; as well   
    
    pop dx ; the returning address
      
    pop ax ; first one 
    pop cx ; second one 
    
    
    sub ax, cx ; ax = ax - cx will be a postive number if ax is greater than cx 
    jnc greater ; cf flag is set in previous instruciton
    
    
    push 0 ; return 0 
    push dx ; returning address   
    ret
    
    
    greater: 
        
        push 1 ; return 1 
        push dx ; returning address
    ret
    

is_greater endp

