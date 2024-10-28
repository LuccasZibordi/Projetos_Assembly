; Programa em Assembly Intel x86 para ler, somar e imprimir os elementos de uma matriz 4x4
; utilizando MASM/TASM.

.model small
.stack 100h
.data
    matriz DB 4 DUP(4 DUP (0))  ; Matriz 4x4 inicializada com zeros (16 elementos)
    MSG DB 13,10,"Digite um numero da matriz: $"
    MSG_SAIDA   DB 13,10, 'Matriz digitada:', 13,10, '$'
    MSG_LINHA   DB 13,10, '$' ; Para quebrar a linha
    MSG_SOMA    DB 13,10, "A soma dos elementos da matriz e: $"
    buffer      DB 6 DUP(0)   ; Buffer para conversão da soma
.code
main proc
    mov ax, @data
    mov ds, ax

    ; Ler a matriz do teclado
    call leituradamatriz

    ; Imprimir a matriz lida
    call imprimematriz

    ; Somar os elementos da matriz
    call somadamatriz

    ; Imprimir a soma
    call impimesoma

    ; Encerrar o programa
    mov ax, 4Ch
    int 21h
main endp

leituradamatriz proc
    xor bx,bx          ; Inicializa o índice de linha (BX)
    mov cx, 4 ; Número de linhas da matriz
leitura_linha:
    push cx            ; Salva o contador de linhas
    xor si,si          ; Inicializa o índice de coluna (SI)
    mov cx, 4 ; Número de colunas da matriz
leitura_coluna:
    ; Exibe a mensagem de entrada
    LEA DX, MSG
    MOV AH, 09H
    INT 21H

    ; Lê um caractere do teclado
    mov ah, 01H
    int 21h
    ; Converte o caractere ASCII para valor numérico
    and al,0fh        ; AL agora contém o valor numérico (0-9)

    ; Armazena o valor na matriz
    mov [matriz + bx + si], al

    ; Incrementa o índice de coluna
    inc si
    loop leitura_coluna ; Decrementa CX e repete se CX > 0

    ; Incrementa o índice de linha
    add bx, 4 ; Move para a próxima linha
    pop cx              ; Restaura o contador de linhas
    loop leitura_linha  ; Decrementa CX e repete se CX > 0

    ret
leituradamatriz endp

;impressão da matriz
imprimematriz PROC
    ; Exibe a mensagem de saída
    LEA DX, MSG_SAIDA
    MOV AH, 09H
    INT 21H

    mov bx, 0             ; Índice de linha
    mov cx, 4    ; Contador de linhas
imprime_linha:
    push cx               ; Salva o contador de linhas
    mov si, 0             ; Índice de coluna
    mov cx, 4   ; Contador de colunas
imprime_coluna:
    ; Carrega o valor da matriz
    mov al, [matriz + bx + si]

    ; Converte o valor numérico para caractere ASCII
    add al, '0'           ; AL agora tem o caractere ASCII ('0'-'9')

    ; Exibe o caractere
    mov ah, 02H
    mov dl, al
    int 21h

    ; Opcional: adicionar um espaço entre os números
    mov ah, 02H
    mov dl, ' '
    int 21h

    ; Incrementa o índice de coluna
    inc si
    loop imprime_coluna   ; Decrementa CX e repete se CX > 0

    ; Quebra de linha após cada linha da matriz
    LEA DX, MSG_LINHA
    MOV AH, 09H
    INT 21H

    ; Incrementa o índice de linha
    add bx, 4   ; Move para a próxima linha
    pop cx                ; Restaura o contador de linhas
    loop imprime_linha    ; Decrementa CX e repete se CX > 0

    ret
imprimematriz ENDP

;soma dos elemtos da matriz
somadamatriz PROC
    xor bx, bx             ; Índice para a matriz (BX = 0)
    xor dx, dx             ; Acumulador para a soma (DX = 0)
    mov cx, 4    ; Contador de linhas (4)
acessa_linha:
    push cx                ; Salva o contador de linhas
    mov si, 0              ; Índice de coluna (SI = 0)
    mov cx, 4    ; Contador de colunas (4)
acessa_coluna:
    ; Carrega o valor da matriz
    mov al, [matriz + bx + si] ; AL = elemento atual
    mov ah, 0              ; Zero-extend AL para AX
    add dx, ax             ; DX += AX (soma acumulada)
    ; Incrementa o índice de coluna
    inc si
    loop acessa_coluna     ; Decrementa CX e repete se CX > 0
    ; Incrementa o índice de linha
    add bx, 4    ; Move para o início da próxima linha
    pop cx                 ; Restaura o contador de linhas
    loop acessa_linha      ; Decrementa CX e repete se CX > 0
    ret
somadamatriz ENDP

impimesoma PROC

    ; Salva os registradores que serão usados
    PUSH AX           ; Salva AX na pilha
    PUSH BX           ; Salva BX na pilha
    PUSH CX           ; Salva CX na pilha
    PUSH DX           ; Salva DX na pilha
    PUSH SI           ; Salva SI na pilha

    MOV AX, DX        ; AX = valor da soma
    MOV CX, 0         ; Contador de dígitos
    LEA SI, buffer    ; Aponta SI para o buffer
    ADD SI, 5         ; Começa do final do buffer (5 dígitos)
    MOV BYTE PTR [SI], '$' ; Termina a string com '$'
    DEC SI

converte_loop:
    XOR DX, DX        ; Zera DX (necessário antes da divisão)
    MOV BX, 10        ; Divisor = 10
    DIV BX            ; Divide DX:AX por BX (AX = quociente, DX = resto)
    ADD DL, '0'       ; Converte o resto (DX) em caractere ASCII
    MOV [SI], DL      ; Armazena o dígito no buffer
    DEC SI            ; Move para a posição anterior no buffer
    INC CX            ; Incrementa contador de dígitos
    CMP AX, 0         ; Verifica se o quociente é zero
    JNE converte_loop ; Se não for zero, continua o loop

    INC SI            ; Ajusta SI para o início da string de dígitos

    ; Exibe a mensagem
    LEA DX, MSG_SOMA
    MOV AH, 09H
    INT 21H

    ; Exibe o valor convertido
    MOV DX, SI
    MOV AH, 09H
    INT 21H

    ; Restaura os registradores
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX

    RET
impimesoma ENDP


end main