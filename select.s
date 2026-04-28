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
INDEX: .word 2

.text
main:
  la a1, ARRAY      # a1 = pointer to array
  lw a2, SIZE       # a2 = array length
  lw a3, INDEX      # a3 = element index
  jal ra, select    # call select function
exit:
  li a7, 10         # exit syscall code
  ecall             # terminate the program

# ==========================================================================
# FUNCTION: select
#   This function selects an element from an integer array.
# Arguments:
#   a1 = pointer to int array
#   a2 = array length
#   a3 = element index
# Returns:
#   a0 = status code
#   a1 = value of the selected element
# ===========================================================================
select:
  li t1, 1                  # t1 = 1
  blt a2, t1, code50        # if array length < 1 
  bge a3, a2, code100       # if element index >= array length
  blt a3, zero, code100     # if element index < 0

  slli t0, a3, 2            # t0 = a2 * 2ˆ2
  add t0, a1, t0            # adds offset to the base address (t0 <- a1 + t0)
  lw a1, 0(t0)              # loads in a1 the word in the adress t0+0
  
  li a0, 0                  # success 
  j select_end              # jump to select_end function

select_end:
  jr ra                     # return to the caller

code100:                    # index out of range
  li a0, 100                # a0 = 100 (error code)
  j select_end              # jump to select_end function

code50:                     # argument < 1
  li a0, 50                 # a0 = 50 (error code)
  j select_end              # jump to select_end function
