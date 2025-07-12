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
; Permite o acesso �s vari�veis definidas em .DATA
MOV AX,@DATA
MOV DS,AX

; Exibe na tela a string MSG1 (?Digite um caractere: ?)
MOV AH,9
MOV DX,OFFSET MSG1
INT 21h

; L� um caractere do teclado e salva o caractere lido em AL
MOV AH,1
INT 21h
; Copia o caractere lido para BL
MOV BL,AL

; Compara o caractere em BL com o valor 48 (c�digo ASCII do caracter ?0?)
CMP BL,48
; Se o caractere em BL for menor que 48 (?0?), salta para o r�tulo NAOENUMERO
JB NAOENUMERO

; Compara o caractere em BL com o valor 57 (c�digo ASCII do caracter ?9?)
CMP BL,57
; Se o caractere em BL for maior que 57 (?9?), salta para o r�tulo NAOENUMERO
JA NAOENUMERO

; Se o caractere lido estiver no intervalo de 48 a 57, exibe uma mensagem na tela dizendo que o caracter � um n�mero
MOV AH,9
MOV DX,OFFSET SIM
INT 21h
; Salta para o r�tulo FIM
JMP FIM

; Define o r�tulo NAOENUMERO
NAOENUMERO:
; Se o caracter lido n�o estiver em um intervalo entre 48 e 57, exibe uma mensagem na tela dizendo que o caractere n�o � um n�mero
MOV AH,9
MOV DX,OFFSET NAO
INT 21h

; Define o r�tulo FIM
FIM:
; Finaliza o programa
MOV AH,4Ch
INT 21h
main endp
end main

;   RESPOSTA DA PERGUNTA: 
; O programa realiza uma opera��o de compara��o entre o c�digo do caractere lido do teclado do usu�rio
; com os c�digos 48 e 57 da tabela ASCII ( os numeros "0" e "9" ), sendo assim possivel determinar se o caractere digitado
; pelo usu�rio � um n�mero ou n�o, pulando para uma se��o do programa dependendo da resposta da compara��o e imprimindo
; uma mensagem na tela referindo-se ao pertencimento do caractere lido para com o conjunto num�rico da tabela ASCII.

; Labels s�o parecidos com se��es de um programa, por exemplo o r�tulo fim � um conjunto de instru��es que realizam 
; a tarefa de finalizar um programa, sendo assim poss�vel agrupa-las em uma "se��o" que representa o fim do programa.