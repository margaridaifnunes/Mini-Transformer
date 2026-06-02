===========================================================================
PROJETO_3 IAC
Grupo: Número 18
Grupo constituído por:
   - Henrique Ascenção Lopes da Silva Gonçalves      ISTID: ist1118062
   - Margarida Isabel Farinha Nunes                  ISTID: ist1117809
   - Victória Bernaz                                 ISTID: ist1117771
===========================================================================

# Implementação da ISA:
  
  -> Formato das instruções:
  li:                        immed[15:4]; rd[3:1]; opcode[0]
  add:   rd[12:10]; rb[9:7]; funct3[6:4]; rd[3:1]; opcode[0] 
  dot:   rd[12:10]; rb[9:7]; funct3[6:4]; rd[3:1]; opcode[0]
  dota:  ra[12:10]; rb[9:7]; funct3[6:4]; rd[3:1]; opcode[0]

-> Opcodes associados às instruções:
  li: 0
  add, dot e dota: 1
  
-> funct3 associados às instruções:
  add:  001
  dot:  010
  dota: 100

===========================================================================
# Sinais de controlo: (MUDAR OS NOMES NO PROJ)

A: RS1
B: RS1 +1 
C:
D
SELA
SELB
SELC
SELD
AUR
LIR


===========================================================================

# Justificação das Principais decisões tomadas:

-> Simplicidade do circuito e clareza do desenho:

   Na implementação do circuito optamos por unificar as operações dot e dota de modo a
   reduzir o número de portas lógicas e componentes dispendiosos, nomeadamente MUX's
   desnecessários, que consequentemente simplifica globalmente o circuto,
   sem introduzir ambiguidades.

   Ao nível da clareza do desenho, separamos o projeto em quatro áreas distintas: o banco
   de registos, a área das decisões (associada à ALU para distinguir
   (li ou add/dot/dota)), a área da memória e a zona das operações. 
   Para tornar o desenho mais legível utilizamos túneis, o que facilita a separação das 
   áreas e a interpretação do circuito.

-> Número de componentes:
   Para minimizar o custo, utilizámos 2 portas AND, 1 XOR e bit extenders na seleção do
   registo de destino (distinção entre dot e dota), evitando um MUX mais dispendioso. AND e
   XOR são operações básicas, e o bit extender  não usa nenhum transistor, resultando num 
   custo significativamente inferior ao de um MUX.
  
   Na implementação do li, optamos por incluir um bit extender de modo a suportar valores negativos.

-> Expressividade da ISA:

   A ISA foi pensada para ser simples e regular de modo a simplificar o hardware ao máximo, no
   entanto, por vezes, pequenos ajustes na complexidade da ISA, permitem reduzir a lógica do circuito.
   Como por exemplo:
     - Opcode com 1 bit, permite-nos aumentar o valor do imediato no li;
     - Todas as operações tem o rd nos mesmos bits [3:1];
     - O funct3 ocupa 3 bits e distingue diretamente o add, dot e dota;
     - Inclusão do rd[12:10] no dot para aproximar o comportamento de dot e dota apesar da
      instrução dot assumir o registo de destino por defeito;

-> Extensibilidade da arquitetura:
   
   A simplicidade da ISA e os bits livres permitem adicionar novas instruções. A escolha de
   funct3 com 3 bits evita o uso de MUX, aproveitando diretamente os sinais para operações lógicas
   básicas, que são mais eficientes e menos dispendiosas por natureza.

===========================================================================

# Exemplos de codificação das diversas instruções em linguagem máquina:

-> li: li R2,5 (immed = 000000000101, rd = 010, opcode = 0)
   0000 0000 0101 0100
-> add: add R0,R3 (rd = 000, rs = 011, funct3 = 001, rd = 000, opcode = 1)
   0000 0001 1001 0001
-> dot: dot R0,R2 (rd = 000, rs = 010, funct3 = 010, rd = 000, opcode = 1)
   0000 0001 0010 0001
-> dota: dota R0, R1, R3 (ra = 001, rb = 011, funct3= 100, rd = 000, opcode = 1)
   0000 0101 1100 0001
