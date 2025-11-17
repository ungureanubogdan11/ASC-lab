.data
    n: .space 4
    fmt_r: .asciz "%d"
    fmt_w: .asciz "%d\n"

.text

factorial:
    pushl %ebp
    movl %esp, %ebp
    movl 8(%ebp), %ebx

    test %ebx, %ebx
    jz base_case

    decl %ebx
    pushl %ebx
    call factorial
    addl $4, %esp
    incl %ebx
    
    mull %ebx
    jmp end_factorial

base_case:
    movl $1, %eax

end_factorial:
    popl %ebp
    ret

.global main

main:
    pushl $n
    pushl $fmt_r
    call scanf
    addl $8, %esp

    pushl n
    call factorial
    addl $4, %esp

    pushl %eax
    pushl $fmt_w
    call printf
    addl $8, %esp

et_exit:
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80