; � �������� ������ �������� � �������� �������
; �������� ����� ��������� ��������� ����� ���.
; ��������� ������� ������ �������� ��� ���������.

%include "io.inc"

%define _size 128
%define _endstr 0xa

section .data
    error db "����� �� �������!", 0

section .bss
    buff   resb _size ; �������� ������
    output resb _size ; �������� ������
    pos    resb _size ; ������ �������
    len    resb _size ; ����� �������
    count  resb _size ; ���������� ����������
    
section .text
    global CMAIN

CMAIN:
    mov EBP, ESP ; for correct debugging
    
    GET_STRING buff, _size
    GET_UDEC 1, pos
    GET_UDEC 1, len
    GET_UDEC 1, count
    
    mov ESI, buff
    
    xor EBX, EBX
    
    ; ����� �������� ������
    .lenstr:
        lodsb
        inc EBX
        cmp EAX, _endstr
        jne .lenstr
        sub EBX, 1
        mov EAX, EBX
            
    ; ����� � ������ ������� ����� ������ �����������
    ; � ����������� ��� �������� EAX
    mov ECX, [pos]
    sub EAX, ECX
    mov ECX, [len]
    sub EAX, ECX
    
    ; ���� ����� ������� ���������� ������� �� �������,
    ; �� ���������� ������������ �� ������
    cmp EAX, 0
    jl  .printerror
    
    mov ESI, buff
    mov EDI, output
    mov ECX, EBX ; ECX - ����� ������
    mov EBX, [count]
    jmp .copystr
    
    .inc:
        ; ������� ����� ������ �������
        ; ����� ���������� �������� ����� ����������� �������
        inc EAX
    
    .copystr:
        ; ��� ������ ����������� �������
        cmp EAX, ECX
        je  .copycount
        mov DL, [ESI]
        mov [EDI], DL
        inc ESI
        inc EDI
        loop .copystr
        jmp  .finish
    
    .copycount:
        ; ����������� ������ ���������� �����������
        cmp EBX, 0
        je .inc
        sub ESI, [len]
        mov ECX, [len]
    
    .pastecopy:
        mov DH, [ESI]
        mov [EDI], DH
        inc ESI
        inc EDI
        loop .pastecopy
        dec EBX ; ��������� ������� �����������
        mov ECX, EAX
        jmp .copycount
    
    .finish:
        mov EAX, [EDI]
        stosb
        PRINT_STRING output
        ret
    
    .printerror:
        PRINT_STRING error
        ret
    
    xor EAX, EAX
    ret
    
    
    
        
      
    
    
    
    
    