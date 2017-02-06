.text                           # section declaration


print_it:
    push %edx   # save registers
    push %ecx
    push %ebx
    push %eax

    mov  $len, %edx             #third argument: message length
    mov  $msg, %ecx             #second argument: pointer to message to write
    mov  $1, %ebx               #first argument: file handle (stdout)
    mov  $4, %eax               #system call number (sys_write)
    int  $0x80                #call kernel

    pop %eax  # restore registers
    pop %ebx
    pop %ecx
    pop %edx
  ret

print_xtimes:
  push %ebp
  mov %esp, %ebp
    movl $0, %ecx       # reset ecx
    mov 8(%ebp), %ecx   # read repeat size from the argument into ecx
    
repeat:
    call print_it # action
  loop repeat

  pop %ebp 
  ret
		                          # we must export the entry point to the ELF linker or
.global main              # loader. They conventionally recognize _start as their
main:
 
    push (var1) # pass argument
    call print_xtimes

     movl    $0,%ebx             # first argument: exit code
     movl    $1,%eax             # system call number (sys_exit)
     int     $0x80               # call kernel
   
.data                           # section declaration
var1:
        .long 3
msg:
	.asciz "Hello!\n"   # our dear string
len:
        .long . - msg
#times: addresses of this label completeley different from &msg but the 0x03 is present
