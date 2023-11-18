;czestotliwosci dla pierwszej oktawy
pauza equ 1

nutac equ 36157
nutad equ 32248
nutae equ 29102
nutaf equ 27118
nutag equ 24351
nutaa equ 21694
nutah equ 19245

nutacis equ 34091
nutadis equ 30594
nutaeis equ 28409
nutafis equ 25939
nutagis equ 22946
nutaais equ 20572


code segment
assume  cs:code, ds:data, ss:sztosiwo

start:
    mov    ax,data
    mov    ds,ax
    mov    ax,sztosiwo
    mov    ss,ax
    mov    sp,offset top

    xor ax, ax
    mov ah,62h
    int 21h

    xor cx, cx

    mov es,bx
    mov cl, es:[80h]
    dec cl
	js blad

    mov ax,es
    push ds
    push ds
    mov ds,ax
    mov si,82h
    pop es
    mov di, offset nazwaPliku
    rep movsb

    pop ds

    mov dx, offset nazwaPliku
    mov ax, 3d00h
    int 21h
	jc blad
    mov uchwyt,ax
	

	
poczatek:
	mov ah, 3fh
	mov bx, uchwyt
	mov dx, offset linia
	mov cx, 3
	int 21h
	jmp wybor_nut
	
powrot:	
	mov ax, 4201h
	mov bx, uchwyt
	mov cx, 0
	mov dx, 2
	int 21h
	jmp poczatek
	
blad:
	mov dx, offset tekstBlad
	mov ah, 09h
	int 21h
	jmp koniec
	
graj:
	xor dx, dx
	xor cx, cx
	mov cl, linia[1]
	sub cl, '0'
	sub cl, 1
	shr ax, cl

	out 42h, al
	mov al, ah
	out 42h, al
	
	in al,61h 
	or al, 00000011b
	out 61h, al
	
	xor cx, cx
	mov cl, linia[2]
	sub cl, '0'
	cmp cl, 0
	jnz dalej
	mov cx, 16d
dalej:
	mov ah, 86h
	mov dx, 0ffffh
czas:
	push cx
	xor cx,cx
	int 15h
	pop cx
	loop czas
	
	in al, 61h
	and al, 11111100b
	out 61h, al
	jmp powrot
	
	
wybor_nut:
	xor bx, bx
	mov bl, linia[0]
	cmp bl, 'C'
	jz grajC
	cmp bl, 'D'
	jz grajD
	cmp bl, 'E'
	jz grajE
	cmp bl, 'F'
	jz grajF
	cmp bl, 'G'
	jz grajG
	cmp bl, 'A'
	jz grajA
	cmp bl, 'H'
	jz grajH
	cmp bl, 'c'
	jz grajCis
	cmp bl, 'd'
	jz grajDis
	cmp bl, 'e'
	jz grajEis
	cmp bl, 'f'
	jz grajFis
	cmp bl, 'g'
	jz grajGis
	cmp bl, 'a'
	jz grajAis
	cmp bl, 'P'
	jz grajP
	jmp koniec

grajC:
	mov ax, nutac
	jmp graj
grajD:
	mov ax, nutad
	jmp graj
grajE:
	mov ax, nutae
	jmp graj
grajF:
	mov ax, nutaf
	jmp graj
grajG:
	mov ax, nutag
	jmp graj
grajA:
	mov ax, nutaa
	jmp graj
grajH:
	mov ax, nutah
	jmp graj
grajCis:
	mov ax, nutacis
	jmp graj
grajDis:
	mov ax, nutadis
	jmp graj
grajEis:
	mov ax, nutaeis
	jmp graj
grajFis:
	mov ax, nutafis
	jmp graj
grajGis:
	mov ax, nutagis
	jmp graj
grajAis:
	mov ax, nutaais
	jmp graj
grajP:
	mov ax, pauza
	jmp graj	
	
koniec:	
    mov ah,4ch
    mov al,0
    int 21h
code ends
data segment
	tekstBlad   db "Nie udalo sie otworzyc pliku$"
    nazwaPliku	db 20 dup(0)
    uchwyt     	dw ?
	linia		db 3 dup(0)
data ends

sztosiwo segment stack
    dw    100h dup(0)
top    Label word
sztosiwo ends

end start