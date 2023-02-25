org 100h

.data
   num dw 0   ;number of elements    
   result dw 0
   counter dw 0 
   ten dw 10  
   mean dw 0
   num2 dw 0  ;number of elements
   array dw 100 (?)  
   
.code


main proc near:
  mov ax, @data
  mov ds, ax
        
  call input ;get number of elements
  push num 
  mov bx, num
  mov num2, bx ;num2 is number of elements
  push num2 ;save num2 
  
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
  push ax  ;save mean
  pop result
  call print ;print mean
      
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

   

  
  
  
  
