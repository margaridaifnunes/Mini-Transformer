# ===========================================================================
# PROJETO_2 IAC
# Grupo: Número 18
# Grupo constituído por:
#    - Henrique Ascenção Lopes da Silva Gonçalves      ISTID: ist1118062
#    - Margarida Isabel Farinha Nunes                  ISTID: ist1117809
#    - Victória Bernaz                                 ISTID: ist1117771
# 
# ===========================================================================

###########################################################################
# Upper bound constants for static memory reservation
###########################################################################
.equ CONST_DIMENSION 4
.equ CONST_BUFFER_SIZE 1024
.equ CONST_MAX_VOCAB_TOKENS 100
.equ CONST_MAX_INPUT_TOKENS 10

###########################################################################
# System call constants
###########################################################################
.equ CONST_SYSCALL_PRINT_INT 1
.equ CONST_SYSCALL_PRINT_STRING 4
.equ CONST_SYSCALL_PRINT_CHAR 11
.equ CONST_SYSCALL_EXIT 10
.equ CONST_SYSCALL_EXIT2 93
.equ CONST_SYSCALL_OPEN 1024
.equ CONST_SYSCALL_CLOSE 57
.equ CONST_SYSCALL_READ 63
.equ CONST_SYSCALL_WRITE 64

###########################################################################
# ASCII character constants
###########################################################################
.equ CONST_CHAR_EOF 0
.equ CONST_CHAR_SPACE 32
.equ CONST_CHAR_NEWLINE 10
.equ CONST_CHAR_HYPHEN 45
.equ CONST_CHAR_ZERO 48

.data

VOCAB_BUFFER:            .zero CONST_BUFFER_SIZE                              # Contents of the vocabulary file
INPUT_BUFFER:            .zero CONST_BUFFER_SIZE                              # Contents of the input file
MATRIX_BUFFER:           .zero CONST_BUFFER_SIZE                              # Contents of a matrix file (used for W_Q, W_K, W_V, and embeddings)


INPUT_INDICES_VECTOR:    .zero (CONST_MAX_INPUT_TOKENS * 4)                   # Vector of input token indices (#inputs x 4 bytes)
SCORES_VECTOR:           .zero (CONST_MAX_INPUT_TOKENS * 4)                   # Vector of scores (#tokens x 4 bytes)

INPUT_TOTAL_TOKENS:      .word 0                                              # Number of tokens in the input
VOCAB_TOTAL_TOKENS:      .word 0                                              # Number of tokens in the vocabulary

VOCAB_EMBEDDINGS_MATRIX: .zero (CONST_MAX_VOCAB_TOKENS * CONST_DIMENSION * 4) # Embedding matrix (#tokens x dimension x 4 bytes)
INPUT_EMBEDDINGS_MATRIX: .zero (CONST_MAX_INPUT_TOKENS * CONST_DIMENSION * 4) # Embedding matrix (#tokens x dimension x 4 bytes)
W_Q_MATRIX:              .zero (CONST_DIMENSION * CONST_DIMENSION * 4)        # W_Q matrix (dimension x dimension x 4 bytes)
W_K_MATRIX:              .zero (CONST_DIMENSION * CONST_DIMENSION * 4)        # W_K matrix (dimension x dimension x 4 bytes)
W_V_MATRIX:              .zero (CONST_DIMENSION * CONST_DIMENSION * 4)        # W_V matrix (dimension x dimension x 4 bytes)
Q_MATRIX:                .zero (CONST_MAX_INPUT_TOKENS * CONST_DIMENSION * 4) # Q matrix (#tokens x dimension x 4 bytes)
K_MATRIX:                .zero (CONST_MAX_INPUT_TOKENS * CONST_DIMENSION * 4) # K matrix (#tokens x dimension x 4 bytes)
V_MATRIX:                .zero (CONST_MAX_INPUT_TOKENS * CONST_DIMENSION * 4) # V matrix (#tokens x dimension x 4 bytes)

# US

DECIDE_VECTOR:          .zero (CONST_MAX_INPUT_TOKENS * 4)                    # DECIDE_VECTOR (CONST_MAX_INPUT_TOKENS X 4 bytes)
COLUMN_VECTOR:          .zero (CONST_DIMENSION * 4)

                           # column_VECTOR (dimension X 4 bytes)       
###########################################################################
# Data section with static memory reservations.
# Feel free to add more if needed.
###########################################################################
VOCABULARY_FILENAME:     .string "C:\Users\halsg\IAC\P2_skeleton\vocab.txt"
EMBEDDINGS_FILENAME:     .string "C:\Users\halsg\IAC\P2_skeleton\embeddings.txt"
INPUT_FILENAME:          .string "C:\Users\halsg\IAC\P2_skeleton\input.txt"

