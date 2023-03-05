.model small  
.stack 64

.code

main proc near  
    
    mainL :
      
      call cpy ;call cpy to tranfer data from ROM to RAM
      
       
      
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
    

