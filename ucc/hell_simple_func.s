.text                           # section declaration


print_it:
    push %rcx   # save registers

    mov $msg, %edi  # print the message
    call puts       #

    pop %rcx  # restore registers
  ret
		                          # we must export the entry point to the ELF linker or
.global main              # loader. They conventionally recognize _start as their
main:

    mov $3, %rcx
repeat:
    call print_it
  loop repeat

     movl    $0,%ebx             # first argument: exit code
     movl    $1,%eax             # system call number (sys_exit)
     int     $0x80               # call kernel
   
.data                           # section declaration
msg:
	.asciz "Hello, world!"   # our dear string
	len = . - msg                 # length of our dear string

