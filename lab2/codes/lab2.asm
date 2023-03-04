.model small  
.stack 64

.code

main proc near  
    
    mainL :
      
      call invcpy
      
      jmp mainL
     
      
      
    ret
main endp
    

     

cpy proc near  
    
    mov cx, 10   ;10 transfer needed
    mov si, 0 ;set source index 
    mov di, 0 ;set destination index
    
    loop1:
      mov ax, 2800h  ;set datasegment for read data from rom
      mov ds, ax
      mov dx, [si]         ;read and move data from rom to dx 
      
      mov ax, 1800h  ;set datasegment for write data to ram
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
      mov ds, ax
      mov dx, [si]

      mov ax, 1800h
      mov ds, ax
      mov [di], dx
      
      inc di
      inc di
      dec si
      dec si
      
      dec cx
      cmp cx, 0
      jnz loop2
    ret
    
invcpy endp