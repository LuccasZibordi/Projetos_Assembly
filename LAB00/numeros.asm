Title imprimir numeros
.model small
.code

main proc

; Atribuindo o caractere 0 para dl e imprimindo um enter (10 na tabela ASC)
mov cx,10
mov dl,30h
mov ah,2

; Criando uma "função" para realizar um loop, copiando dl para bl, imprimindo-o e incrementando +1 para dl
imprime:
int 21h
mov bl,dl
mov dl,20h
int 21h
mov dl,bl
inc dl

; Efetuando o loop e encerrando o programa
loop imprime
mov ah,4ch
int 21h

main endp
end main