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





    ###########################################
    ###########################################
    compute_scores:
  # Stack:
  addi sp, sp, -36  # 8*4=36
  sw ra, 36(sp)
  sw s0, 32(sp)
  sw s1, 28(sp)
  sw s2, 24(sp)
  sw s3, 20(sp)
  sw s4, 16(sp)
  sw s5, 12(sp)
  sw s6, 8(sp)
  sw s7,4(sp)

  # Saving given arguments (before calling the dot function):
  lw s0, a0
  lw s1, a1
  lw s2, a2
  lw s3, a3
  lw s4, a4
  lw s5, a5

  # Calculating Q[target] adress: Q_base + target * columns * 4
  mul s6, s5,s4    # target * columns
  slii s6, s6, 2   # (target * columns) * 4
  add s6, s6, s1   # Q_base + (target * columns * 4)

  # relevance score calculation: score(j) = Q[n-1] . K[j] for all values
  li s7, 0  # initializing j=0
  relevance_loop:
    bge s7, s3, end_relevance loop
    # calculating K[j] adress:
    mul t0, s7, s4
    slli t0, t0, 2
    add t1, s2, t0    # t1 = &K[J]