W_Q_FILENAME:            .string "C:\Users\halsg\IAC\P2_skeleton\W_Q.txt"
W_K_FILENAME:            .string "C:\Users\halsg\IAC\P2_skeleton\W_K.txt"
W_V_FILENAME:            .string "C:\Users\halsg\IAC\P2_skeleton\W_V.txt"



.text
main:
    ###########################################################################
    # Read vocabulary
    ###########################################################################
    la a0, VOCABULARY_FILENAME  # coloca o adress o ficheiro do vocabulário
    la a1, VOCAB_BUFFER         # coloca o adress onde vai colocar o buffer do ficheiro
    li a2, CONST_BUFFER_SIZE    # coloca em a2 o número máximo de bytes a ler
    
    jal ra, read_file
    mv s0, a1
    ###########################################################################
    # Read input
    ###########################################################################
    la a0, INPUT_FILENAME       # coloca o adress o ficheiro do input
    la a1, INPUT_BUFFER         # coloca o adress onde vai colocar o buffer do ficheiro
    li a2, CONST_BUFFER_SIZE    # coloca em a2 o número máximo de bytes a ler
    
    jal ra, read_file
    mv s1, a1                   # salva o buffer do input
    ###########################################################################
    # Read W_Q matrix
    ###########################################################################
    la a0, W_Q_FILENAME          # coloca o adress o ficheiro do input
    la a1, MATRIX_BUFFER         # coloca o adress onde vai colocar o buffer do ficheiro
    li a2, CONST_BUFFER_SIZE     # coloca em a2 o número máximo de bytes a ler

    jal ra, read_file
    ###########################################################################
    # Parse W_Q matrix from buffer
    ###########################################################################
    la a0, W_Q_MATRIX

    jal ra, parse_matrix_buffer
    mv s2, a0 
    ###########################################################################
    # Read W_K matrix
    ###########################################################################
    la a0, W_K_FILENAME          # coloca o adress o ficheiro do input
    la a1, MATRIX_BUFFER         # coloca o adress onde vai colocar o buffer do ficheiro
    li a2, CONST_BUFFER_SIZE     # coloca em a2 o número máximo de bytes a ler

    jal ra, read_file
    ###########################################################################
    # Parse W_K matrix from buffer
    ###########################################################################
    la a0, W_K_MATRIX

    jal ra, parse_matrix_buffer
    mv s7, a1
    mv s8, a0
    ###########################################################################
    # Read W_V matrix
    ###########################################################################
    la a0, W_V_FILENAME         # coloca o adress o ficheiro do input
    la a1, MATRIX_BUFFER        # coloca o adress onde vai colocar o buffer do ficheiro
    li a2, CONST_BUFFER_SIZE    # coloca em a2 o número máximo de bytes a ler
    
    jal ra, read_file
    ###########################################################################
    # Parse W_V matrix from buffer
    ###########################################################################
    la a0, W_V_MATRIX

    jal ra, parse_matrix_buffer
    mv s6, a0
    mv s9, a1
     ###########################################################################
    # Read embeddings matrix
    ###########################################################################
    la a0, EMBEDDINGS_FILENAME   # coloca o adress o ficheiro do input
    la a1, MATRIX_BUFFER         # coloca o adress onde vai colocar o buffer do ficheiro
    li a2, CONST_BUFFER_SIZE     # coloca em a2 o número máximo de bytes a ler

    jal ra, read_file
    mv s3, a1                   # salva o buffer da matriz
    ###########################################################################
    # Parse vocabulary embeddings matrix from buffer
    ###########################################################################
    la a0, VOCAB_EMBEDDINGS_MATRIX  
    la a1, MATRIX_BUFFER
    
    jal ra, parse_matrix_buffer
    mv s11, a0                   # salva o endereço da matriz    
    mv s4, a1               
    ###########################################################################
    # Convert input tokens to indices
    ###########################################################################
    mv a3, s0                   # vai buscar o buffer do vocabulario
    mv a2, s1                   #vai buscar o buffer dos inputs
    la a0, INPUT_INDICES_VECTOR
   
    jal ra, tokens_to_indices
    ###########################################################################
    # Build input embeddings matrix
    ###########################################################################
    #a1 -> PONTIERO PARA MATRIZ EMBEDIG
    #a2 -> PONTEIRO MATRIZ INPUTS
    #a3 -> NUMERO DE TOKENS
    mv a2, a0                       # a2 -> penteiro dos inpits (input)
    mv a3, a1                       # a3 -> tamanhodo vetor (numero de tokens)
    mv a1, s11                      # a1 -> matriz do vocab preenchinda
    la a0, INPUT_EMBEDDINGS_MATRIX
    
    jal ra, build_input_embeddings_matrix
    mv s5, a0
    mv s10, a3                      # guardar o nº de tokens para select_vector
    ###########################################################################
    # Build matrix Q
    ###########################################################################
    la a0, Q_MATRIX
    mv a1, s5
    mv a2, s4
    li a3, 4
    mv a4, s2
    li a5, 4
    li a6, 4

    jal ra, matrix_multiply
    ###########################################################################
    # Build matrix K
    ###########################################################################
    la a0, K_MATRIX
    mv a1, s5
    mv a2, s4
    li a3, 4
    mv a4, s8
    mv a5, s7
    li a6, 4

    jal ra, matrix_multiply
    ###########################################################################
    # Build matrix V
    ###########################################################################
    la a0, V_MATRIX
    mv a1, s5
    mv a2, s4
    li a3, 4
    mv a4, s6
    mv a5, s9
    li a6, 4

    jal ra, matrix_multiply
    ###########################################################################
    # Compute scores for the last input token
    ###########################################################################
    la a0, SCORES_VECTOR
    la a1, Q_MATRIX
    la a2, K_MATRIX
    mv a3, s10
    li a4, 4
    addi t0, s10, -1
    mv a5, t0

    jal ra, compute_scores
    debug: #a0
    ###########################################################################
    # Get the highest score index using argmax
    ###########################################################################
    la a1, SCORES_VECTOR
    mv a2, s10        # array lenght = nº de tokens

    jal ra, argmax
    ###########################################################################
    # Select chosen vector in V using the index from argmax
    ###########################################################################
    mv a4, a1           # índice vindo do argmax
    la a1, V_MATRIX     # endereço da matriz V
    mv a2, s10          # nº de linhas (= nº de tokens)
    li a3, 4            # nº de colunas
    

    jal ra, select_vector_in_matrix
    ###########################################################################
    # Pick the next token in the vocabulary with the highest score
    ###########################################################################
    mv a1, s11
    mv a2, s4
    jal ra, decide_next_token

    mv t1, a0
    la t0, VOCAB_BUFFER

    loop_finding_word:
        beqz t1, word_found
        lb t2, 0(t0)
        addi t0, t0, 1
        li t3, CONST_CHAR_NEWLINE
        bne t2, t3, loop_finding_word
        addi t1, t1, -1
        j loop_finding_word

    word_found:
        mv a0, t0
        jal ra, print_predicted_token
    ###########################################################################
    # Terminate program successfully
    ###########################################################################
    li a0, 0
    j exit_with_code                                # Exit with code 0

