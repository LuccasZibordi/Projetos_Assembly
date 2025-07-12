TITLE Eco
.MODEL SMALL
.CODE
;Come�o da parte principal do programa
MAIN PROC

; Exibe o caracter "?" na tela
MOV AH,2    ; O 2 � uma fun��o que imprime especificamente o conte�do de DL
MOV DL,"?"  ; O caracter ? � alocado em DL
INT 21h

; L� um caracter do teclado e salva o caracter lido em AL
MOV AH,1    ;Le um caracter do teclado
INT 21h

; Copia o caracter lido para BL
MOV BL,AL   ; Copia o conte�do de AL ( o caractere lido do teclado ) para BL

; Exibe o caracter Line Feed (move o cursor para a linha seguinte)
MOV AH,2   ; imprime DL
MOV DL,10 ; O c�digo ASC do caracter Line Feed � 10 (0Ah)
INT 21h

; Exibe o caracter Carriage Return (move o cursor para o canto esquerdo da tela)
MOV AH,2  ; Imrpime DL
MOV DL,13 ; O c�digo ASC do caracter Carriage Return � 13 (0Dh)
INT 21h

; Exibe o caracter lido (salvo em BL)
MOV AH,2    ;Imprime DL
MOV DL,BL   ; Copia o conte�do de BL em DL
INT 21h

; Finaliza o programa
MOV AH,4Ch  ; Aloca o comando 4c no bit mais significativo de AX
INT 21h     ; Procura o 4c em seus comandos e executa o mesmo, finalizando o programa
MAIN ENDP
end main
