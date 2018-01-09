%include "io.inc"
%define _null 0x00
%define _size 64

section .bss
    buffin resb _size
    buffout resb _size

section .text
    global CMAIN
CMAIN:
    mov ebp, esp ;for correct debugging
    
    GET_STRING buffin, _size
    mov esi, buffin
    mov edi, buffout
    mov ebx, _null ;ebx - max
    
    maxloop:
        lodsb
        
        test eax, eax
        jz exit
       
        cmp eax, ebx
        jng maxloop
        mov ebx, eax
        jmp maxloop
    
               
    exit:
        mov eax, ebx
        stosb
        PRINT_STRING buffout 
        NEWLINE
        
    ;xor EAX, EAX
    mov esi, buffin
    mov edi, buffout
    
    minloop:
        lodsb
        test eax, eax
        jz exit2
        
        cmp eax, ebx
        jg minloop
        mov ebx, eax
        jmp minloop
    
    exit2:
        mov eax, ebx
        stosb
        PRINT_STRING buffout
            
    xor eax, eax
    ret