title repeat
.model small
.stack 100h

.data
    msg1 db "Digite os caracteres: ","$"
    msg2 db "O numero de caracteres em (*) eh: ","$"        ;Mensagens do programa
    newline db 10,13,'$'

.code
    main proc

    mov ax,@data            ;acessa o conteúdo de .data
    mov ds,ax

    mov cx,0
    mov ah,09h              ;imprime a mensagem 1 e define o contador cx como 0
    lea dx, msg1
    int 21h

contador:
    mov ah,1
    int 21h                 ; le varios números do teclado em loop e compara com o caractere enter
    inc cx                  ; se for igual ao "enter" pula para impressao, se nao, continua no loop
    cmp al,13
    je impressao
    jmp contador

impressao:
    mov ah, 09h
    lea dx, msg2           ; imprime a mensagem 2
    int 21h
    sub cx,1               ; subtrai a contagem do enter no cx

    asteriscos:
    mov ah,02h
    mov dl,"*"            ; imprime o * na mesma quantidade de números lidos salvo em cx até cx zerar, enquanto isso ele continua no loop
    int 21h
    dec cx
    jnz asteriscos

fim:
    mov ah,04ch
    int 21h              ; termina o programa
    main endp
    end main


; A diferença entre os dois programs é que o While realiza o loop enquanto a condição for verdadeira
; o Repeat realiza o loop até a condição ser verdadeira