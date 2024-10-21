MODEL SMALL
.DATA
VETOR DB 1, 1, 1, 2, 2, 2 ; Vetor manipulado
.CODE
MAIN PROC
MOV AX, @DATA           ; iniciando ax e ds
MOV DS,AX
XOR DL, DL              ; zera dl
MOV CX,6                ; define o contador
XOR BX, BX              ; zera bx
VOLTA:
MOV DL, VETOR[BX]       ; move o conteúdo do vetor na posição bx para dl
INC BX                  ; incrementa bx
ADD DL, 30H             ; converte em caractere ASCII
MOV AH, 02
INT 21H                 ; imprime o caractere
LOOP VOLTA
MOV AH,4CH
INT 21H ;saida para o DOS
MAIN ENDP
END MAIN
