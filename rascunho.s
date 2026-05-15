    ###########################################################################
    # Read vocabulary
    ###########################################################################
    la a0, INPUT_FILENAME       # coloca o adress o ficheiro do input
    li a1, 0
    li a2, 0
    li a7, CONST_SYSCALL_OPEN   # escolhe syscall open
    ecall                       # executa syscall (fd) fica em a0
    mv s0, a0                   # guarda fd depois do ecall open

    mv a0, s0                   # fd fica em a0 antes de read
    la a1, INPUT_BUFFER         # coloca o adress onde vai colocar o buffer do ficheiro
    li a2, CONST_BUFFER_SIZE    # coloca em a2 o número máximo de bytes a ler
    li a7, CONST_SYSCALL_READ   # escolhe syscall read
    ecall                       # executa leitura

    mv a0, s0                   # coloca o fd em a0 para o close
    li a7, CONST_SYSCALL_CLOSE  # escolhe syscall close
    ecall                       # close file

    ###########################################################################
    # Read input
    ###########################################################################
    la a0, VOCABULARY_FILENAME  # coloca o adress o ficheiro do vocabulário
    li a1, 0
    li a2, 0
    li a7, CONST_SYSCALL_OPEN   # escolhe syscall open
    ecall                       # executa syscall (fd) fica em a0
    mv s0, a0                   # guarda fd depois do ecall open

    mv a0, s0                   # fd fica em a0 antes de read
    la a1, VOCAB_BUFFER         # coloca o adress onde vai colocar o buffer do ficheiro
    li a2, CONST_BUFFER_SIZE    # coloca em a2 o número máximo de bytes a ler
    li a7, CONST_SYSCALL_READ   # escolhe syscall read
    ecall                       # executa leitura

    mv a0, s0                   # coloca o fd em a0 para o close
    li a7, CONST_SYSCALL_CLOSE  # escolhe syscall close
    ecall                       # close file
