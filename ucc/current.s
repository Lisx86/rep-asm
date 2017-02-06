.text                           # section declaration

print:
  mov $len, %edx
  mov $msg, %ecx
  mov $1, %ebx
  mov $4, %eax
  int $0x80
  ret
terminate:
     movl    $0,%ebx             # first argument: exit code
     movl    $1,%eax             # system call number (sys_exit)
     int     $0x80               # call kernel

	                          # we must export the entry point to the ELF linker or
.global main              # loader. They conventionally recognize _start as their
main:

    call print
    call terminate  
.data                           # section declaration
msg:
	.asciz "Hello, world!"   # our dear string
	len = . - msg                 # length of our dear string

