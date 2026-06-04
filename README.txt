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
  li: 1
  add, dot e dota: 0
  
-> funct3 associados às instruções:
  add:  001
  dot:  010
  dota: 100

===========================================================================
# Sinais de controlo:

SELA: bit de seleção do registo A; (A: RS1)
SELB: bit de seleção do registo B; (B: RS1 + 1)
SELC: bit de seleção do registo C; (C: RS2)
SELD: bit de seleção do registo D; (D: RS2 + 1)
SELR: seleciona o registo de escrita; (RD: RD)
SELRD: bit de seleção do registo RD;
ADD_INST: bit de seleção que determina, consoante o output do 1º bit (na ALU), se é um add;
DOT_INST: bit de seleção que determina, consoante o output do 2º bit (na ALU), se é um dot;
DOTA_INST: bit de seleção que determina, consoante o output do 3º bit (na ALU), se é um dot;
LI_INST: distinguido pelo bit do opcode, determina se executa li;

===========================================================================

# Justificação das Principais decisões tomadas:

-> Simplicidade do circuito e clareza do desenho:

   Na implementação do circuito optamos por unificar as operações dot e dota de modo a
   reduzir o número de portas lógicas e componentes dispendiosos, nomeadamente MUX's com
   elevado número de portas, que consequentemente simplifica globalmente o circuto,
   sem introduzir ambiguidades.

   Ao nível da clareza do desenho, separamos o projeto em quatro áreas distintas: 
   - Área dos registos (banco de registos);
   - Área de descodificação (distinguir li ou add/dot/dota);
   - Área da memório (leitura das intruções);
   - Área das operações;
   Para tornar o desenho mais legível utilizamos túneis, o que facilita a separação das 
   áreas e a interpretação do circuito.

-> Número de componentes:

   Para minimizar o custo, utilizamos 2 MUX's pois é mais barato usar 2 MUX's de 2 entradas
   e 1 bit de seleção do que 1 MUX de 4 entradas e 2 bits de seleção, já que equivale a 3 MUX 
   de 2 entradas e 1 bit de seleção.

   Evitamos usar dois somadores ao ligar diretamente por cabos cabos entre o MUX referente a A/B
   e C/D. Ligamos portanto a entrada n de B às entradas n+1 de A, à exceção da última entrada de B
   que está ligada à entrada 0 de A; a mesma lógica aplica-se a C/D.

   Na implementação do li, optamos por incluir um bit extender pois é um componente que não usa nenhum
  transistor e nos dos possibilita armazenar valores negativos.

   Visando apresentar uma resolução mais completa, introduzimos um reset para acaltelar extensões do
   computador tendo a capacidade de fazer reset geral do CPU, algo que pode ser útil em caso de ocorrência
   de anomalias durante um processo de testagem de um chip.

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

   No que toca ao tamanho da ROM, escolhemos receber até 256 instruções, o que no âmbito académico já
   é um número considerável. Isto permite-nos efetuar multiplicação de matrizes 2*2  e 4*4. Além disso,
   quanto mais instruções recebermos, mais espaço (área) ocupa a memória dentro do CPU, aumentando o seu
   valor de mercado. A nível de jumps, também nos permite saltar um número razoável de instruções. Associado
   à ROM, temos um contador de 8 bits, pois dada a restrição imposta à memória (2^8 = 256) é o nº máximo de
   bits que este comporta, assim permite-nos aceder a qualquer endereço da ROM diretamente.

===========================================================================

# Exemplos de codificação das diversas instruções em linguagem máquina:

-> li: li R2,5 (immed = 000000000101, rd = 010, opcode = 1)
   0000 0000 0101 0101
-> add: add R0,R3 (rd = 000, rs = 011, funct3 = 001, rd = 000, opcode = 0)
   0000 0001 1001 0000
-> dot: dot R0,R2 (rd = 000, rs = 010, funct3 = 010, rd = 000, opcode = 0)
   0000 0001 0010 0000
-> dota: dota R0, R1, R3 (ra = 001, rb = 011, funct3= 100, rd = 000, opcode = 0)
   0000 0101 1100 0000
