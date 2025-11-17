// verifica daca un numar este perfect, adica daca suma divizorilor este egala cu numarul

.data
    x: .long 6
    fmt: .asciz "%d"
.text

.set val, 16
perfect:    
    pushl %ebp
    pushl %edi
    pushl %ebx
    mov %esp, %ebp

    
    mov $0, %edi
    movl val(%ebp), %ecx
    shr $1, %ecx
    movl val(%ebp), %ebx
    jmp et_loop

    et_add:
        add %ecx, %edi
        loop et_loop

    et_loop:
        cmp $0, %ecx
        je end_loop
        mov $0, %edx
        mov %ebx, %eax
        div %ecx

        cmp $0, %edx
        je et_add
        loop et_loop


    end_loop:
        cmp %edi, %ebx
        mov $0, %eax
        jne end_loop
        mov $1, %eax

        popl %ebx
        popl %edi
        popl %ebp
        ret



.global main

main:
    pushl x
    call perfect
    popl %edx
    
et_exit:
    mov $1, %eax
    mov $0, %ebx
    int $0x80
