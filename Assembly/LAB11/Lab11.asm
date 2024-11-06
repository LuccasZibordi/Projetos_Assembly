TITLE saidas2.asm
.MODEL SMALL
.STACK 100H
.DATA
    msg  DB "Insira o numero que sera convertido: $"
    msg2 DB 10,13,"Em qual base sera convertida: Binário(2), Octal(8) ou Hexadecimal(16)? $"
    msgHexa DB 10,13, "BASE Hexadecimal: $"
    msgOcta DB 10,13, "BASE Octal: $"
    msgBin  DB 10,13, "BASE binária: $"
.CODE
main PROC
             MOV  AX,@DATA  ;inicia o segmento de dados
             MOV  DS,AX

             MOV  AH,09
             LEA  DX,msg        ;Imprime a mensagem inicial
             INT  21H

LOOP_LEITURA:
             MOV  AH,01           ; Le um caractere do teclado e salva em AL
             INT  21H
             CMP  AL,13           ; Compara o caractere lido com o CR enter
             JE   SAI_LEITURA     ; Se o caractere lido é o CR, ou seja enter, então ele pula para o label sai leitura

             AND  AX, 0FH          ; Transforma o caractere lido em um número

             PUSH AX               ; Preserva o AX na pilha
             MOV  AX,10            ; Move o multiplicador para AX

             MUL  BX               ; Multiplica AX por BX
             POP  BX               ; Devolve o valor para BX

             ADD  BX,AX            ; Soma o valor lido com a multiplicação em BX (BX = BX + (BX x AX))
             JMP  LOOP_LEITURA     ; Loop de leitura
SAI_LEITURA:
             MOV  AH, 09           ; Caso o valor lido for CR, então o programa salta para essa label
             LEA  DX, msg2         ; Imprime a mensagem 2 pedindo pro usuário selecionar a base para a conversão
             INT  21H
    LER:     
             MOV  AH,01H           ; Lê um carcatere do teclado e salva em AL
             INT  21H
             CMP  AL, 13           ; Compara o caractere lido em AL com o CR, se for igual continua no loop
             JE  LER
             SUB  AL, '0'          ; Transforma o caractere lido em AL em número
             CMP  AL, 2            ; Compara o caractere lido com '2' o numero associado ao binário na mensagem, se for igual pula para o label binário
             JE   BIN
             CMP  AL, 8            ; Compara o caractere lido com '8' o numero associado ao octal na mensagem, se for igual pula para o label octal
             JE   OCTA
             CMP  AL, 16           ; Compara o caractere lido com '16' o numero associado ao hexadecimal na mensagem, se for igual pula para o label hexadecimal
             JE   HEXA
            

    HEXA:    
             MOV  AH,09
             LEA  DX,msgHexa       ; Imprime a mensagem associada a converção para a base hexadecimal
             INT  21H
             CALL sai_hexa         ; Chama a função de conversão para hexadecimal
    OCTA:    
             LEA  DX,msgOCta       ; Imprime a mensagem associada a converção para a base octal
             INT  21H              
             CALL sai_oct          ; Chama a função de conversão para octal
    BIN:     
             LEA  DX,msgBin        ; Imprime a mensagem associada a converção para a base binária
             INT  21H
             CALL sai_bin          ; Chama a função de conversão para binário

    FIM:     
             MOV  AH,4CH           ; Final do programa
             INT  21H
main ENDP

    ;saida hexa
sai_hexa PROC
             PUSH AX               ; Salva os registradores na pilha
             PUSH BX
             PUSH CX
             PUSH DX               

             xor  cx,cx            ; Zera o contador cx para o loop
             mov  AX,bx            ; Move o dividendo (número digitado pelo usuário) para AX
             MOV  BX,16            ; O divisor será 16 pois estamos convertendo para a base HEXADECIMAL
LOOP_HEXA:
             XOR  DX,DX            ; Vamos armazenar o resto em DX toda vez que o loop voltar, entao DX precisa ser sempre zerado
             DIV  BX               ; Dividindo AX por BX deixando o resto em DX e o quociente em AX

             PUSH DX               ; Guardar o valor de DX (resto da divisão) na pilha
             INC  CX               ; Incrementa cx

             CMP  AX,0             ; Se o quociente for 0, então o programa passa a imprimmir o valor hexadecimal correspondente 
             JNE  LOOP_HEXA

        
             MOV  AH,02H
