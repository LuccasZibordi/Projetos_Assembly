    TITLE ATIV2_2
    .MODEL SMALL ; Modelo da mem�ria
    .data
; Textos utilizados ao longo do programa
        texto1 db "Digite um numero entre 0 e 9: ","$"
        texto2 db "Digite um segundo numero entre 0 e 9: ", "$"
        texto3 db "A soma entre os numeros eh: ","$"

; Come�o do c�digo
    .CODE
    MAIN PROC ;Come�o da se��o principal do programa

; Acessando o conte�do de .data
        MOV AX,@DATA
        MOV DS,AX

; Imprimindo o texto 1 na tela
        MOV DX, OFFSET texto1
        MOV AH,9
        INT 21h

; Lendo um caractere do teclado
        MOV AH,1
        INT 21h
        SUB AL,'0' ; Subtraindo o caractere "0" para transformar o n�mero na tabela ASCII
        MOV BL,AL

; Exibe o caracter Line Feed ( enter )
        MOV AH,2    
        MOV DL,10 ; O c�digo da tabela ASC do caracter Line Feed � 10 (0Ah)
        INT 21h

; Exibe o caracter Carriage Return (move o cursor para o canto esquerdo da tela)
        MOV AH,2
        MOV DL,13 ; O c�digo da tabela ASC do caracter Carriage Return � 13 (0Dh)
        INT 21h

; Imprimindo o texto 2 na tela
        MOV DX,OFFSET texto2
        MOV AH,9
        INT 21h

; Lendo um caractere do teclado
        MOV AH,1
        INT 21h
        SUB AL,'0' ;Subtraindo o caracter "0" do n�mero lido para transforma-lo na tabela ASCII
        MOV CL,AL

; Soma dos n�meros lidos do teclado
        ADD BL,CL
        ADD BL,'0' ; Retransforma em n�mero ap�s somar o caractere "0"

; Exibe o caracter Line Feed ( enter )
        MOV AH,2    
        MOV DL,10 ; O c�digo da tabela ASC do caracter Line Feed � 10 (0Ah)
        INT 21h

; Exibe o caracter Carriage Return (move o cursor para o canto esquerdo da tela)
        MOV AH,2
        MOV DL,13 ; O c�digo da tabela ASC do caracter Carriage Return � 13 (0Dh)
        INT 21h
        
; Imprimindo o texto 3 na tela
        MOV DX, OFFSET texto3
        MOV AH,9
        INT 21h

; Exibe o caracter somado (salvo em BL)
        MOV AH,2   
        MOV DL,BL   ; Copia o caractere lido de BL para DL, sendo possivel sua impress�o pelo comando 2 do int 21h
        INT 21h

; Finalizando o programa
   MOV AH,4Ch
   INT 21h
   MAIN ENDP
   END MAIN