.data

    v: .long 3, 1, 6, 2, 5, 4
    .equ LEN, (. - v) / 4

.text
.global main

main:
    movl $0, %ecx

et_loop1:    
    movl %ecx, %esi
    inc %esi   
    jmp et_loop2

end_loop1:
    inc %ecx
    cmp $(LEN - 1), %ecx
    jne et_loop1
    je et_print

et_loop2:   
    movl v(, %ecx, 4), %ebx
    movl v(, %esi, 4), %edx

    cmp %ebx, %edx
    jb et_swap   
    jmp end_loop2 

end_loop2:
    inc %esi
    cmp $LEN, %esi
    jb et_loop2
    jge end_loop1

et_swap:
    movl %edx, v(, %ecx, 4) 
    movl %ebx, v(, %esi, 4) 
    jmp end_loop2

et_print:
    mov $0, %ecx

et_print_loop:
    movl v(, %ecx, 4), %ebx
    add $'0', %ebx
    
    pushl %ecx
    pushl %ebx
    
    movl $4, %eax
    movl $1, %ebx
    movl %esp, %ecx
    movl $1, %edx
    int $0x80

    popl %ebx
    popl %ecx

    inc %ecx
    cmp $LEN, %ecx
    jne et_print_loop

et_exit:
    movl $1, %eax
    movl $0, %ebx
    int $0x80
