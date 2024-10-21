TITLE PROGRAMA EXEMPLO PARA MANIPULAÇÃO DE VETORES USANDO BX
.MODEL SMALL
.DATA
VETOR DB 1, 1, 1, 2, 2, 2   ;vetor manipulado
.CODE
MAIN PROC
MOV AX, @DATA           ; inicializando ax e ds
MOV DS,AX

XOR DL, DL              ; Zerando DL
MOV CX,6                ; definindo o contador cx
LEA BX, VETOR           ; apontando bx para o vetor
VOLTA:
MOV DL, [BX]            ; move o conteúdo do vetor apontado por bx para dl
INC BX                  ; incrementa bx
ADD DL, 30H             ; transforma em caractere ASCII
MOV AH, 02              
INT 21H                 ; imprime os elementos do vetor
LOOP VOLTA
MOV AH,4CH
INT 21H                 ;saida para o DOS
MAIN ENDP
END MAIN
