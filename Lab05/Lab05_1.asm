.model small
.stack 100h
.code
main proc
    mov cx, 50          ; Define o contador do loop para 50

; Primeiro loop: exibe '*' 50 vezes na mesma linha
PrimeiroLoop:
    mov dl, '*'         ; Caractere a ser exibido
    mov ah, 02h         ; Função para exibir caractere
    int 21h             ; Chama a interrupção da função
    dec cx
    jnz primeiroloop     ; Decrementa CX e repete o loop se CX for diferente de 0

    mov dl, 10        
    mov ah, 02h
    int 21h             ; Move para a próxima linha
    mov dl, 13         
    mov ah, 02h
    int 21h

    mov cx, 50          ; Redefine o contador do loop para 50

 ; Segundo loop: exibe '*' 50 vezes, um em cada linha
SegundoLoop:
    mov dl, '*'         ; Caractere a ser exibido
    mov ah, 02h         ; Função para exibir caractere
    int 21h

    ; Move para a próxima linha após cada '*'
    mov dl, 10    
    mov ah, 02h
    int 21h

    mov dl, 13        
    mov ah, 02h
    int 21h

    dec cx
    jnz SegundoLoop  ; Decrementa CX e repete o loop se CX for diferente de 0

    ; Termina o programa 
    mov ah, 4Ch         ; Função para encerrar o programa
    int 21h
    main endp
    end main
