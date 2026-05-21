VOCABULARY_FILENAME:     .string "vocab.txt"
EMBEDDINGS_FILENAME:     .string "embeddings.txt"
INPUT_FILENAME:          .string "input.txt"

W_Q_FILENAME:            .string "W_Q.txt"
W_K_FILENAME:            .string "W_K.txt"
W_V_FILENAME:            .string "W_V.txt"

# (in/out) a0: address of the output scores vector to fill (int*)
# (in)     a1: address of Q matrix (int*)
# (in)     a2: address of K matrix (int*)
# (in)     a3: #rows of Q and K (int)
# (in)     a4: #columns of Q and K (int)
# (in)     a5: target token index for which we want to compute the score (int)
compute_scores:
    addi sp, sp, -36
    sw ra, 0(sp)
    sw s0, 4(sp)        # para o offset da 
    sw s1, 8(sp)        # ponteiro para o Q
    sw s2, 12(sp)
    sw s3, 16(sp)
    sw s4, 20(sp)
    sw s5, 24(sp)
    sw s6, 28(sp)
    sw s7, 32(sp)

    mv s1, a1
    mv s2, a2           # ponteiro de K
    mv s3, a0
    mv s6, a3           # para guardar o número de colunas
    mv s7, a4           # para guardar o número de colunas
    li s4, 0            # contador para os loops das multiplicações

    # para somar o offset ao ponteiro de Q
    slli s0, s7, 2      # guarda em s0 a "distância" de uma coluna
    mv s5, s0           # offset para K
    mul s0, s0, a5      # guarda em s0 o offset 
    add s1, s1, s0          # soma o offset ao ponteiro de Q que usamos

loop_compute_scores:
    beq s4, s6, compute_scores_end
    mv a1, s1
    mv a2, s2
    mv a3, s7
    jal ra, dot
    # falta verificar se dá success
    sw a1, 0(s3)
    addi s3, s3, 4  # avança um byte
    add s2, s2, s5
    addi s4, s4, 1
    j loop_compute_scores

compute_scores_end:
    lw s7, 32(sp)
    lw s6, 28(sp)
    lw s5, 24(sp)
    lw s4, 20(sp)
    lw s3, 16(sp)
    lw s2, 12(sp)
    lw s1, 8(sp)
    lw s0, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 36
    jr ra
