TITLE Batalha Naval
.model small
.stack 100h
.data
    ;VARIAVEIS:
    matriz db 10 dup(10 dup(0)) ;matriz principal

    EmbarcacoesRestantes db 19 ; Total de partes de embarcações no jogo

    ;MENSAGENS:
    msg db 10,13, 'BEM VINDO AO SIMULADOR DE BATALHA NAVAL!', 10,13, 'Desenvolvido por: Luccas Gomes Zibordi   RA: 24007138 ',10,13,10,13,' e Guilherme Balabanian Mascaretti   RA:24021378 ',10,13,10,13,'  Aperte <enter> para continuar!$'
    msg2 db 10,13,'Posicionando embarcacoes... ... ... ...$'
    msg3 db 10,13,'Escolha um mapa para jogar (digite um numero entre 0 - 5): $'
    msg4 db 10,13,'Escollha uma posicao para atirar (linha): $'
    msg5 db 10,13,'Escollha uma posicao para atirar (coluna): $'
    msg6 db 10,13,'Acertou!$'
    msg7 db 10,13,'Agua!$'
    msg8 db 10,13,'Parabens! Voce destruiu todas as embarcacoes e venceu o jogo!$'
    msg9 db 10,13,'Jogo encerrado, ate a proxima...'

    MatrizAmostra db '    0 1 2 3 4 5 6 7 8 9 ',10,13
                  db '0   . . . . . . . . . .',10,13                
                  db '1   . . . . . . . . . .',10,13                
                  db '2   . . . . . . . . . .',10,13                
                  db '3   . . . . . . . . . .',10,13                
                  db '4   . . . . . . . . . .',10,13                
                  db '5   . . . . . . . . . .',10,13                
                  db '6   . . . . . . . . . .',10,13                
                  db '7   . . . . . . . . . .',10,13                
                  db '8   . . . . . . . . . .',10,13                ;matriz mostrada para o usuário
                  db '9   . . . . . . . . . .$',10,13                               

    ;MACROS:
    LIMPA_TELA MACRO
    MOV AH, 0 
    MOV AL, 3 
    INT 10H
    ENDM

    PULA_LINHA MACRO
    MOV AH,02H
    MOV DL,10
    INT 21H
    MOV AH,02H
    MOV DL,13
    INT 21H
    ENDM

.code

main PROC
    LIMPA_TELA
    
    mov ax,@data
    mov ds,ax

    mov ah,09h
    lea dx, msg
    int 21h

    mov ah,01h
    int 21h
    cmp al,13
    je inicio

inicio:
LIMPA_TELA
call mostrarMatriz
call addEmbarcacoes
call tiros

fim:
mov ah,4ch
int 21h

main ENDP

mostrarMatriz proc
mov ah,09H
lea dx,MatrizAmostra
int 21H
ret
mostrarMatriz endp

selecionarMapa proc
    PULA_LINHA
    ; Pergunta ao usuário qual mapa escolher
    mov ah, 09h
    lea dx, msg3
    int 21h

    call ler_posicao
    xor dx,dx
    mov dx,bx
    ret
selecionarMapa endp

addEmbarcacoes proc
    call selecionarMapa

    mov bx,0
    mov di,0
    call addEncouracado

    mov bx,2
    mov di,2
    call addFragata

    mov bx,5
    mov di,0
    call addSubmarino
    Segundo_Submarino:
    mov bx,7
    mov di,3
    call addSubmarino

    mov bx,1
    mov di,6
    call addHidroaviao
    Segundo_Hidroaviao:
    mov bx,6
    mov di,7
    call addSegundoHidroaviao

    ret
addEmbarcacoes endp

