TITLE Contagem de Bits 1
.MODEL SMALL
.STACK 100h

.DATA
msg1 DB 'Digite um numero (0-9): $'
msg2 DB 0Dh, 0Ah, 'Quantidade de bits 1: $'

.code
main proc
    mov ax,@data
    mov ds,ax

    call leitura

    call contagem

    call impressao

    mov ah,4ch
    int 21h

main endp

leitura proc
    mov ah,09h
    lea dx, msg1
    int 21h

    mov ah,01h
    int 21h
    and al,0fh

ret
leitura endp

contagem PROC
    XOR DL, DL                ; Zera o contador de bits 1 (DL)
    MOV CL, 8                 ; Configura para contar 8 bits
contar_loop:
    SHR AL, 1                 ; Desloca o bit menos significativo para o carry
    JC incrementar            ; Se carry = 1, incrementa DL
    JMP proximo
incrementar:
    INC DL                    ; Incrementa o contador de bits 1
proximo:
    DEC CL                    ; Decrementa contador de bits
    JNZ contar_loop           ; Continua até contar todos os 8 bits

RET
contagem ENDP

impressao PROC
    mov cl,dl

    mov ah,09h
    lea dx, msg2
    int 21h

    mov dl,cl
    mov ah,02h
    or dl,30h
    int 21h

ret
impressao ENDP


end main
