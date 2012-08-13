#  Assemble: as quicksort.asm -o quicksort.o -g
#  Link: ld -o quicksort quicksort.o -lc -I/lib/ld-linux.so.2

#  Mark the beginning of the data section.
.section .data
    fmt_str:
        .ascii "%d \0"

    sorted_str:
        .ascii "Sorted list:   \0"

    unsorted_str:
        .ascii "Unsorted list: \0"

#  Mark the beginning of the code section. 
.section .text
    .globl _start               #  Tell the linker where your program starts.

#  main()
_start:
    #  Save ebp and esp.
    push %ebp                   #  Push callee's ebp onto stack.
    mov %esp,%ebp               #  Move esp into ebp, so that we can consistently offset from the same location.

    sub $64,%esp                #  Allocate stack space.

    movl $8,60(%esp)            #  list_size = 8

    movl $4,28(%esp)            #  list[0] = 4
    movl $8,32(%esp)            #  list[1] = 8
    movl $1,36(%esp)            #  list[2] = 1
    movl $6,40(%esp)            #  list[3] = 6
    movl $3,44(%esp)            #  list[4] = 3
    movl $7,48(%esp)            #  list[5] = 7
    movl $2,52(%esp)            #  list[6] = 2
    movl $5,56(%esp)            #  list[7] = 5

    movl $unsorted_str,(%esp)
    call printf                 #  Print the unsorted string.

    mov 60(%esp),%eax           #  Move list_size into eax.
    mov %eax,4(%esp)            #  Move list_size onto stack.
    lea 28(%esp),%eax           #  Move the address of list[0] into eax.
    mov %eax,(%esp)             #  Move the address of list[0] onto stack.
    call print_list             #  Print the unsorted list.

    mov 60(%esp),%eax           #  Move list_size into eax.
    mov %eax,4(%esp)            #  Move list_size onto stack.
    lea 28(%esp),%eax           #  Move the address of list[0] into eax.
    mov %eax,(%esp)             #  Move the address of list[0] onto stack.
    call quick_sort             #  Sort the list. 

    movl $sorted_str,(%esp)
    call printf                 #  Print the sorted string.

    mov 60(%esp),%eax           #  Move list_size into eax.
    mov %eax,4(%esp)            #  Move list_size onto stack.
    lea 28(%esp),%eax           #  Move the address of list[0] into eax.
    mov %eax,(%esp)             #  Move the address of list[0] onto stack.
    call print_list             #  Print the sorted list.

    leave                       #  Restore ebp and esp.
    movl $1,%eax                #  Move sys_exit() into eax.
    movl $0,%ebx                #  Move ARG1 into ebx.
    int $0x80                   #  Tell the kernel to execute sys_exit(ARG1).

print_list:
    #  Save ebp and esp.
    push %ebp                   #  Push callee's ebp onto stack.
    mov %esp,%ebp               #  Move esp into ebp, so that we can consistently offset from the same location.

    sub $40,%esp                #  Allocate stack space.

    movl $0,-12(%ebp)           #  i = 0
    jmp FOR_CONDITION

    FOR_BODY:
        mov -12(%ebp),%eax      #  Move i into eax.
        lea (,%eax,4),%edx      #  Move i * 4 into edx.
        mov 8(%ebp),%eax        #  Move the address of list[0] into eax.
        add %edx,%eax           #  Add the address of list[0] and i * 4.
        mov (%eax),%eax         #  Move list[i] into eax.
        mov %eax,4(%esp)        #  Move list[i] onto stack.
        movl $fmt_str,(%esp)    #  Move printf format string onto stack.
        call printf             #  printf(fmt_str, list[i])
        addl $1,-12(%ebp)       #  i++

    FOR_CONDITION:
        mov -12(%ebp),%eax      #  Move i into eax.
        cmp 12(%ebp),%eax       #  Compare i with list_size.
        jl FOR_BODY

    movl $10,(%esp)             #  Move \n onto stack.
    call putchar                #  putchar(\n)

    movl $0,%eax                #  return 0
    leave                       #  Restore ebp and esp.
    ret                         #  Return to callee.

