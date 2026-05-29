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
  li:                       immed[15:4]; rd[3:1]; opcode[0]
  add:   rd[12:10]; rb[9:7]; func2[6:4]; rd[3:1]; opcode[0]  (- circuitos no proj e evito um MUX  para trocar o Rd de sítio)
  dot:   rd[12:10]; rb[9:7]; func2[6:4]; rd[3:1]; opcode[0]  ( aumento a ISA; - MUX e complexidade do circuito)
  dota:  ra[12:10]; rb[9:7]; func2[6:4]; rd[3:1]; opcode[0]

### ( + código pouco impacto; + lógica -> impacto grande no espaço pequeno e na eficiência do processador;
      complexidade de portas; e financeiro)
trade off entre - lógica  e + complexidade da ISA

  -> Opcodes associados às instruções:
  li: 0
  add, dot e dota: 1
  
  -> func2 associados às instruções:
  add:  000
  dot:  100
  dota: 010

## dot é semelhante ao dota com a diferença do registo de destino

### modificar o dota !!!
### fazer o func3 com 3 bits???

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

li x2, 4
