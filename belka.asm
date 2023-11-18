code segment
assume  cs:code, ds:data, ss:sztos

start:  mov     ax,data
        mov     ds,ax
        mov     ax,sztos
        mov     ss,ax
        mov     sp,offset top

;losowanie



    mov ah,2ch
    int 21h

    xor ax,ax
    xor bx,bx
    mov al,ch
    mov bl,cl
    add ax,bx
    mov bl,dh
    add ax,bx
    mov bl,dl
    add ax,bx
    mov miejsce,ax

;    xor dx,dx
    mov ax,0b800h
    mov es,ax



petla:
    xor dx,dx
    mov bx, miejsce
    inc miejsce
    cmp miejsce,256d
    jnz kont
    mov miejsce, 0
kont:
    mov dl,los[bx]
    mov ax,dx
    mul mnozenie
    mov linia,ax
;********    push ax
;********    push ax
;********    mov di,ax

    mov cx,80
    cld
    push ds
    push ds
    pop es
    mov si,linia
    mov di,offset bufor
    mov ax,0B800h
    mov ds,ax


    rep movsw
    pop ds

;******    pop di
    mov di,linia
    push 0b800h
    pop es


    mov al,32
    mov ah,color
    mov cx,80
    jmp kolor
petladwa:
    jmp petla
kolor:
    mov es:[di],ax
    add di,2
    loop kolor

;czas
    mov cx,16
    mov ah,86h
    mov dx,0ffffh
czas:
    push cx
    xor cx,cx
    int 15h
    pop cx
    loop czas

;***    pop ax
;****    mov di,ax
;****    mov cx,80

;***        xor bx,bx
;****        xor ax,ax

przywroc:

    mov cx,80
    mov ax,data  ;*****
    mov ds,ax    ;******
    mov si, offset bufor
    mov di, linia
    mov ax, 0b800h
    mov es, ax
    rep movsw

    mov ah,01h
    int 16h
    jz petladwa

    mov     ah,4ch
    mov     al,0
    int     21h 
    
code ends

data segment
    bufor     db 160 dup (?)
    los       db 5, 19, 12, 16, 0, 19, 18, 9, 17, 14, 18, 19, 13, 18, 23, 24, 13, 11, 2, 22, 22, 7, 2, 0, 19, 12, 8, 6, 20, 24, 18, 12, 21, 21, 18, 16, 7, 11, 24, 12, 1, 9, 8, 11, 9, 11, 8, 22, 20, 12, 8, 18, 15, 22, 10, 18, 1, 13, 21, 21, 18, 9, 18, 23, 21, 3, 10, 22, 8, 5, 16, 19, 12, 18, 6, 11, 16, 5, 1, 12, 21, 14, 17, 23, 24, 24, 23, 7, 2, 15, 22, 0, 7, 19, 7, 15, 3, 20, 1, 5, 12, 24, 8, 23, 12, 19, 22, 1, 19, 1, 21, 2, 22, 3, 21, 19, 20, 18, 18, 10, 20, 19, 9, 7, 3, 21, 5, 9, 2, 5, 21, 13, 2, 1, 22, 14, 20, 15, 5, 3, 7, 19, 17, 11, 1, 3, 16, 15, 15, 8, 17, 10, 13, 10, 19, 12, 23, 6, 8, 3, 9, 17, 19, 1, 10, 13, 12, 6, 11, 15, 15, 22, 12, 2, 19, 2, 20, 10, 21, 18, 13, 0, 21, 7, 8, 18, 20, 9, 1, 3, 20, 16, 24, 15, 23, 1, 1, 8, 0, 2, 12, 11, 11, 9, 10, 2, 11, 17, 5, 8, 2, 14, 3, 4, 16, 21, 11, 9, 8, 1, 11, 0, 24, 9, 3, 8, 22, 2, 1, 21, 11, 9, 19, 11, 19, 1, 1, 3, 8, 12, 17, 24, 11, 15, 12, 6, 14, 0, 22, 23, 19, 22, 14, 10, 23, 15
    miejsce   dw 0
    color     db 30h
    mnozenie  db 160d
    linia     dw 0

data ends

sztos segment stack
        dw      100h dup(0)
top     Label word
sztos ends

end start