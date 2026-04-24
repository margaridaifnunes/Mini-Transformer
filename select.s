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
  bge a2, a1, code51  # if element index >= array length
  blt a2, zero, code51  # if element index < 0 
  
  slli t0, a2, 2    # multiplies by 2^2
  add t0, a0, t0    # adds offset to the first address (t0 <- a0 + t0)
  lw a0, 0(t0)    # writes in a0 the value in t0+0
  jr ra

# Exits the program with an error 
# Arguments: 
# a0 (int) is the error code 
# You need to load a0 the error to a0 before to jump here
exit_with_error:
  li a7, 93            # Exit system call
  ecall                # Terminate program

code51:
  li a0, 51
  j exit_with_error
