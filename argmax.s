.data
# You can change this array to test other values
array: .word -3, 2, -1, 7, -2   # Initial array values				 

.text
.equ CINQUENTA, 50

main:
  la a0, array      # a0 = pointer to array
  li a1, 5          # a1 = number of elements in the array

  
  ble a1, zero, code50
  jal ra, argmax      # Call argmax function

  # Result: a0 contains the index of the largest element

exit:
  li a7, 10              # Exit syscall code
  ecall                  # Terminate the program


# ==========================================================================
# FUNCTION: argmax
#   Takes an array of integers and returns the index of the largest element.
#   If there are multiple elements with the same maximum value, 
#   it should return the smallest index among them.
# Arguments:
#   a0 = pointer to int array
#   a1 = array length
# Returns:
#   a0 = index of the largest element
# Exceptions:
#   - If the length of the array is less than 1,
#     this function terminates the program with error code 50
# ===========================================================================
argmax:
    li  t0,0                # inicialize the value at 0
      # Checks if it has 0 elements

main_argMax:
  bge t0, a1, No_items  
  lw t1, 0(a0)              
  addi a0,a0,4                  # goes to the next value
  beq zero,t0,first_case        # checks if the index is equal to 0 if true calls function: first_case
  addi t0, t0,1                 # increments 1 to the index
  ble t1,a2, main_argMax        # checks if the last value is less than the bigest value continues searching
  addi a3,t0,-1                 # decrements the index of the biggest value index
  add a2,t1,zero                # sets the bigest value to the last value
  j main_argMax                 # continues searching
         

first_case:
  add a3,zero,zero              # sets a3 = 0
  add a2,t1,zero                # sets a2 to the value of the first element (t1)
  addi t0,t0,1                  # increments 1 to the searching index 
  j main_argMax                 # calls the function: main_arMax

No_items:
  add a0, a3, zero      # set a3 to the biggest value (a2)
  j exit                # exits the function

loop_end:
  jr ra                  # normal return


# Exits the program with an error 
# Arguments: 
# a0 (int) is the error code 
# You need to load a0 the error to a0 before to jump here
exit_with_error:
  li a7, 93            # Exit system call
  ecall                # Terminate program

code50:
  li a0, CINQUENTA            # set the error code
  j exit_with_error    # call the error fucntion
