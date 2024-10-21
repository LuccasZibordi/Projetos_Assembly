TITLE PROGRAMA EXEMPLO PARA MANIPULAÇÃO DE VETORES USANDO SI ou DI
.MODEL SMALL
.DATA
VETOR DB 1, 1, 1, 2, 2, 2
.CODE
MAIN PROC
MOV AX, @DATA      ; inicializa o ax e ds
MOV DS,AX
XOR DL, DL         ; zera dl
MOV CX,6           ; define o contador
LEA SI, VETOR      ; acessa o vetor pelo si
VOLTA:
MOV DL, [SI]       ; move o conteúdo do vetor acessado por si para dl
INC SI
ADD DL, 30H        ; converte em caractere ASCII
MOV AH, 02
INT 21H            ; imprime os elementos do vetor
LOOP VOLTA
MOV AH,4CH
INT 21H ;saida para o DOS
MAIN ENDP
END MAIN
