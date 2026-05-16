parse_matrix_buffer:
    addi sp ,sp -12              # reserva 12 bytes para a stack
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    mv s0, a0
    li t2, 0
    li t3 ,1
    li t5, 10
    li s1, 0

    loop_byte:
        lb t1, 0(a1)                # t1 = byte a anilzar 
        li t0,CONST_CHAR_SPACE      # codigo do space
            beq t1, t0, space       # se t1 é ' '

        li t0, CONST_CHAR_NEWLINE   # codigo do Newline
            beq t1, t0,new_row      # se t1 é '\n'

        li t0, CONST_CHAR_EOF       # codigo do EOF
            beq t1, t0, loop_end    # se t1 é EOF
            
        li t0, CONST_CHAR_HYPHEN    # codigo do '-'
            beq t1, t0, negative    # se t1 e '-'
        
        # conversão:
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
        mul s1, s1, t3
        sw s1, 0(a0)
        addi a0, a0, 4
        mv a1 ,t2
        mv a0, s0
        lw ra, 0(sp)
        lw s0, 4(sp)            # restaurar o ra
        lw s1, 8(sp)
        addi sp, sp ,12         # desalocar o stack
        jr ra                   # voltar para a chamada