# Read from a text file into a buffer.
# (in/out) a0: filename address (char*)
# (in/out) a1: destination buffer
# (in)     a2: maximum number of bytes to read
# (out)    a7: code -1 for error
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
    li a7, 63     # ler o ficheiro (a1 = filename adress, a2 = maximum number of bytes to read)
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
  li a7, 93
  ecall


# Assumes the matrix is stored in the buffer as space-separated integers.
# Assumes columns are separated by 1 space (' '), and rows by 1 newline ('\n').
# Assumes only signed integers are provided.
# (in/out) a0: address of the matrix to fill (int*)
# (out)    a1: number of rows in the matrix (int)
# (in)     a1: address of the buffer containing the matrix data (char*)
parse_matrix_buffer:
    addi sp ,sp -12              # reserva 12 bytes para a stack
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    mv s0, a0
    li t2, 0
    li t3 ,1                    # t3 é o sinal do numero
    li t5, 10
    li s1, 0

    loop_byte:
        lb t1, 0(a1)            # t1 = byte a anilzar 
        li t0,CONST_CHAR_SPACE      # codigo do space
            beq t1, t0, space   # se t1 é ' '

        li t0, CONST_CHAR_NEWLINE   # codigo do Newline
            beq t1, t0,new_row     # se t1 é '\n'

        li t0, CONST_CHAR_EOF       # codigo do EOF
            beq t1, t0, loop_end    # se t1 é EOF
            
        li t0, CONST_CHAR_HYPHEN    # codigo do '-'
            beq t1, t0, negative    # se t1 e '-'
        #conversão

        
        li t0, CONST_CHAR_ZERO
        sub t1,t1, t0                #converter para ASCII ( t1 - 48 ('0'))
        
        mul s1, s1, t5               # multiplicar por 10 (X t5)
        add s1,s1,t1                 # adicionar o dígito atrás do número
        j next_digit                 #vai para o proximo digito
    
    
    space:
        mul s1, s1 ,t3              # + - s1
        mul t3,t3,t3                # t3 ->1 (independentemente do sinal)                 
        sw s1, 0(a0)                #guarda o s1
        li s1, 0                    # mete o s1 a 0
        addi a0, a0, 4              # aumenta o endereço do
        j next_digit

    negative:
        li t3, -1                   # o numero asseguir vai ser negativo
    
    next_digit:
        addi a1 ,a1 ,1              # vai para o proximo byte
        j loop_byte                 # volta para o loop

    new_row:
        addi t2 ,t2 ,1          # +1 row
        j space
    loop_end:
        addi t2, t2, 1         # adicionar mais 1 se for o fim
        mul s1, s1, t3
        sw s1, 0(a0)
        addi a0, a0, 4
        mv a1 ,t2
        mv a0, s0
        lw ra, 0(sp)
        lw s0, 4(sp)            # rstaurar o ra
        lw s1, 8(sp)
        addi sp, sp ,12          # desalocar o stack
        jr ra                   # voltar para a chamada

