.data
Brancas: 0, 2, 4, 6, 9, 11, 13, 15, 16, 18, 20, 22

Pretas: 57, 59, 61, 63, 48, 50, 52, 54, 41, 43, 45, 47

 .text
 # As brancas começam jogando começa jogando, digita-se a linha e a coluna da peça
 Jogada_Branca:
 #retorna e a0 o valor da peça
 jal Calcular_Posição

#verificar se é dama Branca, entrada a posição da peça
jal Dama_Branca

#Procurando a peça que deseja mover no vetor. Entra a posição a0 e retorna a posição a0 e o endereço da peça na memória a1
jal Achar_Branca

#Caso a peça exista ela vêm para cá onde a0 é a posição e a1 o local da memória da peça
Mover_Peça:
#Posições posiveis de mover, retorna na pilha para onde é possível se mover, havendo ou não peças lá e tem entrada a posição da peça
jal Possivel_Mover
#caso seja posivel comer uma peça preta ele vai para a função comer caso não ele retorna
jal Verificar_Comer_Pretas
addi sp, sp -4
sw a0, 0(sp)
addi sp, sp -4
sw a1, 0(sp)
#Retorna em a0 o valor da posição
jal Calcular_Posição
add a2, a0, zero
sw a1, 0(sp)
addi sp, sp 4
sw a0, 0(sp)
addi sp, sp 4


#Primeiro Verificar a diagonal esquerda
li t1, 7

Calcular_Posição:
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
#retorna
jr ra

Possivel_Mover:
#vai retornar a coluna que a peça esta
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
beq t0, a1, Mover_Peça
addi t2,t2, 4
lw a1, 0(t2)
beq t0, a1, Mover_Peça
addi t2,t2, 4
lw a1, 0(t2)
beq t0, a1, Mover_Peça
addi t2,t2, 4
lw a1, 0(t2)
beq t0, a1, Mover_Peça
addi t2,t2, 4
lw a1, 0(t2)
beq t0, a1, Mover_Peça
addi t2,t2, 4
lw a1, 0(t2)
beq t0, a1, Mover_Peça
addi t2,t2, 4
lw a1, 0(t2)
beq t0, a1, Mover_Peça
addi t2,t2, 4
lw a1, 0(t2)
beq t0, a1, Mover_Peça
addi t2,t2, 4
lw a1, 0(t2)
beq t0, a1, Mover_Peça
addi t2,t2, 4
lw a1, 0(t2)
beq t0, a1, Mover_Peça
addi t2,t2, 4
lw a1, 0(t2)
beq t0, a1, Mover_Peça
addi t2,t2, 4
lw a1, 0(t2)
beq t0, a1, Mover_Peça
jal ra, Não_Ha_Peça_Branca


Verificar_Comer_Pretas:

Ponta_Esquerda:

Ponta_Direita:

Linha_Invalida:

Coluna_invalida:

Mover_Dama:

Não_Ha_Peça_Branca:
#Falar que não há peça nesta posição
j Jogada_Branca