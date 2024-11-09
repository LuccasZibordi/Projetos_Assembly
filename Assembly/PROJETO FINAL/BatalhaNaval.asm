TITLE Batalha Naval
.model small
.stack 100h
.data
    ;VARIAVEIS:
    matriz db 20 dup(20 dup(0)) ;matriz principal

    Encouraçado db 1 ; 4 células consecutivas (1 linha e 4 colunas)
    Fragata db 1     ; 3 células consecutivas (1 linha e 3 colunas)
    Submarino db 2   ; 2 células consecutivas (1 linha e 2 colunas)
    Hidroaviao db 2  ; 4 células posicionadas (3 linhas e 2 colunas)
    Torpedos db 33

    ;MENSAGENS:
    msg db 10,13, 'BEM VINDO AO SIMULADOR DE BATALHA NAVAL!', 10,13, 'Desenvolvido por: Luccas Gomes Zibordi      RA: 24007138 ',10,13,10,13,'   Aperte <enter> para continuar!$'
    msg2 db 10,13,'Posicionando embarcacoes... ... ... ...$'
    msg3 db 10,13,'Escolha um mapa para jogar (digite um numero entre 0 - 9): $'
    msg4 db 10,13,'Escollha uma posicao para atirar (linha): $'
    msg5 db 10,13,'Escollha uma posicao para atirar (coluna): $'
    msg6 db 10,13,'Numero de tiros restantes: $'
    msg7 db 10,13,'Acertou!$'
    msg8 db 10,13,'Agua!$'

    MatrizAmostra db '    0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19',10,13
                  db '0   . . . . . . . . . . . . . . . . . . . . . . . . .',10,13                
                  db '1   . . . . . . . . . . . . . . . . . . . . . . . . .',10,13                
                  db '2   . . . . . . . . . . . . . . . . . . . . . . . . .',10,13                
                  db '3   . . . . . . . . . . . . . . . . . . . . . . . . .',10,13                
                  db '4   . . . . . . . . . . . . . . . . . . . . . . . . .',10,13                
                  db '5   . . . . . . . . . . . . . . . . . . . . . . . . .',10,13                
                  db '6   . . . . . . . . . . . . . . . . . . . . . . . . .',10,13                
                  db '7   . . . . . . . . . . . . . . . . . . . . . . . . .',10,13                
                  db '8   . . . . . . . . . . . . . . . . . . . . . . . . .',10,13                ;matriz mostrada para o usuário
                  db '9   . . . . . . . . . . . . . . . . . . . . . . . . .',10,13                
                  db '10  . . . . . . . . . . . . . . . . . . . . . . . . .',10,13                
                  db '11  . . . . . . . . . . . . . . . . . . . . . . . . .',10,13                
                  db '12  . . . . . . . . . . . . . . . . . . . . . . . . .',10,13                
                  db '13  . . . . . . . . . . . . . . . . . . . . . . . . .',10,13                
                  db '14  . . . . . . . . . . . . . . . . . . . . . . . . .',10,13                
                  db '15  . . . . . . . . . . . . . . . . . . . . . . . . .',10,13                
                  db '16  . . . . . . . . . . . . . . . . . . . . . . . . .',10,13                
                  db '17  . . . . . . . . . . . . . . . . . . . . . . . . .',10,13                
                  db '18  . . . . . . . . . . . . . . . . . . . . . . . . .',10,13                
                  db '19  . . . . . . . . . . . . . . . . . . . . . . . . . $',10,13                

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

QTDTIROS MACRO
    ; Exibe a mensagem do número de tiros restantes
    MOV AH,09h
    LEA DX, msg6
    INT 21H

    ; Converte o valor de Torpedos para ASCII e exibe
    MOV AL, Torpedos   ; Carrega o valor de Torpedos em AL
    AAM                ; Divide AL em dígitos (resultado em AH e AL)
    ADD AH, '0'        ; Converte o dígito das dezenas para ASCII
    ADD AL, '0'        ; Converte o dígito das unidades para ASCII
    
    ; Exibe o dígito das dezenas (se for maior que zero)
    CMP AH, '0'
    JE skip_tens
    MOV DL, AH
    MOV AH, 02h
    INT 21H
