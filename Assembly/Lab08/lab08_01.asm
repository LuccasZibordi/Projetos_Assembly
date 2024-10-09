Title Ler binario
.model small
.stack 100H
.data
msg db 10,13, "Digite um numero em binario (maximo 16 bits): $" ;mensagem a ser exibida na tela pulando linha

.code
main proc
    mov ax,@data    ;inicializa o segmento de dados
    mov ds, ax

    xor bx,bx       ; zera o BX

    mov ah, 09h
    lea dx, msg     ;imprime a mensagem em @data
    int 21h

    mov ah,01H      ; move a função 01 da int 21h para ah, responsavel por ler um caractere do teclado

leitura:
int 21h             ; valida a função 01h
cmp al, 13          ; compara com CR se for igual pula para o fim do programa
je fim
and al, 0fh         ; Converte o valor lido para caractere
shl bx, 1           ; Move o BX para a esquerda em uma unidade
or bl, al           ; adiciona o caractere lido em al em bx
jmp leitura         ; loop

fim:
mov ah,4CH
int 21h

main endp
end main