IMPRIME_HEXA:                     ; Loop de impressão
             POP  DX              ; Restauro o valor do resto da divisão armazenado em DX na pilha
             CMP  DX, 9           ; Compara esse valor com 9 se for maior então é necessário imprimir uma letra do hexadecimal para representar o número
             JA   EH_LETRA        ; Pula para a label do programa que imprime letras no hexadecimal

             OR   DX, 30H         ; Converte o número em caractere para a impressão na próxima label
             JMP  IMPRESSAO      

EH_LETRA:
             ADD  DX, 55D          ; Se for letra então é adicionado o valor de diferença entre um número e uma letra em hexadecimal

IMPRESSAO:
             INT  21H
             LOOP IMPRIME_HEXA     ; Realiza o loop da conversão/impressão da base hexadecimal


             POP  DX
             POP  CX
             POP  BX               ; Restaura os valores originais dos registradores
             POP  AX
             RET                   ; Retorna para o chamado da função e encerra o procedimento
sai_hexa ENDP

    ;saida octal
sai_oct PROC
             PUSH AX               ; Salva os valores orginais dos registradores na pilha
             PUSH BX
             PUSH CX
             PUSH DX

             xor  cx,cx            ; Zera o contador cx para o loop
             mov  AX,bx            ; Move o valor salvo em AX para BX
             MOV  BX,8             ; Agora a divisao deve ser por 8 para converter para a base OCTAL
LOOP_OCTA:
             XOR  DX,DX            ; Zera o DX que será usado como resto da divisão em BX
             DIV  BX               ; Divide BX por 8

             PUSH DX               ; Guarda o valor do resto do divisão salvo em DX na pilha
             INC  CX               ; Incrementa o contador

             CMP  AX,0             ; Compara o quociente salvo em AX com 0 se for diferente ele realiza o loop se não imprime o valor
             JNE  LOOP_OCTA

        
             MOV  AH,02H           ; Funcão do INT21H que imprime um caractere salvo em DL
IMPRIME_OCTA:
             POP  DX               ; Restaura o resto salvo em DX da pilha
             CMP  DX, 9            ; Compara com 9 se for maior é necessário imprimmir uma letra da base octal para representar o número
             JA   EH_LETRA1        ; Pula para a label que converte em letra

             OR   DX, 30H          ; Transforma o DX em caractere para a impressão
             JMP  IMPRESSAO1       ; Pula para a label de impressão

EH_LETRA1:
             ADD  DX, 55D          ; Se for letra então é adicionado o valor de diferença entre um número e uma letra em octal

IMPRESSAO1:
             INT  21H              ; Imprime o caractere em DX
             LOOP IMPRIME_OCTA     ; Realiza o Loop de conversão/impressão para a base octal


             POP  DX
             POP  CX
             POP  BX
             POP  AX
             RET                   ; Retorna para o chamado da função e encerra o procedimento
sai_oct ENDP

    ;saida binaria
sai_bin PROC    
             PUSH AX               ; Salva os valores orginais dos registradores na pilha
             PUSH BX
             PUSH CX
             PUSH DX

    MOV CX, 16                     ; utiliza os 16 bits de BX como parâmetro para o contador cx

loop_deimpressao:
                                   ; Desloca BX para a esquerda e imprime o bit mais significativo
    RCL BX, 1
    JC imprime1                    ; Se houver carry, ou seja o flag de carry é = 1, imprime '1'
    MOV DL, '0'                    ; Caso contrário, imprime '0'
    JMP imprimecaractere

imprime1:
    MOV DL, '1'

imprimecaractere:
    MOV AH, 02H                    ; Função de imprimir caractere
    INT 21H
    LOOP loop_deimpressao          ; Continua até imprimir todos os 16 bits  


             POP  DX
             POP  CX
             POP  BX
             POP  AX
             RET                     ; Retorna para o chamado da função e encerra o procedimento
sai_bin ENDP

END MAIN