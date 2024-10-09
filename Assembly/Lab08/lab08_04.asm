title imprime hexa
.model small
.stack 100h

.data
; Sem necessidade de variáveis de dados neste programa

.code
main proc
    mov ax, @data           ; Inicializa o segmento de dados (@data)
    mov ds, ax              ; Carrega o segmento de dados

    mov bx, 1234h           ; Valor hexadecimal a ser exibido
    mov cx, 4               ; 16 bits 

next_digit:
    mov dx, bx              ; Move BX para DX
    and dx, 0F000h          ; Mascara para os 4 bits mais significativos
    shr dx, 12              ; Desloca para a direita 12 bits para deixar os 4 bits consecutivos no final

    cmp dl, 9               ; Verifica se o valor é menor que 10
    jbe convert_to_digit    ; Se sim, converte para caractere '0'-'9'

    add dl, 7               ; Se for maior que 9, ajusta para caracteres 'A'-'F'

convert_to_digit:
    add dl, '0'             ; Converte para caractere ('0'-'9' ou 'A'-'F')
    call print_char         ; Exibe o caractere

    shl bx, 4               ; Desloca BX 4 bits à esquerda para pegar o próximo nibble
    loop next_digit         ; Repete até cx chegar a 0

    mov ah, 4Ch             ; Termina o programa
    int 21h

; Rotina para exibir um caractere na tela
print_char proc
    mov ah, 02h             ; Função de exibir caractere (INT 21h)
    int 21h                 ; Interrupção para exibir DL
    ret
print_char endp

main endp
end main
