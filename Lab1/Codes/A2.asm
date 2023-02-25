.model small
.stack 64

.data
    array dw 10h,20h,4h,8h,30h,1h  ;writing unstored numbers in array  
    size dw 6

.code

main:
  
  mov ax,@data
  mov ds,ax
  
  ;use insertionSort
  mov cx, 2 ;setting cx to second index 
  
  for:
    mov dx, cx ;number of comparison needed, dx = cx - 1
    dec dx
    mov si, dx
    add si, si
    mov ax, array[si] ;ax is key, key = array[i]  
    
    while:
      cmp array[si - 2], ax ;if key <= array[j], exit the loop
      jbe endwhile
      
      mov di, array[si - 2] ;setting di to array[j]
      mov array[si], di ;array[j + 1] = array[j]
      
      dec si  ;next element
      dec si
      jnz while
      
    endwhile:
      mov array[si], ax  ;key = array[j + 1]
      inc cx             ;increase i
      cmp cx, size       ;if i >= 6, exit the loop 
      jbe for        
      
  endfor: 
    mov ah, 4ch  ;exit
    int 21h
    
    
end main
    
