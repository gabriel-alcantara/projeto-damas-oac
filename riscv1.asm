.data
Brancas: 0, 2, 4, 6, 9, 11, 13, 15, 16, 18, 20, 22

Pretas: 57, 59, 61, 63, 48, 50, 52, 54, 41, 43, 45, 47

 .text
 # As brancas come�am jogando come�a jogando, digita-se a linha e a coluna da pe�a
 Jogada_Branca:
 #retorna e a0 o valor da pe�a
 jal Achar_Pe�a

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
jal Achar_Pe�a
addi sp, sp -4
sw t0, 0(sp)
addi sp, sp -4
sw t2, 0(sp)


#Primeiro Verificar a diagonal esquerda
li t1, 7

Achar_Pe�a:
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

Dama:

Linha_Invalida:

Coluna_invalida:

N�o_Ha_Pe�a: