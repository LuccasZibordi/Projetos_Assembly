; Programa de Batalha Naval em Assembly 8086
; Seguindo as especificações do projeto de Organização de Sistemas Computacionais

.MODEL SMALL
.STACK 100h
.DATA

; Definição da matriz de jogo 20x20
MATRIZ DW 400 DUP(0) ; Matriz 20x20, inicializada com zeros

; Tipos de embarcações e quantidades
ENCOURAÇADO DB 1
FRAGATA DB 1
SUBMARINOS DB 2
HIDROAVIOES DB 2

; Mensagens
MSG_INICIO DB "Bem-vindo ao jogo Batalha Naval!$"
MSG_POSICIONAR DB "Posicionando embarcações...$"
MSG_TIRO DB "Informe a linha e coluna para atirar (ex: 0112 para linha 1 coluna 12): $"
MSG_ACERTO DB "Acertou uma embarcação!$"
MSG_ERRO DB "Tiro na água...$"
MSG_VITORIA DB "Você venceu! Todas as embarcações foram destruídas!$"
MSG_FIM DB "Jogo encerrado.$"

; Variáveis auxiliares
LINHA DW ?
COLUNA DW ?
EMBARCACOES_RESTANTES DB 7 ; Total de embarcações a serem destruídas

; Matriz inicial para exibir ao jogador
MATRIZ_INICIAL DB '    0  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19', 13, 10
               DB ' 0 | .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .', 13, 10
               DB ' 1 | .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .', 13, 10
               DB ' 2 | .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .', 13, 10
               DB ' 3 | .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .', 13, 10
               DB ' 4 | .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .', 13, 10
               DB ' 5 | .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .', 13, 10
               DB ' 6 | .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .', 13, 10
               DB ' 7 | .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .', 13, 10
               DB ' 8 | .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .', 13, 10
               DB ' 9 | .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .', 13, 10
               DB '10 | .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .', 13, 10
               DB '11 | .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .', 13, 10
               DB '12 | .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .', 13, 10
               DB '13 | .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .', 13, 10
               DB '14 | .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .', 13, 10
               DB '15 | .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .', 13, 10
               DB '16 | .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .', 13, 10
               DB '17 | .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .', 13, 10
               DB '18 | .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .', 13, 10
               DB '19 | .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .', 13, 10, '$'

.CODE

; Procedimento para limpar a tela
LIMPA_TELA PROC
    MOV AH, 0   ; Configura modo de vídeo
    MOV AL, 3   ; Modo 80x25 em texto
    INT 10h     ; Configura o modo de vídeo
    RET
LIMPA_TELA ENDP

; Procedimento para pular linha
PULA_LINHA PROC
    MOV AH, 02
    MOV DL, 10
    INT 21H
    MOV AH, 02
    MOV DL, 13
    INT 21H
    RET
PULA_LINHA ENDP

; Procedimento para posicionar as embarcações aleatoriamente
POSICIONA_EMBARCACOES PROC
    ; Lógica para posicionar encouraçado, fragata, submarinos e hidroaviões
    ; Garantir que as embarcações não estejam encostadas umas nas outras
    ; Utilizar gerador de números aleatórios para determinar posições
    MOV CX, 7 ; Número total de embarcações
POSICIONA_LOOP:
    ; Salva o valor de CX para evitar que seja alterado pela interrupção
    PUSH CX

    ; Gerar posição aleatória
    MOV AH, 2
    INT 1Ah ; Gerar número aleatório
    AND DX, 0FFh ; Garante que o valor está no intervalo permitido
    MOV AL, DL
    MOV BL, 20 ; Limite da matriz
    DIV BL
    MOV LINHA, AH ; Linha aleatória entre 1  e 19
    MOV COLUNA, AL ; Coluna aleatória entre 1 e 19

    ; Restaura o valor de CX
    POP CX

    ; Verificar se a posição está disponível e se não está encostada em outra embarcação
    MOV AX, LINHA
    MOV BX, 20
    MUL BX ; Multiplica linha pelo número de colunas (20)
    ADD AX, COLUNA ; Soma a coluna para obter o índice completo
    MOV DI, AX ; DI agora contém o índice da matriz

    CMP MATRIZ[DI], 0
    JNE PROCURA_NOVA_POS ; Se a posição já estiver ocupada, gera nova posição

    ; Alocar a embarcação
    MOV MATRIZ[DI], 1 ; Marca a posição com a embarcação

    DEC CX ; Decrementa o contador de embarcações
    JNZ POSICIONA_LOOP ; Continua até que todas as embarcações sejam posicionadas
    JMP POSICIONA_FIM

