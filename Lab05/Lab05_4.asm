TITLE letras4
.model small
.stack 100h

.code
    main proc
    
    mov cx,26                    ;26 caracteres do alfabeto
    mov dl,'a'                   ; inicia dl com o caractere 'a'  
    mov bl,4                     ; inicia bl com o numero de caracteres por linha

    geral:
    mov cx,4                     ; define o contador em 4
    cmp bl,0                     ;compara bl com 0
    
    primeiroloop:
    cmp dl,7bh                   ; compara dl com o caractere 'z+1' na tabela ascii
    je final                     ; se dl for igual a 'z+1' entao pula pro final
    mov ah,2                     ; imprime um caractere na tela
    int 21h
    inc dl                       ; incrementa dl
    loop primeiroloop            ;decrementa cx e faz o loop se cx for diferente de 0

    quatroporlinha:
    mov ah,2
    mov bl,dl                   ; move o conteúdo de dl para bl
    mov dl,10                   
    int 21h
    mov dl,bl                   ; essa seção pula as linhas que serão impressas
    mov ah,2
    mov bl,dl
    mov dl,13
    int 21h

    mov dl,bl                   ; restaura dl
    jge geral                   ; salto condicional caso dl seja maior ou igual a bl pula para o label geral

    final:
    mov ah,4ch                  ; termina o programa
    int 21h

    main endp
    end main