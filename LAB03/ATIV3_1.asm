TITLE Numero

.MODEL SMALL
.STACK 100h
.DATA
; Variaveis utilizadas no programa
MSG1 DB "Digite um caractere: $"
SIM DB 10,13, "O caractere digitado e um numero.$"
NAO DB 10,13, "O caractere digitado nao e um numero.$"

.CODE
MAIN PROC
; Permite o acesso às variáveis definidas em .DATA
MOV AX,@DATA
MOV DS,AX

; Exibe na tela a string MSG1 (?Digite um caractere: ?)
MOV AH,9
MOV DX,OFFSET MSG1
INT 21h

; Lê um caractere do teclado e salva o caractere lido em AL
MOV AH,1
INT 21h
; Copia o caractere lido para BL
MOV BL,AL

; Compara o caractere em BL com o valor 48 (código ASCII do caracter ?0?)
CMP BL,48
; Se o caractere em BL for menor que 48 (?0?), salta para o rótulo NAOENUMERO
JB NAOENUMERO

; Compara o caractere em BL com o valor 57 (código ASCII do caracter ?9?)
CMP BL,57
; Se o caractere em BL for maior que 57 (?9?), salta para o rótulo NAOENUMERO
JA NAOENUMERO

; Se o caractere lido estiver no intervalo de 48 a 57, exibe uma mensagem na tela dizendo que o caracter é um número
MOV AH,9
MOV DX,OFFSET SIM
INT 21h
; Salta para o rótulo FIM
JMP FIM

; Define o rótulo NAOENUMERO
NAOENUMERO:
; Se o caracter lido não estiver em um intervalo entre 48 e 57, exibe uma mensagem na tela dizendo que o caractere não é um número
MOV AH,9
MOV DX,OFFSET NAO
INT 21h

; Define o rótulo FIM
FIM:
; Finaliza o programa
MOV AH,4Ch
INT 21h
main endp
end main

;   RESPOSTA DA PERGUNTA: 
; O programa realiza uma operação de comparação entre o código do caractere lido do teclado do usuário
; com os códigos 48 e 57 da tabela ASCII ( os numeros "0" e "9" ), sendo assim possivel determinar se o caractere digitado
; pelo usuário é um número ou não, pulando para uma seção do programa dependendo da resposta da comparação e imprimindo
; uma mensagem na tela referindo-se ao pertencimento do caractere lido para com o conjunto numérico da tabela ASCII.

; Labels são parecidos com seções de um programa, por exemplo o rótulo fim é um conjunto de instruções que realizam 
; a tarefa de finalizar um programa, sendo assim possível agrupa-las em uma "seção" que representa o fim do programa.