.data
    n: .long 0
    m: .long 0
    x: .long 0
    a: .space 400
    b: .space 400

    fmt: .asciz "%d"
    fmt1: .asciz "%d "
    newline: .asciz "\n"

.text

memcpy: 
    movl 12(%esp), %ebx
    movl 8(%esp), %edx
    movl 4(%esp), %ecx 

cpy_loop:
    movl 4(%esp), %eax
    subl %ecx, %eax
    movl (%edx, %eax, 4), %esi
    movl %esi, (%ebx, %eax, 4)
    loop cpy_loop

    movl %ebx, %eax
    ret


.global main

main:
    pushl $n
    pushl $fmt
    call scanf
    addl $8, %esp

    pushl $m
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
    movl %edx, a(, %esi, 4)
    
    incl %esi
    loop lp_read

et_call:
    pushl $b
    pushl $a
    pushl m
    call memcpy
    addl $12, %esp

    movl m, %ecx
    xorl %esi, %esi

lp_print:
    pushl %ecx

    pushl b(, %esi, 4)
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