TITLE Mensagens
.MODEL SMALL
.DATA
;Dados utilizados no programa, neste caso as mensagens 1 e 2
MSG1 DB "Mensagem 1.$"
MSG2 DB 10,13,"Mensagem 2.$" ; DB = Define Bit

.CODE
;Começa a parte principal do programa
MAIN PROC

; Permite o acesso às variáveis definidas em .DATA
MOV AX,@DATA ;move as mensagens para AX, sendo os primeiros 2bits AH e os outros 2 AL
MOV DS,AX    ;copia o conteúdo de AX para DS

; Exibe na tela a string MSG1
MOV AH,9        ; Coloca o 9 no bit mais significativo de AX
LEA DX,MSG1     ; Igual ao mov dx,offset msg1
INT 21h         ; Procura a diretriz 9 em sua "biblioteca" para executa-lo

; Exibe na tela a string MSG2
MOV AH,9        ; Mesmo processo do anterior
LEA DX,MSG2     ; Pega a mensagem apontada por DS.
INT 21h

; Finaliza o programa
MOV AH,4Ch      ; Move o "4c" para o bit mais significativo de AX
INT 21h         ; Executa a função 4ch para finalizar a leitura e execução do cósigo principal
MAIN ENDP       ; Indica uma finalização para a seção de "procedure" do main
END MAIN

; DS = Registrador de segmento
