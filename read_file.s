# FUNCTION READ_FILE:

# Read from a text file into a buffer. 
# (in)  a0: filename address (char*) 
# (in/out) a1: destination buffer 
# (in)     a2: maximum number of bytes to read 
read_file: 
addi sp,sp,-16
sw ra, 12(sp)
sw a1, 8(sp)
sw a2, 4(sp)

# Abrir o ficheiro:
li a1, 0     # flag a zero 
li a7, 1024  # open
ecall        # a0 = fd (fd < 0 se houve erro)

# verificar se fd é válido (fd >= 0):
blt a0, x0, invalid_fd  # fd < 0 (error 41)
sw a0, 0(sp)            # guardar fd na stack para depois fazer close

# Ler o ficheiro:
lw a1, 8(sp)  # restaurar o endereço do buffer
lw a2, 4(sp)  # restaurar o tamanho
li a7, 63     # ler o ficheiro
ecall

# Fechar o ficheiro:
lw a0, 0(sp)
li a7, 57
ecall

# Restaurar a stack:
lw ra, 12(sp)
addi sp, sp, 16
jr ra

invalid_fd:
  li a0, 41
  li a7, 93
  ecall
