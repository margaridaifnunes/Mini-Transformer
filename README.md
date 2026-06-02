# Mini-Transformer
Project for Introduction to Computer Architecture

_________________________________________________________________________________________

Questões para a aula prática:
   
  ->  devo por e explicar cada sinal de controlo usado no projeto? (ALU, SELD, D,...) sim!

  -> que tipo de questões podemos esperar no teste prático? 3 PERGUNTAS DE ASSEMBLY E 1 DE LOGISIM

  -> COLOCAR A IMPLEMENTAÇÃO DE RESET: CUSTA EM TEMPO E ÁREA; Justificar

  -> justificar quantyas instruções suporta o nosso processador consoante as difinições da ROM; +ROM -> + TAMANHO DE PC; + RAM -> + tamanho do chip ( + preço); porque o tamanho de rom? e cosnequentemente pk o tamanho do contador?  extensibilidade: se fosso adicionar um jump o que teriamos de alterar?? (dar um exemplo) jump fica limitado pelo contador; e se fosse um jal? mais que 16 é mau para fazer jumps; menos que 256 é poucas isntruções...; se quisesse somar 4 registos, como conseguia somar os 4 em single-cicle??(extensibilidade) e como configurava? 8extensão é colocar mais uma instrução

  com 256 na rom consigo fazer multiplicação de matrizes 2*2 e de 4*4 (ver o limite que conseguimos fazer e expor na extensibilidade) ver nº de dots envolvidos e de add's
  Impacto da ROM: 
  














Falta:

  -> testar edge cases (de todas as instruções) DOT E DOTA ENCADEADOS NEGATIVOS;
  -> rever seções do circuito no readme;
  -> rever justificações AND e MUX tem ambos 6 transitors... um mux de 4 entradas é pior que 2 mux's de 2 entradas pois o de 4 equivale a 3 mux's de 2 entradas
_________________________________________________________________________________________

1st Project -> inclui os ficheiros: argmax.s, dot.s and select.s;

2nd Project -> p2.s

3rd Project -> p3.cir e README.txt