addEncouracado proc
    ; Posiciona o encouraçado (ocupa 4 colunas)
    posiciona_peca_encouracado:
        ; Escolher uma posição inicial aleatória 
        add bx, dx ; Linha inicial
        add di, dx ; Coluna inicial

        ; Verificar se as 4 colunas estão livres e não encostadas em outras peças
        mov si,di
        mov cx, 4  ; O encouraçado ocupa 4 colunas
    verifica_posicao_encouracado:
        ; Verifica se a posição atual está livre
        mov al, matriz[bx][si]
        cmp al, 0
        jne outra_posicao_encouracado

        ; Incrementa a coluna e verifica a próxima
        inc si
        loop verifica_posicao_encouracado

        ; Se todas as posições estiverem livres, posiciona o encouraçado
        mov cx, 4
    coloca_encouracado:
        mov matriz[bx][di], 1
        inc di
        loop coloca_encouracado
        jmp fim_encouracado
    outra_posicao_encouracado:
        dec bx

    fim_encouracado:
        ret
addEncouracado endp
addFragata proc
    ; Posiciona o fragata (ocupa 3 colunas)
    posiciona_peca_fragata:
        ; Escolher uma posição inicial aleatória 
        add bx, dx ; Linha inicial
        add di, dx ; Coluna inicial

        ; Verificar se as 3 colunas estão livres e não encostadas em outras peças
        mov si,di
        mov cx, 3  ; O fragata ocupa 3 colunas
    verifica_posicao_fragata:
        ; Verifica se a posição atual está livre
        mov al, matriz[bx][si]
        cmp al, 0
        jne outra_posicao_fragata

        ; Incrementa a coluna e verifica a próxima
        inc si
        loop verifica_posicao_fragata

        ; Se todas as posições estiverem livres, posiciona o encouraçado
        mov cx, 3
    coloca_fragata:
        mov matriz[bx][di], 1
        inc di
        loop coloca_fragata
        jmp fim_fragata
    outra_posicao_fragata:
        dec bx
    fim_fragata:
        ret