# Converts the input tokens into their corresponding indices in the vocabulary.
# (in/out) a0: address of input indices vector to fill (int*)
# (out)    a1: size of input indices vector (number of tokens in input)
# (in)     a2: address to input buffer
# (in)     a3: address to vocabulary buffer
tokens_to_indices:
    # a0 -> PONIRO PARA MATRIZ A PREENCHER
    # a2 -> PONTEIROO PARAAA INPUT
    # a3 -> PONTERIO PARA O VOCABULÁRIO

    addi sp, sp, -16
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)

    mv s0, a0               # não perder o inicio da matriz a encher
    mv s1, a3               # não perder o inicio do vocabulário
    mv s2, a2               # não perder o inicio do input a analizar

    li t3, 0                # tamanho do vetor
    li t4, 0                # contador do indice do vocabulário

    loop_input:
        lb t1, 0(a2)                # analiza o t1
        li t0, CONST_CHAR_NEWLINE   # codigo do Newline
            beq t1, t0,next_input_word     # se t1 é '\n'

        li t0, CONST_CHAR_EOF       # codigo do EOF
            beq t1, t0, end_loop_tokens    # se t1 é EOF

    loop_vocab:
        lb  t5, 0(a3)               # bit do vocab a analizar
        lb  t1, 0(a2)               # bit do input a analizar

        li t0, CONST_CHAR_EOF       # codigo do EOF
            beq t5, t0, end_loop_tokens    # se t5 é EOF

        loop_letter:
            bne t1,t5,next_vocab_word #verifica se os bytes são iguais

            li t0, CONST_CHAR_NEWLINE   # codigo do Newline
                beq t1, t0,add_word     # se t1 é '\n'
            li t0, CONST_CHAR_SPACE     # codigo do SPACE
                beq t1, t0, add_word    # se t1 é ' '
            
            addi a3, a3,1
            addi a2, a2, 1
            lb  t5, 0(a3)       # proximo bit do vocab a analizar
            lb  t1, 0(a2)       # proximo bit do input a analizar
            j loop_letter  

    add_word:
        sw t4, 0(a0)
        addi t3, t3 ,1              # incrementa o tamanho do vetor 
        addi a0, a0, 4              # incrementa o endereço da matriz
        j next_input_word
        
    next_vocab_word:
        addi t4, t4, 1  # t4 = t4 + imm

        ignore_line:
            addi a3, a3, 1              # proximo bit (à frente do newline)
            lb t5, 0(a3)    
            li t0, CONST_CHAR_NEWLINE   # codigo do Newline
            bne t5, t0, ignore_line # verifica se é igual a newline
        mv a2, s2                   # voltar ao inicio da palavra a analizar
        addi a3, a3,1
        j loop_vocab

    next_input_word: # meter o apontador (a2) na posiçao do proximo bit
        addi a2,a2, 1
        mv t4, x0
        mv s2, a2
        mv a3, s1
        j loop_input

    end_loop_tokens:
        mv a0, s0           # a0 para s0
        mv a1, t3           # a1 para o tamanho do vetor
        lw ra, 0(sp)
        lw s0, 4(sp)
        lw s1, 8(sp)
        lw s2, 12(sp)
        addi sp, sp, 16
        jr ra