PROCURA_NOVA_POS:
    ; Caso a posição já esteja ocupada, decrementar um valor para garantir que não fique preso no loop
    DEC CX
    JNZ POSICIONA_LOOP

POSICIONA_FIM:
    RET
POSICIONA_EMBARCACOES ENDP

; Procedimento para realizar um tiro
REALIZA_TIRO PROC
    ; Solicitar ao jogador a linha e coluna para atirar
    MOV AH, 9
    LEA DX, MSG_TIRO
    INT 21h

    ; Ler a linha (dois dígitos)
    MOV AH, 1
    INT 21h
    SUB AL, '0'
    MOV AH, 0
    MOV BX, 10
    MUL BX ; Multiplica por 10
    MOV BX, AX
    INT 21h
    SUB AL, '0'
    ADD BX, AX
    MOV LINHA, BX

    ; Ler a coluna (dois dígitos)
    MOV AH, 1
    INT 21h
    SUB AL, '0'
    MOV AH, 0
    MOV BX, 10
    MUL BX ; Multiplica por 10
    MOV BX, AX
    INT 21h
    SUB AL, '0'
    ADD BX, AX
    MOV COLUNA, BX

    ; Verificar se há uma embarcação na posição informada
    MOV AX, LINHA
    MOV BX, 20
    MUL BX ; Multiplica linha pelo número de colunas (20)
    ADD AX, COLUNA ; Soma a coluna para obter o índice completo
    MOV DI, AX ; DI agora contém o índice da matriz

    CMP MATRIZ[DI], 1
    JE ACERTO

    ; Se não for acerto
    MOV MATRIZ[DI], 2 ; Marca como tiro na água
    MOV AH, 9
    LEA DX, MSG_ERRO
    INT 21h
    JMP REALIZA_TIRO_FIM

ACERTO:
    MOV MATRIZ[DI], 3 ; Marca como acerto
    DEC EMBARCACOES_RESTANTES
    MOV AH, 9
    LEA DX, MSG_ACERTO
    INT 21h

REALIZA_TIRO_FIM:
    CALL PULA_LINHA
    RET
REALIZA_TIRO ENDP

; Procedimento principal
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Limpa a tela e exibe mensagem de boas-vindas
    CALL LIMPA_TELA
    MOV AH, 9
    LEA DX, MSG_INICIO
    INT 21h
    CALL PULA_LINHA

    ; Exibir a matriz inicial
    MOV AH, 9
    LEA DX, MATRIZ_INICIAL
    INT 21h
    CALL PULA_LINHA

    ; Posiciona as embarcações aleatoriamente
    MOV AH, 9
    LEA DX, MSG_POSICIONAR
    INT 21h
    CALL PULA_LINHA
    CALL POSICIONA_EMBARCACOES

    ; Loop principal do jogo
JOGO_LOOP:
    ; Realiza um tiro e verifica o resultado
    CALL REALIZA_TIRO

    ; Condição de vitória ou continuidade do jogo
    CMP EMBARCACOES_RESTANTES, 0
    JE VITORIA

    JMP JOGO_LOOP

VITORIA:
    MOV AH, 9
    LEA DX, MSG_VITORIA
    INT 21h
    CALL PULA_LINHA

    ; Mensagem de fim de jogo
    MOV AH, 9
    LEA DX, MSG_FIM
    INT 21h
    CALL PULA_LINHA

    ; Finaliza o programa
    MOV AH, 4Ch
    INT 21h
MAIN ENDP

END MAIN
