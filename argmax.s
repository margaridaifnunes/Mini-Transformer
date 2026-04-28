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
ARRAY: .word -6 -1 6 1
SIZE:  .word 4


.text
# ************************
# * Constantes
# ************************

# Constantes numericas:
.equ CINQUENTA, 50

main:
  la a1, ARRAY        # a1 = pointer to array
  lw a2, SIZE         # a2 = number of elements in the array
  jal ra, argmax      # call argmax function
exit:
  li a7, 10           # exit syscall code 
  ecall               # terminate the program

# ==========================================================================
# FUNCTION: argmax
#   Takes an array of integers and returns the index of the largest element.
#   If there are multiple elements with the same maximum value, 
#   it should return the smallest index among them.
# Arguments:
#   a1 = pointer to int array
#   a2 = array length
# Returns:
#   a0 = status code
#   a1 = index of the largest element
# ===========================================================================


argmax:
  ble a2, zero, code50      # Checks if the array length is 0
  li t0, 0                  # inicializes the counter
  li s1,1                   # Initializes teh axiliary for the indexes
  li s2,0                   # Initializes the auxiliary that stores the largest
  add t0, a1, zero          # Sets the pointes (t0) to the pointer to the array
  lw t3, 0(a1)              # Loads the first word (int in this case)


main_argMax: 
  ble a2, zero, done        # checks if the list ended if true goes to label "done"
  addi t0, t0, 4            # increments to the next word (int in this case)
  addi a2, a2, -1           # decrementes the size of the arry
  addi s1,s1,1              # adds one the the auxiliary index tracker
  lw t4, 0(t0)              # loads the word that t0 (pointer) is pointing to
  bgt t4, t3, MaxFound      # checks if the current word bigger than the the one saved 
                            # if true goes to "MaxFound"

  j main_argMax             # goes to "main_argMax"


MaxFound:
  mv a1,t0                  # sets the pointer of a1 to the same as t0
  addi t3,t4,0              # changes the previus biggest value to the current one
  addi s2,s1,0              # changes the auxiliary index to the corresponding one
  j main_argMax             # jumps again the the "main_argMax"

done:
  add a1,s2,zero            # Sets a1 to the auxiliary Index
  j exit                    # jumps tho the "exit"

code50:
  li a0, CINQUENTA          # set the error code
  ecall                     # jumps to the error label

argmax_end:
  jr ra               # return to the caller
