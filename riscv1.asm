.data
Brancas: 0, 2, 4, 6, 9, 11, 13, 15, 16, 18, 20, 22

Pretas: 57, 59, 61, 63, 48, 50, 52, 54, 41, 43, 45, 47

 .text
 # As brancas come�am jogando come�a jogando, digita-se a linha e a coluna da pe�a
 Jogada_Branca:
 #retorna e a0 o valor da pe�a
 jal Calcular_Posi��o

#verificar se � dama Branca, entrada a posi��o da pe�a
jal Dama_Branca

#Procurando a pe�a que deseja mover no vetor. Entra a posi��o a0 e retorna a posi��o a0 e o endere�o da pe�a na mem�ria a1
jal Achar_Branca

#Caso a pe�a exista ela v�m para c� onde a0 � a posi��o e a1 o local da mem�ria da pe�a
Mover_Pe�a:
#Posi��es posiveis de mover, retorna na pilha para onde � poss�vel se mover, havendo ou n�o pe�as l� e tem entrada a posi��o da pe�a
jal Possivel_Mover
#caso seja posivel comer uma pe�a preta ele vai para a fun��o comer caso n�o ele retorna
jal Verificar_Comer_Pretas
addi sp, sp -4
sw a0, 0(sp)
addi sp, sp -4
sw a1, 0(sp)
#Retorna em a0 o valor da posi��o
jal Calcular_Posi��o
add a2, a0, zero
sw a1, 0(sp)
addi sp, sp 4
sw a0, 0(sp)
addi sp, sp 4


#Primeiro Verificar a diagonal esquerda
li t1, 7

Calcular_Posi��o:
#Digitar posi��o ao qual deseja se mover
li a7, 5
 ecall
 li t1, 8
 #as Colunas v�o de 0 a 7
 bgeu a0,t1, Linha_Invalida 
add t0, a0, zero

#Calcula-se a posi��o usando a coluna
mul t0, t0, t1
#pega-se a linha
 li a7, 5
ecall
 #as Colunas v�o de 0 a 7
bgeu a0, t1,Coluna_invalida 
#acha-se a posi��o da pe�a
add a0, a0, t0
#retorna
jr ra

Possivel_Mover:
#vai retornar a coluna que a pe�a esta
li t1, 8
rem t0, a0, t1
li t1,0
beq t0, t1, Ponta_Esquerda
li t1,7
beq t0, t1, Ponta_Direita
addi sp, sp, -16
addi t0, a0, 7
sw t0, 0(sp)
addi t0, a0, 9
sw t0, 4(sp)
addi t0, a0, -7
sw t0, 8(sp)
addi t0, a0, -9
sw t0, 12(sp)


Dama_Branca:
add t0, a0, zero
la t2, Brancas
lw t1, 0(t2)
addi t1, t1, 100
beq t0, t1, Mover_Dama
addi t2,t2, 4
lw t1, 0(t2)
addi t1, t1, 100
beq t0, t1, Mover_Dama
addi t2,t2, 4
lw t1, 0(t2)
addi t1, t1, 100
beq t0, t1, Mover_Dama
addi t2,t2, 4
lw t1, 0(t2)
addi t1, t1, 100
beq t0, t1, Mover_Dama
addi t2,t2, 4
lw t1, 0(t2)
addi t1, t1, 100
beq t0, t1, Mover_Dama
addi t2,t2, 4
lw t1, 0(t2)
addi t1, t1, 100
beq t0, t1, Mover_Dama
addi t2,t2, 4
lw t1, 0(t2)
addi t1, t1, 100
beq t0, t1, Mover_Dama
addi t2,t2, 4
lw t1, 0(t2)
addi t1, t1, 100
beq t0, t1, Mover_Dama
addi t2,t2, 4
lw t1, 0(t2)
addi t1, t1, 100
beq t0, t1, Mover_Dama
addi t2,t2, 4
lw t1, 0(t2)
addi t1, t1, 100
beq t0, t1, Mover_Dama
addi t2,t2, 4
lw t1, 0(t2)
addi t1, t1, 100
beq t0, t1, Mover_Dama
addi t2,t2, 4
lw t1, 0(t2)
addi t1, t1, 100
beq t0, t1, Mover_Dama
jr ra

Achar_Branca:
add t0, a0, zero
la t2, Brancas
lw a1, 0(t2)
beq t0, a1, Mover_Pe�a
addi t2,t2, 4
lw a1, 0(t2)
beq t0, a1, Mover_Pe�a
addi t2,t2, 4
lw a1, 0(t2)
beq t0, a1, Mover_Pe�a
addi t2,t2, 4
lw a1, 0(t2)
beq t0, a1, Mover_Pe�a
addi t2,t2, 4
lw a1, 0(t2)
beq t0, a1, Mover_Pe�a
addi t2,t2, 4
lw a1, 0(t2)
beq t0, a1, Mover_Pe�a
addi t2,t2, 4
lw a1, 0(t2)
beq t0, a1, Mover_Pe�a
addi t2,t2, 4
lw a1, 0(t2)
beq t0, a1, Mover_Pe�a
addi t2,t2, 4
lw a1, 0(t2)
beq t0, a1, Mover_Pe�a
addi t2,t2, 4
lw a1, 0(t2)
beq t0, a1, Mover_Pe�a
addi t2,t2, 4
lw a1, 0(t2)
beq t0, a1, Mover_Pe�a
addi t2,t2, 4
lw a1, 0(t2)
beq t0, a1, Mover_Pe�a
jal ra, N�o_Ha_Pe�a_Branca


Verificar_Comer_Pretas:

Ponta_Esquerda:

Ponta_Direita:

Linha_Invalida:

Coluna_invalida:

Mover_Dama:

N�o_Ha_Pe�a_Branca:
#Falar que n�o h� pe�a nesta posi��o
j Jogada_Branca