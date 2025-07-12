MODEL SMALL
.DATA
VETOR DB 1, 1, 1, 2, 2, 2 ; Vetor manipulado
.CODE
MAIN PROC
MOV AX, @DATA           ; iniciando ax e ds
MOV DS,AX
CALL VOLTA              ; chama o procedimento
INT 21H                 ; saida para o DOS
MAIN ENDP

VOLTA PROC
XOR DL, DL              ; zera dl
MOV CX,6                ; define o contador
XOR BX, BX              ; zera bx
return:
MOV DL, VETOR[BX]       ; move o conteúdo do vetor na posição bx para dl
INC BX                  ; incrementa bx
ADD DL, 30H             ; converte em caractere ASCII
MOV AH, 02
INT 21H                 ; imprime o caractere
LOOP return
MOV AH,4CH
RET                     ; retorna pra a função principal
VOLTA ENDP
END MAIN
