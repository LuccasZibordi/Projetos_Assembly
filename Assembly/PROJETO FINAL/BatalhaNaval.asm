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
    Torpedos db 36

    ;MENSAGENS:
    msg db 10,13, 'BEM VINDO AO SIMULADOR DE BATALHA NAVAL!', 10,13, 'Desenvolvido por: Luccas Gomes Zibordi      RA: 24007138 ',10,13,10,13,'   Aperte <enter> para continuar!$'
    msg2 db 10,13,'Posicionando embarcacoes... ... ... ...$'

    MatrizAmostra db '   0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19',10,13
                  db 'A  . . . . . . . . . . . . . . . . . . . . . . . . .',10,13                
                  db 'B  . . . . . . . . . . . . . . . . . . . . . . . . .',10,13                
                  db 'C  . . . . . . . . . . . . . . . . . . . . . . . . .',10,13                
                  db 'D  . . . . . . . . . . . . . . . . . . . . . . . . .',10,13                
                  db 'E  . . . . . . . . . . . . . . . . . . . . . . . . .',10,13                
                  db 'F  . . . . . . . . . . . . . . . . . . . . . . . . .',10,13                
                  db 'G  . . . . . . . . . . . . . . . . . . . . . . . . .',10,13                
                  db 'H  . . . . . . . . . . . . . . . . . . . . . . . . .',10,13                
                  db 'I  . . . . . . . . . . . . . . . . . . . . . . . . .',10,13                ;matriz mostrada para o usuário
                  db 'J  . . . . . . . . . . . . . . . . . . . . . . . . .',10,13                
                  db 'K  . . . . . . . . . . . . . . . . . . . . . . . . .',10,13                
                  db 'L  . . . . . . . . . . . . . . . . . . . . . . . . .',10,13                
                  db 'M  . . . . . . . . . . . . . . . . . . . . . . . . .',10,13                
                  db 'N  . . . . . . . . . . . . . . . . . . . . . . . . .',10,13                
                  db 'O  . . . . . . . . . . . . . . . . . . . . . . . . .',10,13                
                  db 'P  . . . . . . . . . . . . . . . . . . . . . . . . .',10,13                
                  db 'Q  . . . . . . . . . . . . . . . . . . . . . . . . .',10,13                
                  db 'R  . . . . . . . . . . . . . . . . . . . . . . . . .',10,13                
                  db 'S  . . . . . . . . . . . . . . . . . . . . . . . . .',10,13                
                  db 'T  . . . . . . . . . . . . . . . . . . . . . . . . .$ ',10,13                

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
call mostrarmatriz
call addEmbarcacoes

fim:
mov ah,4ch
int 21h

main ENDP

mostrarmatriz proc
mov ah,09H
lea dx,MatrizAmostra
int 21H
ret
mostrarmatriz endp

addEmbarcacoes proc
    PULA_LINHA
    mov ah,09H
    lea dx, msg2
    int 21h

    ; Inicializa as variáveis de linha e coluna
    xor di,di
    xor bx,bx
    
    ; Posiciona o encouraçado (4 células consecutivas na horizontal)
    mov cx, 4
    mov bx, 6    ; Linha inicial
    mov di, 4    ; Coluna inicial
encouracado:
    ; Verifica se está dentro dos limites da matriz (20x20)
    cmp di, 20
    jae proximo_navio
    cmp bx, 20
    jae proximo_navio

    ; Posiciona uma parte do encouraçado
    mov matriz[bx * 20 + di], 1
    inc di
    loop encouracado

proximo_navio:
    ; Posiciona a fragata (3 células consecutivas na horizontal)
    mov cx, 3
    add bx, 4   ; Define nova linha para a fragata
    mov di, 8   ; Coluna inicial
frag:
    ; Verifica se está dentro dos limites da matriz (20x20)
    cmp di, 20
    jae subm
    cmp bx, 20
    jae subm

    ; Posiciona uma parte da fragata
    mov matriz[bx * 20 + di], 1
    inc di
    loop frag

subm:
    ; Posiciona o submarino (2 células consecutivas na horizontal)
    mov cx, 2
    add bx, 4   ; Define nova linha para o submarino
    mov di, 12  ; Coluna inicial
submarino:
    ; Verifica se está dentro dos limites da matriz (20x20)
    cmp di, 20
    jae aviao
    cmp bx, 20
    jae aviao

    ; Posiciona uma parte do submarino
    mov matriz[bx * 20 + di], 1
    inc di
    loop submarino

aviao:
    ; Posiciona o hidroavião em formato "L"
    mov bx, 14  ; Linha inicial
    mov di, 4   ; Coluna inicial
    ; Verifica se está dentro dos limites da matriz (20x20)
    cmp di, 20
    jae fim
    cmp bx, 20
    jae fim

    ; Parte horizontal do hidroavião
    mov matriz[bx * 20 + di], 1
    inc di
    mov matriz[bx * 20 + di], 1

    ; Parte vertical do hidroavião
    inc bx
    cmp bx, 20
    jae FINAL
    mov matriz[bx * 20 + di - 1], 1  ; Coloca na mesma coluna da primeira parte

FINAL:
    ret
addEmbarcacoes endp




end main
; minha ideia é que cada posição ocupada por uma das embarcações possua o valor '1' assim como os misseis. Ao ser acertado o pedaço da embarcação atingido terá seu valor(1) subtraido pelo valor do missel(1) resultando em 0, retornando para o valor original da posição da matriz