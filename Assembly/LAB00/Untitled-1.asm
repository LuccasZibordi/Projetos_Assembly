Title impressão de string
.model small
.data
    ; Textos que vão ser impressos na tela.
    texto1 db"When i met you in ther summer",10,13
    texto2 db"To my hot beach salt",10,13
    texto3 db"We fell in love", "$"

.code
main proc

; Permição para acessar o conteúdo de .data
mov ax,@data
mov ds,ax

; Imprime todos os textos salvos em .data na tela
mov dx, offset texto1
mov ah,9
int 21h
mov dx, offset texto2
int 21h
mov dx, offset texto3
int 21h

; Finaliza o programa
mov ah,4ch
int 21h
main endp
end main