# (in/out) a0: address of the output matrix to fill (int*)
# (in)     a1: address of the vocabulary embeddings matrix (int*)
# (in)     a2: address of the input indices array (int*)
# (in)     a3: number of tokens in the input (int)
build_input_embeddings_matrix:
    #a1 -> PONTIERO PARA MATRIZ EMBEDIG
    #a2 -> PONTEIRO MATRIZ INPUTS
    #a3 -> NUMERO DE TOKENS
    addi sp, sp, -12
    sw s1, 8(sp)    
    sw s0, 4(sp)
    sw ra, 0(sp)
    

    mv s0, a0                   # endereço da matriz a preencher
    mv s1, a1                   # inicio da matriz embedings vocab

    li t0, 0                    # indice dos tokens
    li t2, 0                    # offset
    loop_indice_vector:
        bge t0, a3,end_indice_loop     # se o indice é superior ao limite
        mv a1, s1               # voltar ao inicio da embeding
        lw t1, 0(a2)            # o conteudo do endereço do dos inputs
        slli t2, t1, 4          # calcula o offset
        add a1, a1, t2         # o ponteiro final na matriz embedigs
        li t3, 4                # contador dos elementos por linha 
        addi t0, t0 ,1          # incrementa o indice
        addi a2, a2, 4          # proximo input    
        adding_number:
            beqz t3, loop_indice_vector # se t3 == 0 -> fim da linha
            lw t2, 0(a1)                # conteudo do embeding
            sw t2, 0(a0)                # insere na matriz (a0)
            addi a0, a0 ,4              # incrementa o ponteiro da matriz (a0)
            addi a1, a1, 4              # incrementa o ponteiro do embeding
            addi t3, t3, -1             # decrementa o contador
            j adding_number

    end_indice_loop:
    mv a0, s0                           # retornar o ponteiro para a matriz
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    addi sp, sp, 12
    jr ra

# (in/out) a0: address of the output matrix to fill (int*)
# (in)     a1: address of the first matrix (int*)
# (in)     a2: #rows of the first matrix (int)
# (in)     a3: #columns of the first matrix (int)
# (in)     a4: address of the second matrix (int*)
# (in)     a5: #rows of the second matrix (int)
# (in)     a6: #columns of the second matrix (int)
matrix_multiply:
    addi sp sp -32
    sw ra, 0 (sp)
    sw s0, 4 (sp)
    sw s1, 8 (sp)
    sw s2, 12(sp)
    sw s3, 16(sp)
    sw s4, 20(sp)
    sw s5, 24(sp)  
    sw s6, 28(sp)
       
    # store dos argumentos
 

    #blez a5, exit_with_error
    #blez a2, exit_with_error
    #bne a3, a5, exit_with_error
    mv s0, a0
    mv s1, a1           # apontador para o inicio da 1ª matriz
    mv s2,a4            # apontador para o inicio da 2ª matriz
    mv s3,s0            # ponteiro andante da matriz de retorno
    mv s4, a6    
    mv s5, a2
    mv s6, a4           # apontador difinitivo da 2ª matriz
    
    loop_matrix:  
        beqz s5, matrix_mult_end
        mv a6,s4
        mv s2,s6
        loop_column:
            beqz a6, next_line
            addi a6,a6,-1
            j apply_dot

    apply_dot:
        mv a1,s1
        mv a2,s2
        li a3, 4
        li a4, 4
        jal ra, dot
        sw a1, 0(s3)
        addi s3, s3, 4
        addi s2, s2, 4
        j loop_column
    
    next_line:
        addi s1, s1, 16
        addi s5, s5, -1
        
        j loop_matrix

    matrix_mult_end:
        mv a0, s0
        lw ra, 0(sp)
        lw s0 ,4(sp)
        lw s1, 8(sp)
        lw s2, 12(sp)
        lw s3, 16(sp)
        lw s4, 20(sp)
        lw s5, 24(sp)
        lw s6, 28(sp)
        addi sp, sp, 32
        jr ra

# (in/out) a0: address of the output scores vector to fill (int*)
# (in)     a1: address of Q matrix (int*)
# (in)     a2: address of K matrix (int*)
# (in)     a3: #rows of Q and K (int)
# (in)     a4: #columns of Q and K (int)
# (in)     a5: target token index for which we want to compute the score (int)
compute_scores:
    addi sp, sp, -32
    sw ra, 0(sp)
    sw s0, 4(sp)        # para o offset da 
    sw s1, 8(sp)        # ponteiro para o Q
    sw s2, 12(sp)
    sw s3, 16(sp)
    sw s4, 20(sp)
    sw s5, 24(sp)
    sw s6, 28(sp)

    #beq a3,a4, erro
    
    mv s0, a0           # ponteiro de retorno
    mv s1, a1           # ponteiro de Q
    mv s2, a2           # ponteiro de K
    mv s3, a3           # ponteiro de scores
    mv s4, a4
    mv s5, a0           # ponteiro FIXO do scores_vector

            #a5 É O N-1 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!      
    

    # Clacular Q[target] adress = Q[base] + Target * columns * 4 bytes
    mul t0, a5, s4      # Target X columns
    slli t0, t0, 2      # Traget X columns * 4 bytes
    add s1, t0, s1      # soma o offset ao ponteiro de Q que usamos  

    

    # score[j] = dot(Q[n-1], K[j])
    li s6,0                             #s6 -> j
    loop_compute_scores:
        bge s6, s3, compute_scores_end
        # k[j]:
            slli t0, s6, 2       # incremento para o ponteiro de K
            add t1, s2, t0      # ponteiro de K a multiplicar
    
        mv a1, s1
        mv a2, t1
        mv a3, s4
        mv a4, s4
        jal ra, dot
        # falta verificar se dá success
        sw a1, 0(s0)
        addi s0, s0, 4  # avança um byte no vetor final
        addi s6, s6, 1  # incrementa o contador do loop
        j loop_compute_scores