addFragata endp
addSubmarino proc
    ; Posiciona o submarino (ocupa 2 colunas)
    posiciona_peca_submarino:
        ; Escolher uma posição inicial aleatória (
        sub bx, dx ; Linha inicial
        add di, dx ; Coluna inicial

        ; Verificar se as 2 colunas estão livres e não encostadas em outras peças
        mov si,di
        mov cx, 2  ; O submarino ocupa 2 colunas
    verifica_posicao_submarino:
        ; Verifica se a posição atual está livre
        mov al, matriz[bx][si]
        cmp al, 0
        jne outra_posicao_submarino

        ; Incrementa a coluna e verifica a próxima
        inc si
        loop verifica_posicao_submarino

        ; Se todas as posições estiverem livres, posiciona o encouraçado
        mov cx, 2
    coloca_submarino:
        mov matriz[bx][di], 1
        inc di
        loop coloca_submarino
        jmp fim_submarino

    outra_posicao_submarino:
        ; Escolhe outra posição se houver sobreposição ou estiver encostado
        dec bx
    fim_submarino:
        ret
addSubmarino endp
addHidroaviao proc
    ; Posiciona o hidroaviao (ocupa 2 colunas e 3 linhas)
    posiciona_peca_hidroaviao:
        ; Escolher uma posição inicial aleatória
        add bx, dx ; Linha inicial
        sub di, dx ; Coluna inicial

        ; Verificar se as 2 colunas estão livres e não encostadas em outras peças
        mov si,di
        mov cx, 2  ; O hidroaviao ocupa 2 colunas
    verifica_coluna_hidroaviao:
        ; Verifica se a posição atual está livre
        mov al, matriz[bx][si]
        cmp al, 0
        jne outra_posicao_hidroaviao

        ; Incrementa a coluna e verifica a próxima
        inc si
        loop verifica_coluna_hidroaviao

        ; Verificar se as 3 linhas estão livres e não encostadas em outras peças
        mov cx, 3  ; O hidroaviao ocupa 3 colunas
    verifica_linha_hidroaviao:
        ; Verifica se a posição atual está livre
        mov al, matriz[bx][si]
        cmp al, 0
        jne outra_posicao_hidroaviao

        ; Incrementa a coluna e verifica a próxima
        inc bx
        loop verifica_linha_hidroaviao

        ; Se todas as posições estiverem livres, posiciona o encouraçado
        mov cx,2
    coloca_hidroaviao:
        mov matriz[bx][di], 1
        inc bx
        loop coloca_hidroaviao
        inc di
        mov matriz[bx][di],1
        dec di
        inc bx
        mov matriz[bx][di],1
        jmp fim_hidroaviao

    outra_posicao_hidroaviao:
        dec bx

    fim_hidroaviao:
        ret
addHidroaviao endp
addSegundoHidroaviao proc
    ; Posiciona o hidroaviao (ocupa 2 colunas e 3 linhas)
    posiciona_peca_Segundo_hidroaviao:
        ; Escolher uma posição inicial aleatória
        sub bx, dx ; Linha inicial
        sub di, dx ; Coluna inicial

        ; Verificar se as 2 colunas estão livres e não encostadas em outras peças
        mov si,di
        mov cx, 2  ; O hidroaviao ocupa 2 colunas
    verifica_coluna_Segundo_hidroaviao:
        ; Verifica se a posição atual está livre
        mov al, matriz[bx][si]
        cmp al, 0
        jne outra_posicao_Segundo_hidroaviao

        ; Incrementa a coluna e verifica a próxima
        inc si
        loop verifica_coluna_Segundo_hidroaviao

        ; Verificar se as 3 linhas estão livres e não encostadas em outras peças
        mov cx, 3  ; O hidroaviao ocupa 3 colunas
    verifica_linha_Segundo_hidroaviao:
        ; Verifica se a posição atual está livre
        mov al, matriz[bx][si]
        cmp al, 0
        jne outra_posicao_Segundo_hidroaviao

        ; Incrementa a coluna e verifica a próxima
        inc bx
        loop verifica_linha_Segundo_hidroaviao

        ; Se todas as posições estiverem livres, posiciona o encouraçado
        mov cx,2
    coloca_Segundo_hidroaviao:
        mov matriz[bx][di], 1
        inc bx
        loop coloca_Segundo_hidroaviao
        inc di
        mov matriz[bx][di],1
        dec di
        inc bx
        mov matriz[bx][di],1

        jmp fim_Segundo_hidroaviao

    outra_posicao_Segundo_hidroaviao:
        dec bx

    fim_Segundo_hidroaviao:
        ret
addSegundoHidroaviao endp


tiros proc
    xor dx,dx
comeco:
    PULA_LINHA
    push dx

linha:
    mov ah,09H
    lea dx, msg4
    int 21h
    call ler_posicao

coluna:
    mov ah,09H
    lea dx, msg5
    int 21h
    call ler_posicao
    mov di,bx
    ; Verifica se acertou uma embarcação
    cmp matriz[bx][di], 1
    je acertou

agua:
    mov ah, 09h
    lea dx, msg7
    int 21h
    jmp fim_tiro

acertou:
    mov ah, 09h
    lea dx, msg6
    int 21h
    mov matriz[bx][di], 0 ; Marca a posição como destruída
    dec embarcacoesRestantes ; Decrementa o contador de partes de embarcações restantes

    ; Verifica se todas as embarcações foram destruídas
    cmp embarcacoesRestantes, 0
    je vitoria

fim_tiro:
    jmp comeco
    ret

pausa_jogo:
    LIMPA_TELA
    mov ah, 09h
    lea dx, msg9
    int 21h
    jmp fim

vitoria:
    LIMPA_TELA
    mov ah, 09h
    lea dx, msg8
    int 21h
    jmp fim

tiros endp

ler_posicao proc
    ; Lê o primeiro dígito (dezena)
    MOV AH, 01h
    int 21h
    ; Verifica se o usuário pressionou 'p' para pausar
    cmp al, 'p'
    je pausa_jogo
    AND AL,0FH  ; Converter ASCII para numérico
    xor ah,ah
    mov bx,ax
    ret
ler_posicao endp

end main
