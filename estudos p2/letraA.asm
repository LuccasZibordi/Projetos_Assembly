TITLE Quantas letras a tem
.model small
.stack 100h
.data 
    vetor db 20 dup (0)
    msg db 13,10,"Digite um numero do vetor: $"
    msg_saida db 13,10, "A quantidade de (A) no vetor eh: $"
.code
main proc
    mov ax,@data
    mov ds, ax
   
   call leitura
   call contador
   call impressao 

mov ah,4ch
int 21h
main endp 

leitura:
xor bx,bx
mov cx, 20

mov ah,09h
lea dx, msg
int 21h

mov ah,01h
loopdeleitura proc
   int 21h
   cmp al,0Dh
   je fim
   mov vetor[bx],al
   inc bx
   loop loopdeleitura
   fim:
   ret
loopdeleitura endp

contador PROC
   xor bx,bx
   xor ax,ax
   mov cx,20

   contagem:
      mov dl, vetor[bx]
      cmp dl,'a'
      je incrementa
      cmp dl, 'A'
      jne continua
      incrementa:
      inc ax
      continua:
      inc bx
      loop contagem

   ret
contador ENDP

impressao PROC
   xor cx,cx
   mov cx, ax
   mov ah,09h
   lea dx, msg_saida
   int 21h

   mov ah,02h
   mov dx,cx
   or dl,30h
   int 21h

  ret 
impressao ENDP


end main