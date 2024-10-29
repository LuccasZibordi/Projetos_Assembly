TITLE imprime binário
.MODEL SMALL
.STACK 100H
.DATA
   MSG1 DB 'Entre com um numero decimal (entre 0 e 9): $'
   MSG2 DB 0DH, 0AH, 'O valor binario correespondente eh: $'
    CR DB 13 ; Carriage Return (Enter)
.CODE
main PROC
    mov ax,@DATA
    mov ds,ax

    mov ah,09H
    lea dx, MSG1
    int 21H

    cmp al,0dh
    je impressao

    rol bx,1
    or bx,al


    leitura:






main ENDP