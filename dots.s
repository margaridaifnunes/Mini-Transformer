# *********************************************************************
# * PROJETO_1 IAC
# * Grupo: Número 18
# * Grupo constituído por:
# *    - Henrique Ascenção Lopes da Silva Gonçalves      ISTID: ist1109966
# *    - Margarida Isabel Farinha Nunes                  ISTID: ist1117809
# *    - Victória Bernaz                                 ISTID: ist1117771
# *
# *********************************************************************
# You can change these values to test your solution.
.data
A:    .word 6, 1, 3, 9, 12, 4, 13, 153
B:    .word 6, 1, 3, 9, 12, 4, 13, 153
SIZE: .word 8

.text

# ************************
# * Constantes
# ************************

# Constantes numericas:
.equ CINQUENTA, 50
.equ ZERO, 0
.equ DUZENTOS, 200

main:
  la a1, A          # a1 = pointer to array A
  la a2, B          # a2 = pointer to array B
  lw a3, SIZE       # a3 = number of elements in each array

  jal ra, dot                  # call dot function

exit:
  li a7, 10         # exit syscall code
  ecall             # terminate the program


# ==========================================================================
# FUNCTION: dot
#   This function computes the dot product of two integer arrays.
# Arguments:
#   a1 = pointer to first array
#   a2 = pointer to second array
#   a3 = array length
# Returns:
#   a0 = status code
#   a1 = dot product result
# ===========================================================================
dot:
  # TODO: Implement the dot product function here
  li t0,0                     # initializing t0 (index dos arrays) to 0
  li t1,0                     # initializing t1 (final_result) to 0
  li t4,0                     # initializing t4 (term result) to 0

  ble a3, zero, code50

dot_loop:

  bge t0, a3, loop_end    # t0 >= a2 exit

  lw t2,0(a1)                 # t2 = current index value
  lw t3,0(a2)                 # t3 = current index value

  mul t4, t2, t3    # t4 = t2 * t3 (term)
  add t1, t1, t4    # current result

  addi a1,a1,4                  # next value
  addi a2,a2,4                  # next value

  addi t0, t0, 1    # incrementar o indice do array
  j dot_loop

loop_end:
  add a1,t1,zero
  j code0

dot_end:
  jr ra               # return to the caller



code0:  # sucess
  li a0, ZERO # a0 = 0
  j dot_end

code50: # invalid argument
  li a0,CINQUENTA   # a0 = 50
  j dot_end

code200:  # detected overflow
  li a0, DUZENTOS  # a0 = 200
  j dot_endth_error function
