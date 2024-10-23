TITLE PROGRAMA EXEMPLO PARA MANIPULAÇÃO DE VETORES USANDO SI ou DI
.MODEL SMALL
.DATA
VETOR DB 1, 1, 1, 2, 2, 2
.CODE
MAIN PROC
MOV AX, @DATA       ; inicializa o ax e o ds
MOV DS,AX   
CALL VOLTA          ; chama o procedimento
INT 21H             ;saida para o DOS
MAIN ENDP

VOLTA PROC
XOR DL, DL          ; zera o dl
MOV CX,6            ; define o contador
XOR DI, DI          ; zera di
return:
MOV DL, VETOR[DI]       ; move o conteúdo do vetor com a posição di
INC DI
ADD DL, 30H             ; converte em caractere ASCII
MOV AH, 02
INT 21H                 ; imprime o caractere
LOOP return             ; loop de alocaçao de caracteres
MOV AH,4CH
RET                     ; retorna para a função principal
VOLTA ENDP
END MAIN