compute_scores_end:
    mv a0, s5
    lw s6, 28(sp)
    lw s5, 24(sp)
    lw s4, 20(sp)
    lw s3, 16(sp)
    lw s2, 12(sp)
    lw s1, 8(sp)
    lw s0, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 32
    jr ra

# (out) a0: address of the selected vector (int*)
# (in)  a1: address of matrix (int*)
# (in)  a2: #rows (int)
# (in)  a3: #cols (int)
# (in)  a4: target row
select_vector_in_matrix:
    bgt a4, a2, invalid_row
    mul t0, a4, a3
    slli t0, t0, 2
    add a0, a1, t0
    jr ra

invalid_row:
  li a7, 93
  ecall

# (out) a0: index of the predicted token in the vocabulary (int)
# (in)  a0: address of target vector (int*)
# (in)  a1: vocabulary embeddings address (int*)
# (in)  a2: number of tokens in vocabulary (int)
decide_next_token:
    addi sp, sp, -24
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)
    sw s3, 16(sp)
    sw s4, 20(sp)


    mv s0, a0   # ponteiro para o vetor
    mv s1, a1   # ponteiro para os embedings do vocabulário
    mv s2, a2   # nº de tokens no vocabulário
    
    la s4, DECIDE_VECTOR
    li t0, 0
    li t1, 0
    li s3, 0    # contador do indice do vocabulário
    loop_embeding:
        beq s3,s2, decide_end
        mv a1, s0
        mv a2, s1
        li a3, 4
        li a4, 1
        jal ra, dot
        #bnez a0, salta
        slli t0, s3, 2 
        add t0, s4, t0
        sw a1, 0(t0)
        addi s1, s1, 16
        addi s3, s3, 1
        j loop_embeding


    decide_end:
        mv a1, s4
        mv a2, s2
        jal ra, argmax
        #bnez a0, salta
        mv a0, a1
        lw ra, 0(sp)
        lw s0, 4(sp)
        lw s1, 8(sp)
        lw s2, 12(sp)
        lw s3, 16(sp)
        lw s4, 20(sp)
        addi sp, sp, 24
        jr ra
        









#############################################################################################################
# Dot product and argmax helper functions.
#############################################################################################################

# (in)  a1: address of first vector (int*)
# (in)  a2: address of second vector (int*)
# (in)  a3: length of the vectors (int)
# (in)  a4: tamanho do incremento (int)
# (out) a0: status code (0 for success, non-zero for error)
# (out) a1: dot product result (int)
dot:
    li t5,4
    mul a4,a4,t5
    addi sp, sp, -4
    sw ra, 0(sp)                                    # Save return address on the stack
    # Initialize the result and the loop index.
    mv t0, zero                                     # t0 will hold the result (dot product)
    mv t1, zero                                     # t1 will be our loop index
    # Let's see first if SIZE < 1, and jump to dot_end if that's the case.
    slti t2, a3, 1                                  # t2 = (SIZE < 1)
    beq t2, zero, dot_loop                          # If SIZE >= 1, we can proceed to the loop
    li a0, 50                                       # Set a0 to 50 to indicate an error (invalid size)
    j dot_end                                       # If SIZE < 1, jump to dot_end
dot_loop:
    beq t1, a3, dot_end_loop                        # If t1 == SIZE, we are done
    lw t2, 0(a1)                                    # Load A[t1] into t2
    lw t3, 0(a2)                                    # Load B[t1] into t3
    mul t4, t2, t3                                  # t4 = A[t1] * B[t1]
    # Check if the multiplication of A[t1] and B[t1] overflows
    mulh t5, t2, t3                                 # t5 = high 32 bits of A[t1] * B[t1] (signed)
    srai t6, t4, 31                                 # t6 = sign extension of low 32 bits (0 or -1)
    bne t5, t6, overflow                            # Overflow if high bits != sign extension of low bits
    mv t6, t0                                       # Store the current result in t6 for overflow checking
    add t0, t0, t4                                  # t0 += A[t1] * B[t1]
    # Check if the previous addition caused an overflow
    # Careful: adding negative numbers will correctly result in a negative number, so we need to check for overflow in both directions.
    bgt t6, zero, check_positive_overflow           # If previous result was positive, check for positive overflow
    blt t6, zero, check_negative_overflow           # If previous result was negative, check for negative overflow
    j dot_continue_loop
