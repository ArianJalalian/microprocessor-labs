.model small
.stack 64

.code

main proc near
    
    mainL :
      
      call cpy2
      
      jmp mainL
    
    ret
main endp  


cpy2 proc near
    
    mov cx, 10   ;10 transfer needed
    mov si, 0 ;set source index 
    mov di, 0 ;set destination index 
    
    loop1:
      mov ax, 2800h  ;set datasegment for read data from rom
      mov ds, ax 
      mov dx, [si]         ;read and move data from rom to dx 
      ;dl has odd part, dh has even part
      mov dx, 2345h  
      mov [si], dx
      mov ax, 1800h  ;set datasegment for write data to ram
      mov ds, ax
      mov [di], dh         ;move high part(even) from dh to even address 
      mov [di + 1], dl     ;move low part(odd) from dl to odd address
      
      inc di   ;incease di 
      inc di
      inc si   ;increase si
      inc si
      
      dec cx    ;decrease the number of transfer needed
      cmp cx, 0 ;if number of transfers equals to 0, exit the loop
      jnz loop1
    ret 
    
cpy2 endp    
    
    
    