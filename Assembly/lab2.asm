; В исходной строке фрагмент с заданной позиции
; заданной длины повторить требуемое число раз.
; Остальные символы строки оставить без изменения.

%include "io.inc"

%define _size 128
%define _endstr 0xa

section .data
    error db "Выход за пределы!", 0

section .bss
    buff   resb _size ; исходная строка
    output resb _size ; выходная строка
    pos    resb _size ; начало участка
    len    resb _size ; длина участка
    count  resb _size ; количество повторений
    
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
    
    ; длина исходной строки
    .lenstr:
        lodsb
        inc EBX
        cmp EAX, _endstr
        jne .lenstr
        sub EBX, 1
        mov EAX, EBX
            
    ; узнаём с какого символа нужно начать копирование
    ; и присваеваем это значение EAX
    mov ECX, [pos]
    sub EAX, ECX
    mov ECX, [len]
    sub EAX, ECX
    
    ; если длина участка повторения выходит за пределы,
    ; то оповестить пользователя об ошибке
    cmp EAX, 0
    jl  .printerror
    
    mov ESI, buff
    mov EDI, output
    mov ECX, EBX ; ECX - длина строки
    mov EBX, [count]
    jmp .copystr
    
    .inc:
        ; считаем после какого символа
        ; нужно продолжить печатать после копирования участка
        inc EAX
    
    .copystr:
        ; для начала копирования участка
        cmp EAX, ECX
        je  .copycount
        mov DL, [ESI]
        mov [EDI], DL
        inc ESI
        inc EDI
        loop .copystr
        jmp  .finish
    
    .copycount:
        ; отслеживаем нужное количество копирований
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
        dec EBX ; уменьшаем счётчик копирования
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
    
    
    
        
      
    
    
    
    
    