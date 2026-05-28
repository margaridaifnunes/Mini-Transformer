# ===========================================================================
# PROJETO_2 IAC
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
  
  -> Opcodes associados às isntruções:
  li: 0
  add, dot e dota: 1
  
  -> func2 associados às instruções:
  add:  00
  dot:  01
  dota: 10

# Justificação das Principais decisões tomadas:
