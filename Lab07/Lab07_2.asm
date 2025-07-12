Title divisao
.model small
.stack 100h

.data                                                 ; mensagens utilizadas no programa com os caracteres 10 e 13 para pular linhas
    msg1 db 10,13,"Digite o multiplicando: ","$"          
    msg2 db 10,13,"Digite o multiplicador: ","$"  
    msg3 db 10,13,"Produto ","$"

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
    
    mov cl,bh               ; move o conteúdo de bh para cl para realizar o loop sem que o valor original de bh seja perdido
multiplicasao:
    add cl,bh
    dec bl
    cmp bl,1            ; Label de loop de multiplicasao de adições sucessivas até que o bl seja igual a 1
    je impressao
    jmp multiplicasao

impressao:
    or cl,30h               ; conversao novamente do caractere do produto em ASCII

    mov ah, 09h
    lea dx, msg3
    int 21h                 ;impressao da mensagem 3 e do Produto
    mov ah, 02h
    mov dl,cl
    int 21h

;Final do programa
    mov ah,4ch
    int 21h

    main endp
    end main