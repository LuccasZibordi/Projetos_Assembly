title somatoria
.model small
.stack 100h
.data
    msg1 db "Digite um numero: $"
    msg2 db "A soma dos numeros digitados e: $"
.code
    main proc

    mov ax, @data
    mov ds, ax

    mov cx, 5                   ; inicializa o contador do loop com 5
    mov bh, 0                   ; inicializa bh com 0

    lendonumeros:
        mov ah, 2
        mov dl, 13              ; move para a próxima linha
        int 21h
        mov dl, 10              
        int 21h
        mov ah, 9
        mov dx, offset msg1
        int 21h                 ; imprime "Digite um numero: "
        mov ah, 1
        int 21h                 ; le e salva os caracteres em al

        sub al, 30h             ; Converte o numero da tabela ascii
        add bh, al              ; adiciona al em bl
        loop lendonumeros

    ; nova linha
    mov ah, 2
    mov dl, 13              
    int 21h
    mov dl, 10              
    int 21h

    ; imprime a mensagem de resultado
    mov ah, 9
    mov dx, offset msg2
    int 21h                 ; imprime "A soma dos numeros digitados e: "

    ; Converte a soma na tabela ascii e imorime
    mov ax, 0
    mov al, bh              ; Move a soma para al
    mov bl, 10
    div bl                  ; Divide a soma por 10
    add al, 30h             ; Converte o quociente em ascii
    add ah, 30h             ; Converte o resto em ascii

    cmp al, '0'
    je pulanumerosdez       ; pula de o digito dez for 0
    mov dl, al
    mov ah, 2
    int 21h                 ; mostra o décimo digito
    
    pulanumerosdez
    mov dl, ah
    mov ah, 2
    int 21h                 ; mostra apenas um digito

    mov ah, 4Ch
    int 21h                 ; termina o programa

    main endp
end main
