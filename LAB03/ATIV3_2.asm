 TITLE COMPARAÇÕES     
.MODEL SMALL
.STACK 100h
.DATA
; Variaveis utilizadas no programa
MSG1 DB "Digite um caractere: $"
NUM DB 10,13, "O caractere digitado e um numero.$"
LET DB 10,13, "O caractere digitado e uma letra.$"
DES DB 10,13, "O caractere digitado e desconhecido.$"
.CODE
MAIN PROC

; Permite o acesso às variáveis definidas em .DATA
MOV AX,@DATA
MOV DS,AX

; Exibe na tela a string MSG1 ("Digite um caractere: ")
MOV AH,9
MOV DX,OFFSET MSG1
INT 21h

; Lê um caractere do teclado e salva o caractere lido em AL
MOV AH,1
INT 21h
; Copia o caractere lido para BL
MOV BL,AL

; Compara o caractere em BL com o valor 48 (código ASCII do caracter "0")
CMP BL,48
; Se o caractere em BL for menor que 48 ("0"), salta para o rótulo desconhecido
JB desconhecido

; Compara o caractere em BL com o valor 57 (código ASCII do caracter "9")
CMP BL,57
; Se o caractere em BL for maior que 57 ("9"), salta para o rótulo ehletra
JA ehletra

; Se estiver no intervalo de 48 a 57, exibe uma mensagem na tela dizendo que o caracter é um número
MOV AH,9
MOV DX,OFFSET NUM
INT 21h
; Salta para o rótulo FIM
JMP FIM

; Define o rótulo ehltera
ehletra:
;compara com o valor 65 ( código ASCII do caractere "A")
CMP BL,65
; Se o caractere em BL for menor que 65 ("A"), salta para o rótulo desconhecido
JB desconhecido
;compara com o valor 90 ( código ASCII do caractere "Z" )
CMP BL,90
; Se o caractere em BL for maior que 90 ("Z"), salta para o rótulo minuscula
JA minuscula

; Se estiver no intervalo de 65 e 90, exibe uma mensagem na tela dizendo que o caracter é uma letra 
MOV AH,9
MOV DX,OFFSET LET
INT 21h
; Salta para o rótulo FIM
JMP FIM

; Define o rótulo minuscula
minuscula:
;compara com o valor 97 ( código ASCII do caractere "a" )
CMP BL,97
; Se o caractere em BL for menor que 97 ("a"), salta para o rótulo desconhecido
JB desconhecido
;compara com o valor 122 ( código ASCII do caractere "z")
CMP BL,122
; Se o caractere em BL for maior que 122 ("z"), salta para o rótulo desconhecido
JA desconhecido

; Se estiver no intervalo de 97 a 122, exibe uma mensagem na tela dizendo que o caracter é uma letra
MOV AH,9
MOV DX,OFFSET LET
INT 21h
; Salta para o rótulo FIM
JMP FIM

; Define o rótulo desconhecido 
desconhecido:

; Exibe na tela dizendo que o caractere é desconhecido
MOV AH,9
MOV DX,OFFSET DES
INT 21h

; Define o rótulo FIM
FIM:
; Finaliza o programa
MOV AH,4Ch
INT 21h
main endp
end main

; o rótulo "desconhecido" engloba tudo oq estiver fora dos intervalos definidos nos outros rótulos.