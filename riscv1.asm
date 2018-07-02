.data
Brancas: 0, 2, 4, 6, 9, 11, 13, 15, 16, 18, 20, 22

Pretas: 57, 59, 61, 63, 48, 50, 52, 54, 41, 43, 45, 47

 .text
 # As brancas começam jogando começa jogando, digita-se a linha e a coluna da peça
 Jogada_Branca:
 #retorna e a0 o valor da peça
 jal Achar_Peça

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
jal Achar_Peça
addi sp, sp -4
sw t0, 0(sp)
addi sp, sp -4
sw t2, 0(sp)


#Primeiro Verificar a diagonal esquerda
li t1, 7

Achar_Peça:
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

Dama:

Linha_Invalida:

Coluna_invalida:

Não_Ha_Peça: