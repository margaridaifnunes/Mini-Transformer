.data
# You can change these arrays to test other values
A: .word -3, 2, -1, 7, -2   # Initial array A values				 
B: .word 6, 1, -1, 3, 2   # Initial array B values

.text

# **********************************************************************
# * Constantes
# **********************************************************************

# Constantes numericas:
.equ CINQUENTA, 50

main:
  la a0, A          # a0 = pointer to array A
  la a1, B          # a1 = pointer to array B
  li a2, 5          # a2 = number of elements in each array

  ble a2, zero, code50    # a2 <= 0; tem tamanho invalido: Call code50 function

  jal ra, dot      # Call dot function

  # Result: a0 contains the dot product of the two integer arrays

exit:
  li a7, 10              # Exit syscall code
  ecall                  # Terminate the program


# ==========================================================================
# FUNCTION: dot
#   This function computes the dot product of two integer arrays.
# Arguments:
#   a0 = pointer to first array
#   a1 = pointer to second array
#   a2 = array length
# Returns:
#   a0 = dot product result
# Exceptions:
#   - If the length of the array is less than 1,
#     this function terminates the program with error code 50
# ===========================================================================

dot:
  li t0,0                     # initializing t0 (index dos arrays) to 0
  li t1,0                     # initializing t1 (final_result) to 0
  li t4,0                     # initializing t4 (term result) to 0


dot_loop:
  bge t0, a2, loop_end    # t0 >= a2 exit

  lw t2,0(a0)                 # t2 = current index value
  lw t3,0(a1)                 # t3 = current index value

  mul t4, t2, t3    # t4 = t2 * t3 (term)
  add t1, t1, t4    # current result

  addi a0,a0,4                  # next value
  addi a1,a1,4                  # next value

  addi t0, t0, 1    # incrementar o indice do array
  j dot_loop


loop_end:
  add a0,t1,zero
  jr ra                  # normal return


# Exits the program with an error 
# Arguments: 
# a0 (int) is the error code 
# You need to load a0 the error to a0 before to jump here
exit_with_error:
  li a7, 93            # Exit system call
  ecall                # Terminate program

code50:
  li a0,CINQUENTA                     # a0 = 50 (error code)
  j exit_with_error            # call exit_with_error function
