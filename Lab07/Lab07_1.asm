Title divisao
.model small
.stack 100h

.data                                                 ; mensagens utilizadas no programa com os caracteres 10 e 13 para pular linhas
    msg1 db 10,13,"Digite o dividendo: ","$"          
    msg2 db 10,13,"Digite o divisor: ","$"  
    msg3 db 10,13,"Quociente: ","$"
    msg4 db 10,13,"Resto: ","$"

.code
Main proc

    mov ax,@data           ; move os conteúdos de @data para ax e posteriormente para ds 
    mov ds,ax

    mov ah,09h
    lea dx, msg1           ;impressao da mensagem 1, leitura de caractere e conversão do caracter lido em ASCII
    int 21h
    mov ah,01h
    int 21h
    and al,0fh
    mov bh,al
   

    mov ah,09h  
    lea dx, msg2            ;impressao da mensagem 2, leitura de caractere e conversão do caracter lido em ASCII
    int 21h                                 
    mov ah,01h          
    int 21h
    and al,0fh
    mov bl,al
    

    xor cl,cl

divisao:
    sub bh,bl
    inc cl
    cmp bh,bl               ; Label de loop de divisao de subtrações sucessivas até que o bh seja menor que bl
    jb impressao
    jmp divisao

impressao:
    or bh,30h
    or cl,30h               ; conversao novamente dos caracteres em ASCII

    mov ah, 09h
    lea dx, msg3
    int 21h                 ;impressao da mensagem 3 e do Quociente
    mov ah, 02h
    mov dl,cl
    int 21h

    mov ah, 09h
    lea dx, msg4            ;impressao da mensagem 4 e do resto
    int 21h         
    mov ah, 02h
    mov dl,bh
    int 21h

;Final do programa
    mov ah,4ch
    int 21h

    main endp
    end main