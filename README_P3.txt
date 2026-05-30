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
  add:   rd[12:10]; rb[9:7]; func3[6:4]; rd[3:1]; opcode[0] 
  dot:   rd[12:10]; rb[9:7]; func3[6:4]; rd[3:1]; opcode[0]
  dota:  ra[12:10]; rb[9:7]; func3[6:4]; rd[3:1]; opcode[0]

-> Opcodes associados às instruções:
  li: 0
  add, dot e dota: 1
  
-> func3 associados às instruções:
  add:  001
  dot:  010
  dota: 100

Justificação das Principais decisões tomadas:

-> Simplicidade do circuito e clareza do desenho:
Na implementação do circuito optamos por unificar as operações dot e dota de modo a diminuir o número de portas lógicas e componentes dispendiosos, nomeadamente MUX's desnecessários, que consequentemente simplifica globalmente o circuto.

Ao nível da clareza do desenho, separamos o projeto em quatro áreas distintas: o banco dos registos, a área das decisões (onde associado à ALU decide o tipo operação a executar (li ou add/dot/dota)), a área da memória e a zona das operações.

-> Número de componentes:

Visam o objetivo de minimizar o custo das operações, isto é, o nº de componentes envolvidos para uma tarefa, escolhemos usar 2 portas AND, 1 porta XOR e bit extenders para decidir o registo de destino ( o que diferencia ambas as operações) do dot e dota, deste modo evitamos adicionar um MUX que teria um impacto muito mais visivel face à escolha efetuada. AND e XOR são operações básicas e o bit extender usa somente 2 transistors; isto é que usam significativamente menos transistors que um MUX.

Na implementação do li, optamos por incluir um bit extender de modo a suportar valores negativos.

-> Expressividade da ISA:
A ISA foi pensada para ser simples e regular de modo a simplificar o hardware ao máximo, no entanto, por vezes, pequenos ajustes na complexidade da ISA, permitem reduzir a lógica do circuito.
Como tal:
  - o opcode ocupa apenas 1 bit, o que nos permite aumentar o valor do         imediato no li;
  - todas as operações tem o rd nos mesmos bits [3:1];
  - o func3 ocupa 3 bits e distingue diretamente o add, dot e dota;
  - acrescentamos rd[12:10] no dot, pois apesar da instrução assumir o         registo de destino por defeito, este detalhe permite-nos aproximar o       dot e dota;

-> Extensibilidade da arquitetura:
Ao nível da extensibilidade da arquitetura a simplicidade da ISA  conferida pelos bit livres permitem que o circuito receba mais instruções.
Outra decisão relevante, é a opção de implementar o func3 com 3 bits para em vez de usar um multiplexer aproveitarmos o sinal destes 3 bits para estender o sinal, sinal esse a utilizar em operações lógicas básicas (mais baratas) que, são mais eficientes por natureza.




( aumento a ISA; - MUX e complexidade do circuito)
### ( + código pouco impacto; + lógica -> impacto grande no espaço pequeno e na eficiência do processador;
      complexidade de portas; e financeiro)
trade off entre - lógica  e + complexidade da ISA

# sugestão: no li usar sign extension: senão como ponho -1??  Justificar isto no read.me

# sinais de controlo: ALU, sel...
