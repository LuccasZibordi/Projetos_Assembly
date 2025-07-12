TITLE impressao de matriz
model small
.stack 100h
.data
    MATRIZ4X4 DB 1, 2, 3, 4
              DB 4, 3, 2, 1
              DB 5, 6, 7, 8
              DB 8, 7, 6, 5

.code
main proc
    mov ax, @data
    mov ds, ax
    
    ; Chama o procedimento para imprimir a matriz
    call imprimematriz

    ; Encerrar o programa
    mov ax, 4C00h
    int 21h
main endp

; Procedimento para imprimir a matriz 4x4
imprimematriz proc
    xor si, si         ; SI = índice da linha
    xor bx, bx         ; BX = índice da coluna

    mov cx, 4          ; Número de linhas
proximalinha:
    push cx            ; Salva o contador de linhas

    mov cx, 4          ; Número de colunas
proximacoluna:
    ; Acessa o elemento MATRIZ4X4[SI + BX] e imprime
    mov al, MATRIZ4X4[si + bx]
    mov dl, al
    add dl, '0'        ; Converte para ASCII
    mov ah, 2
    int 21h; Imprime o valor do elemento
    mov dl, ' '
    mov ah, 2
    int 21h   ; Imprime um espaço entre os valores

    inc bx             ; Incrementa o índice da coluna
    loop proximacoluna

    ; Imprime uma nova linha
    mov dl, 0Dh
    mov ah, 2
    int 21h
    mov dl, 0Ah
    int 21h

    pop cx             ; Restaura o contador de linhas
    add si, 4          ; Próxima linha (4 elementos por linha)
    xor bx, bx         ; Reseta o índice da coluna
    loop proximalinha

    ret
imprimematriz endp

end main