check_positive_overflow:
    blt t4, zero, dot_continue_loop                 # If we added a negative number, we can't have a positive overflow
    blt t0, zero, overflow                          # If t0 < 0 after adding a positive number, we have an overflow
    j dot_continue_loop
check_negative_overflow:
    bgt t4, zero, dot_continue_loop                 # If we added a positive number, we can't have a negative overflow
    bgt t0, zero, overflow                          # If t0 > 0 after adding a negative number, we have an overflow
    j dot_continue_loop
dot_continue_loop:
    addi a1, a1, 4                                  # Move to the next element in A
    add a2, a2, a4                                 # Move to the next element in B
    addi t1, t1, 1                                  # t1++
    j dot_loop                                      # Repeat the loop
dot_end_loop:
    li a0, 0                                        # Set a0 to 0 to indicate success
    mv a1, t0                                       # Move the result into a1 for return
    j dot_end                                       # Jump to the end of the function
overflow:
    li a0, 200                                      # Set a0 to 200 to indicate an overflow error
    j dot_end                                       # Jump to the end of the function
dot_end:
    lw ra, 0(sp)                                    # Restore return address
    addi sp, sp, 4                                  # Deallocate stack space
    ret                                             # Return to the caller

# (in)  a1: pointer to int array
# (in)  a2: array length
# (out) a0: status code
# (out) a1: index of the largest element
argmax:
    # Get the index of the maximum value in A, which is of size SIZE.
    # The result will be stored in a0.
    # If here's a draw, return the smallest index among the maximum values.
    addi sp, sp, -4
    sw ra, 0(sp)                                    # Save return address on the stack
    # Initialize the max value and the index of the max value.
    lw t0, 0(a1)                                    # t0 will hold the max value
    mv t1, zero                                     # t1 will hold the index of the max value
    mv t2, zero                                     # t2 will be our loop index
    # Error checking first: if SIZE < 1, we should return 50 to indicate an error.
    slti t3, a2, 1                                  # t3 = (SIZE < 1)
    beq t3, zero, argmax_loop                       # if SIZE >= 1, we can proceed to the loop
    li a0, 50                                       # set a0 to 50 to indicate an error (invalid size)
    j argmax_end                                    # if SIZE < 1, jump to argmax_end
argmax_loop:
    # The actual loop logic.
    beq t2, a2, argmax_end_loop                     # if t2 == SIZE, we are done
    lw t3, 0(a1)                                    # load A[t2] into t3
    ble t3, t0, argmax_next                         # if A[t2] <= max_value, skip to next
    mv t0, t3                                       # max_value = A[t2]
    mv t1, t2                                       # index_of_max = t2
argmax_next:
    addi a1, a1, 4                                  # move to the next element in A
    addi t2, t2, 1                                  # t2++
    j argmax_loop                                   # repeat the loop
argmax_end_loop:
    mv a1, t1                                       # move the index of the max value into a1 for return
    li a0, 0                                        # set a0 to 0 to indicate success
argmax_end:
    lw ra, 0(sp)                                    # Restore return address
    addi sp, sp, 4                                  # Deallocate stack space
    ret                                             # return to the caller

exit_with_code:
    li a7, CONST_SYSCALL_EXIT2
    ecall

#############################################################################################################
# Helper functions for printing and debugging.
#############################################################################################################

.data
PRINT_HEADER_VOCABULARY:    .string "=== Vocabulary ==="
PRINT_HEADER_INPUT:         .string "=== Input ==="
PRINT_HEADER_INPUT_INDICES: .string "=== Input Indices ==="
PRINT_HEADER_MATRIX:        .string "=== Matrix ==="
PRINT_HEADER_SCORES:        .string "=== Scores ==="
PRINT_HEADER_NEXT_TOKEN:    .string "=== Decision ==="
PRINT_VECTOR_LB:            .string "[ "
PRINT_VECTOR_RB:            .string "]"

.text
# Prints a null-terminated string followed by a newline.
# (in) a0: buffer to print (char*)
println:
    li a7, CONST_SYSCALL_PRINT_STRING
    ecall
    li a0, CONST_CHAR_NEWLINE
    li a7, CONST_SYSCALL_PRINT_CHAR
    ecall
    ret

# Prints the vocabulary buffer.
# (in) a0: address of the vocabulary buffer (char*)
print_vocabulary:
    addi sp, sp, -8
    sw ra, 0(sp)
    sw s0, 4(sp)
    mv s0, a0
    la a0, PRINT_HEADER_VOCABULARY
    jal println
    mv a0, s0
    jal println
    lw ra, 0(sp)
    lw s0, 4(sp)
    addi sp, sp, 8
    ret

