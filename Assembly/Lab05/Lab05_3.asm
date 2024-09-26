title letras
.model small
.stack 100h

.code
main proc

    ; Exibe todas as letras maiúsculas (A-Z)
    mov cx, 26          ; 26 letras maiúsculas
    mov dl, 'A'         ; Inicia com o caractere 'A'

MaiusculaLoop:
    mov ah, 02h         ; Função para exibir caractere
    int 21h             ; Exibe o caractere em DL
    inc dl              ; Incrementa DL para o próximo caractere
    loop MaiusculaLoopLoop  ; Decrementa CX e repete o loop se CX diferente de 0

    mov dl, 0Dh         
    mov ah, 02h
    int 21h              ; Move para a próxima linha
    mov dl, 0Ah         
    mov ah, 02h
    int 21h

    ; Exibe todas as letras minúsculas (a-z)
    mov cx, 26          ; 26 letras minúsculas
    mov dl, 'a'         ; Inicia com o caractere 'a'

MinusculaLoop:
    mov ah, 02h         ; Função para exibir caractere
    int 21h             ; Exibe o caractere em DL
    inc dl              ; Incrementa DL para o próximo caractere
    loop MinusculaLoop  ; Decrementa CX e repete o loop se CX diferente de 0

    ; Termina o programa
    mov ah, 4Ch         ; Função para encerrar o programa
    int 21h

main endp
end main
