TITLE ATIV2_1.ASM
.MODEL SMALL
.data
    ; Textos utilizados para imprimir na tela
    texto1 db "Digite uma letra minuscula: ","$"
    texto2 db "A letra maiuscula correspondente eh: ", "$"
.CODE
MAIN PROC

; Permnite o acesso do conte�do de .data
MOV AX,@data    ; Copia o conte�do de .data para AX
MOV DS,AX       ; Aponta paea o conte�do de AX

; Exibe o texto1 na tela
mov dx, offset texto1   ; Atribui o texto1 para DX
mov ah,9                ; 9 passa a ser o bit mais significativo de AX
int 21h                 ; Executa o comando 9 e imprime o texto1 na tela

; L� um caracter do teclado e salva o caracter lido em AL
MOV AH,1    ; O bit mais significativo de AX se torna o 1
INT 21h     ; Executa o comando 1 lendo um caractere do teclado

; Copia o caracter lido para BL
MOV BL,AL   ; Copia o conte�do de AL ( o caractere lido no teclado ) para BL
SUB BL,20h  ; Realiza a subtra��o do c�digo do caracter por 20hexadecimal, ou poderia ser por 32 decimal.
            ; O mai�sculo correspondente de um caracter min�sculo sempre � a diferen�a de 32 entre eles

; Exibe o caracter Line Feed ( enter )
MOV AH,2    
MOV DL,10 ; O c�digo da tabela ASC do caracter Line Feed � 10 (0Ah)
INT 21h

; Exibe o caracter Carriage Return (move o cursor para o canto esquerdo da tela)
MOV AH,2
MOV DL,13 ; O c�digo da tabela ASC do caracter Carriage Return � 13 (0Dh)
INT 21h

; Exibe o texto2
MOV DX,offset texto2        ; mesmo processo do texto1
MOV ah,9
INT 21h
; Exibe o caracter lido (salvo em BL)
MOV AH,2        
MOV DL,BL   ; Copia o caractere lido de BL para DL, sendo possivel sua impress�o pelo comando 2 do int 21h
INT 21h

; Finaliza o programa
MOV AH,4Ch  
INT 21h
MAIN ENDP
END MAIN