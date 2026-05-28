# ===========================================================================
# PROJETO_3 IAC
# Grupo: Número 18
# Grupo constituído por:
#    - Henrique Ascenção Lopes da Silva Gonçalves      ISTID: ist1118062
#    - Margarida Isabel Farinha Nunes                  ISTID: ist1117809
#    - Victória Bernaz                                 ISTID: ist1117771
# ===========================================================================

# Implementação da ISA:
  
  -> Instruções:
  li:                      immed[15:5]; rd[4:2]; opcode[1:0]
  add:             rb[9:7]; func2[6:5]; rd[4:2]; opcode[1:0]
  dot              rb[9:7]; func2[6:5]; rd[4:2]; opcode[1:0]
  dota: ra[12:10]; rb[9:7]; func2[6:5]; rd[4:2]; opcode[1:0]
  
  -> Opcodes associados às instruções:
  li: 0
  add, dot e dota: 1
  
  -> func2 associados às instruções:
  add:  00
  dot:  10
  dota: 11

# Justificação das Principais decisões tomadas:



# COMMENTS(A APAGAR NO FIM):
DOT:
  RD: rd
  A: rs
  B: rd + 1
  D: rs + 1

rd = (RD * A) + (B * D)

DOTA:
  SELA: rs1
  SELB: rs1 + 1
  SELC: rs2
  SELD: rs2 + 1
  SELR: rd

rd = rd + (A*C) + (B*D)


# sugestão: no li usar sign extension: senão como ponho -1??  Justificar isto no read.me
# sinais de controlo: ALU, sel...

