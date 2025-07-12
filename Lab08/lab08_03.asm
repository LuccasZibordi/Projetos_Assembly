.MODEL SMALL
.STACK 100H
.DATA
    MSG DB 'Digite um numero hexadecimal (ate 4 digitos): $'
    CR DB 13 ; Carriage Return (Enter)
.CODE
START:
    ; Acessa os conteúdos armazenados em @data
    MOV AX, @DATA
    MOV DS, AX

    ; Exibe a mensagem em .data
    MOV AH, 09H
    LEA DX, MSG
    INT 21H

    ; zera BX que será utilizado como o resultado
    XOR BX, BX

leitura:
    ; Lê um caractere do teclado
    MOV AH, 01H
    INT 21H

    ; Verifica se o caractere é CR (Enter)
    CMP AL, CR
    JE fim

    ; Converte o caractere hexadecimal para binário
    ; Se o caractere for de '0' a '9'
    CMP AL, '9'
    JBE digito9
    ; Se o caractere for de 'A' a 'F'
    CMP AL, 'A'
    JB caractereinvalido
    CMP AL, 'F'
    JA caractereinvalido
    SUB AL, 'A' - 10
    JMP AtualizaBX

digito9:
    SUB AL, '0'

AtualizaBX:
    ; Desloca BX 4 bits para a esquerda para preparar para o próximo dígito
    SHL BX, 4

    ; Insere o valor binário nos 4 bits inferiores de BX
    OR BL, AL

    ; Continua lendo o próximo caractere
    JMP leitura

caractereinvalido:
    ; Em caso de caractere inválido, podemos ignorar ou tratar de outra forma
    JMP leitura

fim:
    ; Finaliza o programa
    MOV AH, 4CH
    INT 21H

END START
