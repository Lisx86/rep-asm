.data
size:
    .long 5
number:
    .long 12345
digits:
    .long 9, 9, 9, 9, 9

.text
_exit:
   movl $0, %ebx
   movl $1, %eax
   int $0x80

.global main
main:
    movl number, %eax # init working  number
    movl $10, %ebx    # set dividing value
    movl $0, %edi     # init writing index

    split:
        movl $0, %edx  # need to reset each time
        idiv %ebx      # actual division
        movl %edx, digits(, %edi, 4)    #take the rest from edx
        addl $1, %edi     #increment the destination index
        cmpl $0, %eax     # inf (eax == 0) { break }
    jne split

call _exit





