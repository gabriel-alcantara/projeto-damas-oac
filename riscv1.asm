.data
Brancas: 0, 2, 4, 6, 9, 11, 13, 15, 16, 18, 20, 22

Pretas: 57, 59, 61, 63, 48, 50, 52, 54, 41, 43, 45, 47

 .text
 # As brancas começam jogando começa jogando, digita-se a linha e a coluna da peça
 Jogada_Branca:
 #retorna e a0 o valor da peça
 jal Calcula_Posição

#Procurando a peça que deseja mover no vetor
add t0, a0, zero
la t2, Brancas
lw t1, 0(t2)
beq t0, t1, Mover_Peça
addi t2,t2, 4
beq t0, t1, Mover_Peça
addi t2,t2, 4
beq t0, t1, Mover_Peça
addi t2,t2, 4
beq t0, t1, Mover_Peça
addi t2,t2, 4
beq t0, t1, Mover_Peça
addi t2,t2, 4
beq t0, t1, Mover_Peça
addi t2,t2, 4
beq t0, t1, Mover_Peça
addi t2,t2, 4
beq t0, t1, Mover_Peça
addi t2,t2, 4
beq t0, t1, Mover_Peça
addi t2,t2, 4
beq t0, t1, Mover_Peça
addi t2,t2, 4
beq t0, t1, Mover_Peça
addi t2,t2, 4
beq t0, t1, Mover_Peça
jal ra, Não_Ha_Peça

Mover_Peça:
addi sp, sp 4
sw t0, -4(sp)
addi sp, sp 4
sw t2, -4(sp)
jal Calcula_Posição
addi sp, sp -4
sw t0, 0(sp)
addi sp, sp -4
sw t2, 0(sp)

#Primeiro Verificar a diagonal esquerda
li a0, 7
#posição para ir
add a0, t0, t1
#posição
add a1, t0, zero

addi sp, sp 4
sw t0, -4(sp)
addi sp, sp 4
sw t2, -4(sp)
#Verifica se há um alidado, caso não haja ele volta para ca
jal Verificar_Brancas
#Verifica se há um inimigo, caso não haja ele volta para ca, caso haja ele verifica se é possível comer
jal Verificar_Pretas
addi sp, sp -4
sw t0, 0(sp)
addi sp, sp -4
sw t2, 0(sp)

#Verificars se há Peça amiga

#Retorna a posição da peça em a0
Calcula_Posição:
#Digitar posição ao qual deseja se mover
li a7, 5
 ecall
 li t1, 8
 #as Colunas vão de 0 a 7
 bgeu a0,t1, Linha_Invalida 
add t0, a0, zero

#Calcula-se a posição usando a coluna
mul t0, t0, t1
#pega-se a linha
 li a7, 5
ecall
 #as Colunas vão de 0 a 7
bgeu a0, t1,Coluna_invalida 
#acha-se a posição da peça
add a0, a0, t0

jr ra

#entrada a0, posição a qual se deseja mover
Verificar_Brancas:
la t2, Brancas
lw t1, 0(t2)
beq a0, t1, Peça_Aliada
addi t2,t2, 4
beq a0, t1, Peça_Aliada
addi t2,t2, 4
beq a0, t1, Peça_Aliada
addi t2,t2, 4
beq a0, t1, Peça_Aliada
addi t2,t2, 4
beq a0, t1, Peça_Aliada
addi t2,t2, 4
beq a0, t1, Peça_Aliada
addi t2,t2, 4
beq a0, t1, Peça_Aliada
addi t2,t2, 4
beq a0, t1, Peça_Aliada
addi t2,t2, 4
beq a0, t1, Peça_Aliada
addi t2,t2, 4
beq a0, t1, Peça_Aliada
addi t2,t2, 4
beq a0, t1, Peça_Aliada
addi t2,t2, 4
beq a0, t1, Peça_Aliada
#caso não haja pessas aliadas
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
#caso não haja pessas aliadas
j Voltar

Voltar:
jr ra

Pode_Comer:

Peça_Aliada:
#Não é possivel a movimentação pela  existencia de uma peça aliada
j Mover_Peça



Dama:

Linha_Invalida:

Coluna_invalida:

Não_Ha_Peça:
