.data
    s: .space 100
    fmt_r: .asciz "%s"
    fmt_w: .asciz "%d\n"

.text
atoi:
    movl $0, %ecx
    movl $0, %eax
    movl 4(%esp), %esi 

et_loop:

    movl $0, %ebx
    movb (%esi, %ecx, 1), %bl

    // movzbl (%esi, %ecx, 1), %ebx

    // verific daca s-a terminat sirul
    cmp $0, %ebx
    je end_loop

    // verific daca e o cifra 
    cmp $'0', %ebx
    jl et_no
    cmp $'9', %ebx
    jg et_no

    subl $'0', %ebx

    // lipesc cifra
    movl $10, %edi
    movl $0, %edx
    mull %edi
    addl %ebx, %eax

    incl %ecx
    jmp et_loop

et_no:
    movl $0, %eax
    ret

end_loop:
    ret

.global main

main:
    pushl $s
    pushl $fmt_r
    call scanf
    addl $8, %esp

    pushl $s
    call atoi
    addl $4, %esp

    pushl %eax
    pushl $fmt_w
    call printf
    addl $8, %esp

et_exit:
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80

