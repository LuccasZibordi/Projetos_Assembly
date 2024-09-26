.model small
.stack 100h
.data

.code
main proc
    mov ax, @data
    mov ds, ax

    ; Primeiro loop: exibe '*' 50 vezes na mesma linha
    mov cx, 50          ; Define o contador do loop para 50

PrimeiroLoop:
    mov dl, '*'         ; Caractere a ser exibido
    mov ah, 02h         ; Função DOS para exibir caractere
    int 21h             ; Chama a interrupção do DOS
    loop PrimeiroLoop   ; Decrementa CX e salta se CX != 0

    mov dl, 0Dh         
    mov ah, 02h
    int 21h             ; Move para a próxima linha
    mov dl, 0Ah        
    mov ah, 02h
    int 21h

    mov cx, 50          ; Redefine o contador do loop para 50

    ; Segundo loop: exibe '*' 50 vezes, um em cada linha
SegundoLoop:
    mov dl, '*'         ; Caractere a ser exibido
    mov ah, 02h         ; Função para exibir caractere
    int 21h

    ; Move para a próxima linha após cada '*'
    mov dl, 0Dh         
    mov ah, 02h
    int 21h
    mov dl, 0Ah         
    mov ah, 02h
    int 21h

    loop SegundoLoop    ; Decrementa CX e salta se CX for diferente de 0

    ; Termina o programa 
    mov ah, 4Ch         ; Função para encerrar o programa
    int 21h

main endp
end main
