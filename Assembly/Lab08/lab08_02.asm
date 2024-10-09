.MODEL SMALL
.STACK 100H
.DATA
   MSG1 DB 'Entre com um numero decimal (entre 0 e 9): $'
   MSG2 DB 0DH, 0AH, 'O valor binario correespondente eh: $'
    CR DB 13 ; Carriage Return (Enter)
.CODE
main proc
    ; Acessa os conteúdos armazenados em @data
    MOV AX, @DATA
    MOV DS, AX

    ; Exibir mensagem 1
    MOV AH, 09H
    LEA Dx, MSG1
    INT 21H

    ; zera BX, que será usado para armazenar o resultado
    XOR BX, BX

Leitura:
    ; Lê um caractere do teclado e salva em al
    MOV AH, 01H
    INT 21H

    ; Verifica se o caractere digitado é o CR (enter)
    CMP AL, CR
    JE impressao

    ; Converte o caractere '0' ou '1' para valor binário
    SUB AL, '0'

    ; Desloca BX uma posição à esquerda e coloca o bit lido
    ROL BX, 1    ; Rotaciona BX à esquerda ("abre espaço" no bit menos significativo)
    OR BL, AL    ; Coloca o bit lido no LSB de BX

    ; Continua lendo o próximo caractere
    JMP Leitura

impressao:
    ; Exibir mensagem de resultado
    MOV AH, 09H
    LEA DX, MSG2
    INT 21H

    MOV CX, 16       ; utiliza os 16 bits de BX como parâmetro para o contador cx

loop_deimpressao:
    ; Desloca BX para a esquerda e imprime o bit mais significativo
    RCL BX, 1
    JC imprime1       ; Se houver carry, ou seja o flag de carry é = 1, imprime '1'
    MOV DL, '0'      ; Caso contrário, imprime '0'
    JMP imprimecaractere

imprime1:
    MOV DL, '1'

imprimecaractere:
    MOV AH, 02H      ; Função de imprimir caractere
    INT 21H
    LOOP loop_deimpressao  ; Continua até imprimir todos os 16 bits



    ; Finaliza o programa
    MOV AH, 4CH
    INT 21H
main endp
end main