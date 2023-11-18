

code segment
    assume cs:code, ds:data, ss:sztos
    
start:
    mov ax, data
    mov ds, ax
    mov ax, sztos
    mov ss, ax    
    mov sp, offset top 
    
    mov dx,offset wstep             ;komunikat wstepu
    mov ah, 09h                     
    int 21h 
    
    mov dx,offset polecenie         ;komunikat polecenia
    mov ah, 09h 
    int 21h
    
    mov dx, offset max              ;wpisanie do dx maksymalnej dlugosci+1
    mov ah, 0Ah                     ;podanie kodu zezwalajacego na wpisanie danych przy uzyciu klawiatury (max 5 znakow)
    int 21h                         ;wykonanie polecenia
    
    cmp dlugosc, 0
    jz  blad_zero
    
    xor dx, dx
    xor bx, bx
    
    
petla:
    mov ax, 10d
    mul suma
    jc blad_za_duza
    mov suma, ax
    xor ah, ah
    mov al, wartosc[bx]
    sub al, '0' 
    cmp al, 10d
    jnc blad_nie_liczba
    add suma, ax
    jc blad_za_duza
    inc bx
    cmp bl, dlugosc
    jnz petla
    
;wyswietlenie dziesietnie
    mov bl, dlugosc
    mov wartosc[bx], "$"
    
    mov dx, offset dzies
    mov ah, 09h
    int 21h 
    
    mov dx, offset wartosc
    mov ah, 09h
    int 21h
    
    
;binarnie 
    mov dx, offset bin
    mov ah, 09h
    int 21h
        
    xor cx, cx
    mov ax, suma
binarny:
    xor dx, dx    
    mov bx, 2d
    div bx
    push dx
    inc cx
    cmp ax, 0
    jnz binarny
    
binarny2:
    pop dx
    add dx, '0'
    mov ah, 02h
    int 21h
    loop binarny2
    jmp kont
    
           
blad_zero:
    jmp zero

blad_nie_liczba:
    jmp nie_liczba
    
blad_za_duza:
    jmp za_duza



kont:
    mov dx, offset hex
    mov ah, 09h
    int 21h
    
    xor cx, cx
    mov ax, suma
hexadec:    
    xor dx, dx
    mov bx, 16d
    div bx
    push dx
    inc cx
    cmp ax, 0
    jnz hexadec
    
hexadec2:
    pop dx
    cmp dx, 10d
    jnc alf
    add dx, '0'
    mov ah, 02h
    int 21h
    loop hexadec2
    jmp koniec
alf:
    add dx, '7'
    mov ah, 02h
    int 21h
    loop hexadec2
    
    jmp koniec 
    
zero:
    mov dx, offset brak
    mov ah, 09h
    int 21h
    jmp koniec 
    
za_duza:
    mov dx, offset zakres
    mov ah, 09h
    int 21h
    jmp koniec
    
nie_liczba:
    mov dx, offset formate
    mov ah, 09h
    int 21h
    jmp koniec
    
koniec:    
    mov ah, 4ch
    mov al,0
    int 21h
       
code ends 

data segment
    wstep           db "Witaj w naszym konwerterze UwU$"
    polecenie       db 10,13,"Podaj liczbe z zakresu 0-65535",10,13,"$"    
    brak            db 10,13,"Nie podano liczby$"
    formate         db 10,13,"To nie jest liczba dziesietna$"
    zakres          db 10,13,"Liczba za duza$"
    dzies           db 10,13,"Reprezentacja dziesietna: $"
    bin             db 10,13,"Reprezentacja binarna: $" 
    hex             db 10,13,"Reprezentacja heksadecymalna: $"
    max             db 6
    dlugosc         db ?
    wartosc         db 6 dup(?)
    suma            dw 0

    
data ends

sztos segment stack
    dw   100h  dup(0)
    top Label word
sztos ends

end start ; set entry point and stop the assembler.
