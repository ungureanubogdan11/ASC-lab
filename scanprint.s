.data
    n: .long 0
    x: .long 0
    v: .space 400
    fmt: .asciz "%d"
    fmt1: .asciz "%d "
    newline: .asciz "\n"

.text
.global main

main:
    pushl $n
    pushl $fmt
    call scanf
    addl $8, %esp

    movl n, %ecx
    xorl %esi, %esi
    
    testl %ecx, %ecx
    jz et_exit

lp_read:
    pushl %ecx
    
    pushl $x
    pushl $fmt
    call scanf
    addl $8, %esp
    
    popl %ecx

    movl x, %edx
    movl %edx, v(, %esi, 4)
    
    incl %esi
    loop lp_read

    movl n, %ecx
    xorl %esi, %esi

lp_print:
    pushl %ecx

    decl %ecx
    pushl v(, %ecx, 4)
    pushl $fmt1
    call printf
    addl $8, %esp

    popl %ecx
    

    incl %esi
    loop lp_print

    pushl $newline
    call printf
    addl $4, %esp

et_exit:
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80