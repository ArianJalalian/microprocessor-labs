.model small  
.stack 64

.code

main proc near  
    
    mainL :
      
      
      
      call invcpy ;call invcpy to tranfer data from ROM o RAM in revers 
      
      jmp mainL
     
      
      
    ret
main endp


invcpy proc near 
    
    mov cx, 10 ;10 transfer needed
    mov si, 18 ;set source index
    mov di, 0 ;set destination index
    
    loop2:
      mov ax, 2800h  ;set datasegment for read data from rom
      mov ds, ax
      mov dx, [si]
      ;;;;;;;;
      ;mov dx, 6754h   ;testing
      ;;;;;;;;;;;
      mov ax, 3800h
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