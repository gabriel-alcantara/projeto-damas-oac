.data
Brancas: 0, 2, 4, 6, 9, 11, 13, 15, 16, 18, 20, 22

Pretas: 57, 59, 61, 63, 48, 50, 52, 54, 41, 43, 45, 47

 .text
 # As brancas come�am jogando come�a jogando, digita-se a linha e a coluna da pe�a
 Jogada_Branca:
 #retorna e a0 o valor da pe�a
 jal Calcula_Posi��o

#Procurando a pe�a que deseja mover no vetor
add t0, a0, zero
la t2, Brancas
lw t1, 0(t2)
beq t0, t1, Mover_Pe�a
addi t2,t2, 4
beq t0, t1, Mover_Pe�a
addi t2,t2, 4
beq t0, t1, Mover_Pe�a
addi t2,t2, 4
beq t0, t1, Mover_Pe�a
addi t2,t2, 4
beq t0, t1, Mover_Pe�a
addi t2,t2, 4
beq t0, t1, Mover_Pe�a
addi t2,t2, 4
beq t0, t1, Mover_Pe�a
addi t2,t2, 4
beq t0, t1, Mover_Pe�a
addi t2,t2, 4
beq t0, t1, Mover_Pe�a
addi t2,t2, 4
beq t0, t1, Mover_Pe�a
addi t2,t2, 4
beq t0, t1, Mover_Pe�a
addi t2,t2, 4
beq t0, t1, Mover_Pe�a
jal ra, N�o_Ha_Pe�a

Mover_Pe�a:
addi sp, sp 4
sw t0, -4(sp)
addi sp, sp 4
sw t2, -4(sp)
jal Calcula_Posi��o
addi sp, sp -4
sw t0, 0(sp)
addi sp, sp -4
sw t2, 0(sp)

#Primeiro Verificar a diagonal esquerda
li a0, 7
#posi��o para ir
add a0, t0, t1
#posi��o
add a1, t0, zero

addi sp, sp 4
sw t0, -4(sp)
addi sp, sp 4
sw t2, -4(sp)
#Verifica se h� um alidado, caso n�o haja ele volta para ca
jal Verificar_Brancas
#Verifica se h� um inimigo, caso n�o haja ele volta para ca, caso haja ele verifica se � poss�vel comer
jal Verificar_Pretas
addi sp, sp -4
sw t0, 0(sp)
addi sp, sp -4
sw t2, 0(sp)

#Verificars se h� Pe�a amiga

#Retorna a posi��o da pe�a em a0
Calcula_Posi��o:
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

jr ra

#entrada a0, posi��o a qual se deseja mover
Verificar_Brancas:
la t2, Brancas
lw t1, 0(t2)
beq a0, t1, Pe�a_Aliada
addi t2,t2, 4
beq a0, t1, Pe�a_Aliada
addi t2,t2, 4
beq a0, t1, Pe�a_Aliada
addi t2,t2, 4
beq a0, t1, Pe�a_Aliada
addi t2,t2, 4
beq a0, t1, Pe�a_Aliada
addi t2,t2, 4
beq a0, t1, Pe�a_Aliada
addi t2,t2, 4
beq a0, t1, Pe�a_Aliada
addi t2,t2, 4
beq a0, t1, Pe�a_Aliada
addi t2,t2, 4
beq a0, t1, Pe�a_Aliada
addi t2,t2, 4
beq a0, t1, Pe�a_Aliada
addi t2,t2, 4
beq a0, t1, Pe�a_Aliada
addi t2,t2, 4
beq a0, t1, Pe�a_Aliada
#caso n�o haja pessas aliadas
j Voltar


Verificar_Pretas:
la t2, Brancas
lw t1, 0(t2)
beq a0, t1, Pode_Comer
addi t2,t2, 4
beq a0, t1, Pode_Comer
addi t2,t2, 4
beq a0, t1, Pode_Comer
addi t2,t2, 4
beq a0, t1, Pode_Comer
addi t2,t2, 4
beq a0, t1, Pode_Comer
addi t2,t2, 4
beq a0, t1, Pode_Comer
addi t2,t2, 4
beq a0, t1, Pode_Comer
addi t2,t2, 4
beq a0, t1, Pode_Comer
addi t2,t2, 4
beq a0, t1, Pode_Comer
addi t2,t2, 4
beq a0, t1, Pode_Comer
addi t2,t2, 4
beq a0, t1, Pode_Comer
addi t2,t2, 4
beq a0, t1, Pode_Comer
#caso n�o haja pessas aliadas
j Voltar

Voltar:
jr ra

Pode_Comer:

Pe�a_Aliada:
#N�o � possivel a movimenta��o pela  existencia de uma pe�a aliada
j Mover_Pe�a



Dama:

Linha_Invalida:

Coluna_invalida:

N�o_Ha_Pe�a:
