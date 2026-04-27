# *********************************************************************
# * PROJETO_1 IAC
# * Grupo: Número 18
# * Grupo constituído por:
# *    - Henrique Ascenção Lopes da Silva Gonçalves      ISTID: ist1109966
# *    - Margarida Isabel Farinha Nunes                  ISTID: ist1117809
# *    - Victória Bernaz                                 ISTID: ist1117771
# *
# *********************************************************************

.data
# You can change this array to test other values
array: .word -3, 2, -1, 7, -2   # Initial array values				 

.text

main:
  la a0, array      # a0 = pointer to array
  li a1, 5          # a1 = array length
  li a2, 3          # a2 = element index

  jal ra, select      # Call select function

  # Result: a0 contains the value of the selected element

exit:
  li a7, 10              # Exit syscall code
  ecall                  # Terminate the program


# ==========================================================================
# FUNCTION: select
#   This function selects an element from an integer array.
# Arguments:
#   a0 = pointer to int array
#   a1 = array length
#   a2 = element index
# Returns:
#   a0 = value of the selected element
# Exceptions:
#   - If invalid access (index out of bounds),
#     this function terminates the program with error code 51
# ===========================================================================
select:
  bge a2, a1, code100    # if element index >= array length
  blt a2, zero, code100  # if element index < 0 

  # falta a parte do indíce do maior elemento em a1
  slli t0, a2, 2    # t0 = a2 * 2ˆ2
  add t0, a0, t0    # adds offset to the base address (t0 <- a0 + t0)
  lw a0, 0(t0)      # loads in a0 the word in the adress t0+0
  jr ra

# Exits the program with an error 
# Arguments: 
# a0 (int) is the error code 
# You need to load a0 the error to a0 before to jump here
exit_with_error:
  li a7, 93            # Exit system call
  ecall                # Terminate program

code100:
  li a0, 100           # a0 = 100 (error code)
  j exit_with_error    # call exit_with_error function

code51:
  li a0, 51            # a0 = 51 (error code)
  j exit_with_error    # call exit_with_error function
