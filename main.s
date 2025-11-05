.data
    
    s: .long 1, 8, 3, 7, 5, 6
    .equ LEN, (. - s) / 4
    fmtstr: .asciz "%d "

.text
.global main

main:
    mov $s, %eax
    mov $0, %ecx
    mov $(LEN - 1), %edi

et_loop:
    movl s(, %ecx, 4), %ebx
    movl s(, %edi, 4), %edx

    movl %edx, (%eax, %ecx, 4)
    movl %ebx, (%eax, %edi, 4)

    inc %ecx
    dec %edi

    cmp $(LEN / 2), %ecx
    jne et_loop

    mov $0, %ecx
et_loop2:
    pushl %ecx
    pushl s(, %ecx, 4)
    pushl $fmtstr
    call  printf
    add   $8, %esp
    popl  %ecx
    
    inc %ecx
    cmp $LEN, %ecx 
    jne et_loop2

    pushl $0
    call  fflush
    add   $4, %esp

et_exit: 
    mov $1, %eax
    mov $0, %ebx
    int $0x80

