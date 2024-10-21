TITLE Inversão de Vetores com Procedimentos
.MODEL SMALL
.STACK 100h
.DATA 
    VETOR DB 0, 0, 0, 0, 0, 0, 0 ; Vetor de 7 elementos
    MSG DB "Digite um vetor de 7 posicoes: $"
    MSG2 DB 0Dh, 0Ah, "O vetor invertido eh: $" ; Mensagem com nova linha

.CODE
MAIN PROC
    MOV AX, @DATA    ; Inicializa o segmento de dados AX, DS
    MOV DS, AX

    ; Chama procedimento para leitura do vetor
    CALL LeituraVetor

    ; Chama procedimento para inversão do vetor
    CALL InverterVetor

    ; Chama procedimento para impressão do vetor
    CALL ImprimirVetor

    ; Encerrar o programa
    MOV AH, 4CH
    INT 21H

MAIN ENDP

; Procedimento para ler o vetor
LeituraVetor PROC
    LEA DX, MSG         ; Aponta para a mensagem de entrada
    MOV AH, 09H         ; Função para exibir string (INT 21H)
    INT 21H             ; Imprime a mensagem
    
    XOR BX, BX          ; BX será o índice do vetor
    MOV CX, 7           ; Número de elementos do vetor

leitura:
    MOV AH, 01H         ; Função de leitura de caractere (INT 21H)
    INT 21H             ; Lê um caractere do teclado
    CMP AL, 13          ; Verifica se é 'Enter' (código ASCII 13)
    JE FimLeitura       ; Se for 'Enter', finaliza a leitura

    SUB AL, 30H         ; Converte o caractere de ASCII para valor numérico
    MOV [VETOR + BX], AL; Armazena o valor no vetor

    INC BX              ; Incrementa o índice do vetor
    CMP BX, 7           ; Verifica se já leu 7 elementos
    JB leitura          ; Se não, continua lendo

FimLeitura:
    RET                 ; Retorna ao procedimento principal
LeituraVetor ENDP

; Procedimento para inverter o vetor
InverterVetor PROC
    XOR SI, SI          ; SI aponta para o primeiro elemento (índice 0)
    MOV DI, 6           ; DI aponta para o último elemento (índice 6)

inversao:
    CMP SI, DI          ; Verifica se os ponteiros se cruzaram ou se são iguais
    JAE FimInversao     ; Se SI >= DI, pula para o final da inversão

    MOV AL, [VETOR + SI]; Carrega o valor de VETOR[SI] em AL
    MOV BL, [VETOR + DI]; Carrega o valor de VETOR[DI] em BL

    ; Realiza a troca
    MOV [VETOR + SI], BL; Coloca o valor de DI em SI
    MOV [VETOR + DI], AL; Coloca o valor de SI em DI

    ; Atualiza os ponteiros
    INC SI              ; Incrementa SI (para a próxima posição)
    DEC DI              ; Decrementa DI (para a posição anterior)

    JMP inversao        ; Repetir o processo até inverter todo o vetor

FimInversao:
    RET                 ; Retorna ao procedimento principal
InverterVetor ENDP

; Procedimento para imprimir o vetor
ImprimirVetor PROC
    LEA DX, MSG2        ; Aponta para a mensagem de saida (com nova linha)
    MOV AH, 09H         ; Função para exibir string (INT 21H)
    INT 21H             ; Imprime a mensagem

    MOV CX, 7           ; Número de elementos do vetor (7)
    XOR SI, SI          ; SI aponta para o primeiro elemento

imprimir:
    MOV DL, [VETOR + SI]; Carrega o valor do vetor na posição SI
    ADD DL, 30H         ; Converte o valor numérico para caractere ASCII ('0'-'9')
    MOV AH, 02H         ; Função de saída de caractere (INT 21H)
    INT 21H             ; Imprime o valor

    MOV DL, ' '         ; Imprime espaço para separação
    INT 21H

    INC SI              ; Passa para o próximo elemento
    LOOP imprimir       ; Repete até imprimir todos os elementos

    RET                 ; Retorna ao procedimento principal
ImprimirVetor ENDP

END MAIN
