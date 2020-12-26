    org 0x7c00

BaseOfStack equ 0x7c00

Label_Start:

    mov ax, cs
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, BaseOfStack

;========= clear screen
;;funtion 06h roll screen
    mov ax, 0600h
    ;bh color 07h(White)
    mov bx, 0700h
    ;pos left top(ch colum, cl line)
    mov cx, 0
    ;pos right bottom
    mov dx, 0184fh
    int 10h
;========= set focus
;; function ah=02h
    mov ax, 0200h
    ;bh page
    mov bx, 0000h
    ;dh colum, dl line
    mov dx, 0000h
    int 10
;========= display on screen: Start BOoting ......

    mov ax, 1301h
    mov bx, 000fh
    mov dx, 0000h
    mov cx, 10
    push ax
    mov ax, ds
    mov es, ax
    pop ax
    mov bp, StartBootMessage
    int 10h

;=========reset floppy
;;function ah=00h
    xor ah, ah
    ;dl = o00h, use 'driveA'
    xor dl, dl
    int 13h

    jmp $

StartBootMessage: db "Start Boot"

;======== fill zero util whole sector
    times 510-($-$$) db 0
    ; Magic num means boot section
    dw 0xaa55