skip_tens:
    
    ; Exibe o dígito das unidades
    MOV DL, AL
    MOV AH, 02h
    INT 21H

    ENDM
    
.code


main PROC
    
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

    ; Lê o valor do usuário
    mov ah, 01h
    int 21h
    and al, 0fh ; Converte o valor digitado para número (0-9)
    xor dh,dh
    mov dl, al  ; Armazena o valor digitado em BL
    ret
selecionarMapa endp

addEmbarcacoes proc
    call selecionarMapa

    mov ah,09H
    lea dx, msg2
    int 21H

; Preparação para posicionar o Encouraçado (1 linha e 4 colunas)
    mov bx,2
    mov di,5
    add bx,dx
    add di,dx
    mov cx, 4

encouracado:
    mov Matriz[bx][di],1
    inc di
    loop encouracado

; Preparação para posicionar o Fragata (1 linha e 3 colunas)
    mov bx,4
    mov di,6
    add bx,dx
    add di,dx
    mov cx, 3

frag:
    mov Matriz[bx][di],1
    inc di
    loop frag

; Preparação para posiionar o Submarino (1 linha e 2 colunas)
    mov bx,6
    mov di,4
    add bx,dx
    add di,dx
    mov cx, 2

repete_sub:
    push cx
    mov cx,2

subm:
    mov Matriz[bx][di],1
    inc di
    loop subm

verifica_repete:
    pop cx

segunda_rep:
    sub bx,dx
    sub di,dx

    loop repete_sub

; Preparação para posiionar o Submarino (1 linha e 2 colunas) 
    mov bx,8
    mov di,2
    add bx,dx
    add di,dx
    mov cx, 2
repete_hidro:
    push cx
    mov cx,3

hidro_horizontal:
    mov Matriz[bx][di],1
    inc bx
    loop hidro_horizontal

hidro_vertical:
    dec bx
    inc di
    mov Matriz[bx][di],1

verifica_rep:
    pop cx
    
segunda_repet:
    sub bx,dx
    sub di,dx

    loop repete_hidro 

    ret
addEmbarcacoes endp

tiros proc
PULA_LINHA
QTDTIROS
    
linha:
    mov ah,09H
    lea dx, msg4
    int 21h
    call ler_posicao
    xor bh,bh
    
coluna:
    mov ah,09H
    lea dx, msg5
    int 21h
    call ler_posicao
    xor bh,bh
    mov bx,di

    ; Verifica se acertou uma embarcação
    cmp matriz[bx][di], 1
    je acertou

agua:
    mov ah, 09h
    lea dx, msg8
    int 21h
    jmp fim_tiro

acertou:
    mov ah, 09h
    lea dx, msg8
    int 21h
    mov matriz[bx][di], 0  ; Marca a posição como destruída

fim_tiro:
    ret

ret
tiros endp

ler_posicao proc
    ; Lê o primeiro caractere (parte das dezenas)
leitura:
    mov ah, 01h        ; Função para ler caractere do teclado
    int 21h            ; Lê o primeiro dígito
    and al,0fh        ; Converte o caractere ASCII para valor numérico
    mov bl, al         ; Armazena o valor em BL (parte das dezenas)
    cmp bl,13
    je fim_leitura
    mov ax, 10
    mul bl             ; Multiplica o valor por 10, resultado em AX
    jmp leitura

fim_leitura:
    ret
ler_posicao endp


end main
; minha ideia é que cada posição ocupada por uma das embarcações possua o valor '1' assim como os misseis. Ao ser acertado o pedaço da embarcação atingido terá seu valor(1) subtraido pelo valor do missel(1) resultando em 0, retornando para o valor original da posição da matriz