quick_sort:
    #  Save ebp and esp.
    push %ebp                   #  Push callee's ebp onto stack.
    mov %esp,%ebp               #  Move esp into ebp, so that we can consistently offset from the same location.

    sub $40,%esp                #  Allocate stack space.

    cmpl $1,12(%ebp)            #  if list_size < 2
    jg ELSE
    mov $0,%eax                 #  return 0
    jmp END

    ELSE:
        #  pivot = list[0]
        mov 8(%ebp),%eax        #  Move the address of list[0] into eax.
        mov (%eax),%eax         #  Move list[0] into eax. 
        mov %eax,-20(%ebp)      #  Move eax onto stack.

        #  L_idx = 0
        movl $0,-12(%ebp)       #  Move 0 onto stack.

        #  R_idx = size - 1
        mov 12(%ebp),%eax       #  Move list_size onto stack.
        sub $1,%eax             #  Subtract 1 from list_size.
        mov %eax,-16(%ebp)      #  Move list_size - 1 onto stack.

        jmp WHILE1_CONDITION

    WHILE2_BODY:
        addl $1,-12(%ebp)       #  L_idx++
        jmp WHILE2_CONDITION

    WHILE2_CONDITION:
        #  unsorted_list[L_idx] < pivot
        mov -12(%ebp),%eax      #  Move L_idx into eax.
        lea (,%eax,4),%edx      #  Move L_idx * 4 into edx.
        mov 8(%ebp),%eax        #  Move the address of list[0] into eax.
        add %edx,%eax           #  Add the address of list[0] and L_idx * 4.
        mov (%eax),%eax         #  Move list[L_idx] into eax. 
        cmp -20(%ebp),%eax      #  Compare pivot with list[L_idx].
        jge WHILE3_CONDITION

        #  L_idx < size
        mov -12(%ebp),%eax      #  Move L_idx into eax.
        cmp 12(%ebp),%eax       #  Compare list_size with L_idx.
        jl WHILE2_BODY
        jmp WHILE3_CONDITION 

    WHILE3_BODY:
        subl $1,-16(%ebp)       #  R_idx--
        jmp WHILE3_CONDITION

    WHILE3_CONDITION:
        #  unsorted_list[R_idx] > pivot
        mov -16(%ebp),%eax      #  Move R_idx into eax.
        lea (,%eax,4),%edx      #  Move R_idx * 4 into edx.
        mov 8(%ebp),%eax        #  Move the address of list[0] into eax.
        add %edx,%eax           #  Add the address of list[0] and R_idx * 4.
        mov (%eax),%eax         #  Move list[R_idx] into eax. 
        cmp -20(%ebp),%eax      #  Compare pivot with list[R_idx].
        jle SWAP

        #  R_idx > 0
        cmpl $0,-16(%ebp)       #  Compare 0 with R_idx.
        jg WHILE3_BODY

    SWAP:
        #  temp = unsorted_list[L_idx]
        mov -12(%ebp),%eax      #  Move L_idx into eax.
        lea (,%eax,4),%edx      #  Move L_idx * 4 into edx.
        mov 8(%ebp),%eax        #  Move the address of list[0] into eax.
        add %edx,%eax           #  Add the address of list[0] and L_idx * 4.
        mov (%eax),%eax         #  Move list[L_idx] into eax. 
        mov %eax,-24(%ebp)      #  Move list[L_idx] onto stack.

        #  unsorted_list[L_idx] = unsorted_list[R_idx]
        mov -12(%ebp),%eax      #  Move L_idx into eax.
        lea (,%eax,4),%edx      #  Move L_idx * 4 into edx.
        mov 8(%ebp),%eax        #  Move the address of list[0] into eax.
        add %eax,%edx           #  Add the address of list[0] and L_idx * 4.
        mov -16(%ebp),%eax      #  Move R_idx into eax.
        lea (,%eax,4),%ecx      #  Move R_idx * 4 into ecx.
        mov 8(%ebp),%eax        #  Move the address of list[0] into eax.
        add %ecx,%eax           #  Add the address of list[0] and R_idx * 4.
        mov (%eax),%eax         #  Move list[R_idx] into eax.
        mov %eax,(%edx)         #  list[L_idx] = list[R_idx]

        #  unsorted_list[R_idx] = temp
        mov -16(%ebp),%eax      #  Move R_idx into eax.
        lea (,%eax,4),%edx      #  Move R_idx * 4 into edx.
        mov 8(%ebp),%eax        #  Move the address of list[0] into eax.
        add %eax,%edx           #  Add the address of list[0] and R_idx * 4.
        mov -24(%ebp),%eax      #  Move temp into eax.
        mov %eax,(%edx)         #  list[R_idx] = temp

    WHILE1_CONDITION:
        #  L_idx < R_idx
        mov -12(%ebp),%eax      #  Move L_idx into eax.
        cmp -16(%ebp),%eax      #  Compare R_idx with L_idx.
        jl WHILE2_CONDITION

    #  quick_sort(unsorted_list, L_idx)
    mov -12(%ebp),%eax          #  Move L_idx into eax.
    mov %eax,4(%esp)            #  Move L_idx onto stack.
    mov 8(%ebp),%eax            #  Move the address of list[0] into eax.
    mov %eax,(%esp)             #  Move the address of list[0] onto stack.
    call quick_sort             #  quicksort(list, L_idx)

    #  quick_sort(&unsorted_list[L_idx + 1], size - L_idx - 1)
    mov -12(%ebp),%eax          #  Move L_idx into eax.
    mov 12(%ebp),%edx           #  Move list_size into edx.
    mov %edx,%ecx               #  Move list_size into ecx.
    sub %eax,%ecx               #  Subtract L_idx from list_size.
    mov %ecx,%eax               #  Move list_size - L_idx into eax.
    lea -1(%eax),%edx           #  Move list_size - L_idx - 1 into edx.
    mov -12(%ebp),%eax          #  Move L_idx into eax.
    add $1,%eax                 #  Add 1 to L_idx.
    lea (,%eax,4),%ecx          #  Move (L_idx + 1) * 4 into ecx.
    mov 8(%ebp),%eax            #  Move the address of list[0] into eax.
    add %ecx,%eax               #  Add  (L_idx + 1) * 4 to the address of list[0].
    mov %edx,4(%esp)            #  Move list_size - L_idx - 1 onto stack.
    mov %eax,(%esp)             #  Move address of list[L_idx + 1] onto stack.
    call quick_sort             #  quicksort(&list[L_idx + 1], list_size - L_idx - 1)

    movl $0,%eax                #  return 0
    END:
        leave                   #  Restore ebp and esp.
        ret                     #  Return to the callee.
