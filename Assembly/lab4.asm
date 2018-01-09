%include "io.inc"

%define _size 64

section .data
    error db "Данные не введены", 0

section .bss
    string resb _size

section .text
    global CMAIN
    
CMAIN:
    mov ebp, esp
    
    %macro clear 1
        xor %1, %1
    %endmacro
    
    %macro if 3
        cmp %1, %2
        je %3
    %endmacro
    
    %macro count 4
        cmp %1, %2
        jne %3
        inc %4
    %endmacro
    
    GET_STRING string, _size
    GET_CHAR EBX 
    
    mov ESI, string
    
    clear ECX
   
    if byte [ESI], 0xa, .print_error
    
    .loop:
        lodsb

        if EAX, 0x00, .print_error 
        if EAX, 0xa, .print_result
        
        count EAX, EBX, .loop, ECX
        
        jmp .loop 
    
    .print_result:
        PRINT_UDEC 4, ECX 
        ret
    
    .print_error:
        PRINT_STRING error
    
    clear EAX
    ret