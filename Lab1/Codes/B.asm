org 100h

.data
   num dw 0   ;number of elements    
   result dw 0
   counter dw 0 
   ten dw 10  
   mean dw 0
   array dw 100 (?)   
   
.code


main proc near:
      mov ax, @data
      mov ds, ax
        
  call input ;get number of elements
  push num 
  mov bx, num 
  
  mov dl, 10             
  mov ah, 02h  
  int 21h ; print a new line 
  
  xor si, si ;index of array, i = 0
  mov bx, num ;bx is number of elements      
  
  xor cx, cx ;counter
  loop1:
    call input ;get input
    push num
    pop ax
    add mean, ax  ;calculate sum of elements for mean
    mov array[si], ax ;array[i] = input
    inc si  ;i++
    inc si
    inc cx  ;counter++
    mov dx, 10             
    mov ax, 200h  
    int 21h ; print a new line 
    
    cmp cx, bx ;if cx >= num, exit the loop1
    jl loop1
  

  call insertionSort  ;sort the unsorted array
  
    
  xor si, si ;index of array, i = 0  
  xor cx, cx ;counter
  loop2:
    mov ax, array[si] ;ax = array[i]
    push ax
    pop result
    call print ;print array[i]
    
    inc si  ;i++
    inc si 
    inc cx
    cmp cx, bx ;if cx >= num, exit the loop1
    jl loop2
  
     
  ;calculate mean 
  mov ax, mean
  div bl   ;mean = sum of elements / number of elements => ax = ax / bl  
  mov ah, 0
  push ax  ;save mean
  pop result
  call print ;print mean  
  
  call calculate_mode   
  pop result ; result = mode  
  call print
               
               
               
               
   MOV AH, 4CH
   MOV AL, 01 ;your return code.
   INT 21H             
               
  ret
main endp   
    

  
insertionSort proc near: 
    mov cx, 2 ;setting cx to second index 
    
    for:
    mov si, cx ;number of comparison needed, si = cx - 1
    dec si
    add si, si
    mov ax, array[si] ;ax is key, key = array[i]  
    
    while:
      cmp array[si - 2], ax ;if key <= array[j], exit the loop
      jbe endwhile
      
      cmp si, 1
      jbe endwhile
      
      mov di, array[si - 2] ;setting di to array[j]
      mov array[si], di ;array[j + 1] = array[j]
      
      dec si  ;next element
      dec si
      jnz while
      
    endwhile:
      mov array[si], ax  ;key = array[j + 1]
      inc cx             ;increase i  
      cmp cx, bx
      jbe for        
      
    endfor: 
    
    
    
    
    
    ret
insertionSort endp 



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



calculate_mode proc near:  
    
          
    address dw 0
    
    pop address ; returning address  
    
    
    last dw 0 ; last index in bytes
    
    mov ax, bx 
    add ax, ax 
    sub ax, 2  
    push ax 
    pop last ; last index in bytes = 2 * size - 2 
    
    
    
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
        push last ; set the paramether 
        
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
                jz update       
                
                push 1 
                pop ctr ; ctr = 1 
                
                add si, 2 ; increment ctr  
                jmp while1 ; go back to while  
                    
                    update: 
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
            push address ; returning address 
            
            ret
            
            update2: 
                push ctr  
                pop max ; max = ctr 
                        
                push array[si - 2] 
                pop mode ; mode = array[i - 1]        
        
            push mode ; return mode 
            push address ; returning address 
                
            ret
        


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