# Prints the input buffer as a string.
# (in) a0: address of the input buffer (char*)
print_input:
    addi sp, sp, -8
    sw ra, 0(sp)
    sw s0, 4(sp)
    mv s0, a0
    la a0, PRINT_HEADER_INPUT
    jal println
    mv a0, s0
    jal println
    lw ra, 0(sp)
    lw s0, 4(sp)
    addi sp, sp, 8
    ret

# Prints the input indices vector.
# (in) a0: address of the input indices vector (int*)
# (in) a1: size of the input indices vector (int)
print_indices:
    addi sp, sp, -12
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    mv s0, a0
    mv s1, a1
    la a0, PRINT_HEADER_INPUT_INDICES
    jal println
    mv a0, s0
    mv a1, s1
    jal print_vector
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    addi sp, sp, 12
    ret

print_scores:
    addi sp, sp, -4
    sw ra, 0(sp)
    la a0, PRINT_HEADER_SCORES
    jal println
    la a0, SCORES_VECTOR
    lw a1, INPUT_TOTAL_TOKENS
    jal print_vector
    lw ra, 0(sp)
    addi sp, sp, 4
    ret

# a0: address of matrix to print (int*)
# a1: number of rows
# a2: number of columns
print_matrix:
    addi sp, sp, -24
    sw ra, 0(sp)                                    # return address
    sw s0, 4(sp)                                    # matrix pointer
    sw s1, 8(sp)                                    # row index
    sw s2, 12(sp)                                   # col index
    sw s3, 16(sp)                                   # number of rows
    sw s4, 20(sp)                                   # number of columns
    mv s0, a0                                       # s0 = pointer to matrix
    mv s3, a1                                       # s3 = number of rows
    mv s4, a2                                       # s4 = number of columns
    li s1, 0                                        # s1 = current row index
    la a0, PRINT_HEADER_MATRIX
    jal println
print_matrix_row_loop:
    beq s1, s3, print_matrix_done
    li s2, 0
print_matrix_col_loop:
    beq s2, s4, print_matrix_next_row
    lw a0, 0(s0)
    li a7, CONST_SYSCALL_PRINT_INT
    ecall
    addi s0, s0, 4
    addi s2, s2, 1
    li a0, CONST_CHAR_SPACE
    li a7, CONST_SYSCALL_PRINT_CHAR
    ecall
    j print_matrix_col_loop
print_matrix_next_row:
    li a0, CONST_CHAR_NEWLINE
    li a7, CONST_SYSCALL_PRINT_CHAR
    ecall
    addi s1, s1, 1
    j print_matrix_row_loop
print_matrix_done:
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    lw s3, 16(sp)
    lw s4, 20(sp)
    addi sp, sp, 24
    ret

# a0: address of vector to print (int*)
# a1: number of elements (int)
print_vector:
    addi sp, sp, -8
    sw s0, 0(sp)
    sw s1, 4(sp)
    mv s0, a0                                       # s0 = pointer to vector
    mv s1, a1                                       # s1 = number of elements
    la a0, PRINT_VECTOR_LB                          # Print "[ "
    li a7, CONST_SYSCALL_PRINT_STRING
    ecall
print_vector_loop:
    beq s1, zero, print_vector_done
    lw a0, 0(s0)
    li a7, CONST_SYSCALL_PRINT_INT
    ecall
    li a0, CONST_CHAR_SPACE
    li a7, CONST_SYSCALL_PRINT_CHAR
    ecall
    addi s0, s0, 4
    addi s1, s1, -1
    j print_vector_loop
print_vector_done:
    la a0, PRINT_VECTOR_RB                          # Print "]"
    li a7, CONST_SYSCALL_PRINT_STRING
    ecall
    li a0, CONST_CHAR_NEWLINE
    li a7, CONST_SYSCALL_PRINT_CHAR
    ecall
    lw s0, 0(sp)
    lw s1, 4(sp)
    addi sp, sp, 8
    ret

# (in) a0: address of the predicted token (char*)
print_predicted_token:
    addi sp, sp, -8
    sw ra, 0(sp)
    sw s0, 4(sp)
    mv s0, a0
    la a0, PRINT_HEADER_NEXT_TOKEN
    jal println
    # s0 = start of target token, print it char by char until newline or null
print_predicted_token_char:
    lb t0, 0(s0)
    beq t0, zero, print_predicted_token_nl          # null terminator
    li t1, CONST_CHAR_NEWLINE
    beq t0, t1, print_predicted_token_nl            # newline terminator
    mv a0, t0
    li a7, CONST_SYSCALL_PRINT_CHAR
    ecall
    addi s0, s0, 1
    j print_predicted_token_char
print_predicted_token_nl:
    li a0, CONST_CHAR_NEWLINE
    li a7, CONST_SYSCALL_PRINT_CHAR
    ecall
    lw ra, 0(sp)
    lw s0, 4(sp)
    addi sp, sp, 8
    ret
