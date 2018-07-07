.data
Brancas: 0, 2, 4, 6, 9, 11, 13, 15, 16, 18, 20, 22

Pretas: 57, 59, 61, 63, 48, 50, 52, 54, 41, 43, 45, 47

 .text
 # As brancas come�am jogando come�a jogando, digita-se a linha e a coluna da pe�a
 Jogada_Branca:
 #Marca que a jogada � branca
 li s2, 0
 #retorna e a0 o valor da pe�a
 jal Calcular_Posi��o

#verificar se � dama Branca, entrada a posi��o da pe�a
jal Dama_Branca

#Procurando a pe�a que deseja mover no vetor. Entra a posi��o a0 e retorna a posi��o a0 e o endere�o da pe�a na mem�ria a1
jal Achar_Branca

#Caso a pe�a exista ela v�m para c� onde a0 � a posi��o e a1 o local da mem�ria da pe�a
Mover_Pe�a:
#Posi��es posiveis de mover, retorna na pilha para onde � poss�vel se mover, havendo ou n�o pe�as l� e tem entrada a posi��o da pe�a
add s0, a0, zero
add s1, a1, zero
#s0 � a posi��o e s1 o local da memoria da pe�a
#Posi��es posiveis de mover, retorna de a0 a a3 onde � poss�vel se mover, havendo ou n�o pe�as l� e tem entrada a posi��o da pe�a os valores -1 caso n possa mover a pe�a
jal Possivel_Mover
#ele retorn de a0 a a3 as  posi��es possiveis de ir e de entrada recebe as posi��es possiveis de ir de a0 a a3 e a4 a posi��o da pe�a
add a4, s0, zero
jal Verificar_Comer_Preta
#Pedir para o jogador escolher para qual das 4 posi��es ele deseja ir, onde a zero � a primeira a ser apresentada e a 3  a �lima
add a4, a3, zero
add a3, a2, zero
add a2, a1, zero
add a1, a0, zero
Op��o_Invalida:
li a7, 5
ecall
li t0, 0
add t1, a1, zero
beq a0, t0, Fim_Jogada
ecall
li t0, 1
add t1, a2, zero
beq a0, t0, Fim_Jogada
ecall
li t0, 2
add t1, a3, zero
beq a0, t0, Fim_Jogada
ecall
li t0, 3
add t1, a4, zero
beq a0, t0, Fim_Jogada
j Op��o_Invalida

# As brancas come�am jogando come�a jogando, digita-se a linha e a coluna da pe�a
 Jogada_Preta:
  #Marca que a jogada � preta
 li s2, 1
 #retorna e a0 o valor da pe�a
 jal Calcular_Posi��o
#verificar se � dama Branca, entrada a posi��o da pe�a
jal Dama_Preta
#Procurando a pe�a que deseja mover no vetor. Entra a posi��o a0 e retorna a posi��o a0 e o endere�o da pe�a na mem�ria a1
jal Achar_Preta


Fim_Jogada:
add a0, t1, zero
add a1, s2, zero
#tem como entradas se � branca ou preta(a1) e a posi��o(a0)   e retorna em a0 a mesma posi��o ou a posi��o +100 para indicar que � uma dama
jal Verificar_Dama
Fim_Jogada_Dama:
sw a0,0(s1)
jal Printar_Tela
jal Verificar_Final_Jogo
j Jogada_PC


Jogada_PC:



Calcular_Posi��o:
#Digitar posi��o ao qual deseja se mover
li a7, 5
ecall
li t1, 8
#as Colunas v�o de 0 a 7
bgeu a0,t1, Linha_Coluna_Invalida 
add t0, a0, zero
#Calcula-se a posi��o usando a coluna
mul t0, t0, t1
#pega-se a linha
 li a7, 5
ecall
 #as Colunas v�o de 0 a 7
bgeu a0, t1, Linha_Coluna_Invalida 
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
li t1, 63
addi t0, a0, 7
bltz t0, N�o_Fixa_1
bgt t0, t1, N�o_Fixa_1
add a0, t0, zero
j Continua1
N�o_Fixa_1:
li a0, -1
Continua1:
addi t0, a0, 9
bltz t0, N�o_Fixa_2
bgt t0, t1, N�o_Fixa_2
add a1, t0, zero
j Continua2
N�o_Fixa_2:
li a1, -1
Continua2:
addi t0, a0, -7
bltz t0, N�o_Fixa_3
bgt t0, t1, N�o_Fixa_3
add a2, t0, zero
j Continua3
N�o_Fixa_3:
li a2, -1
Continua3:
addi t0, a0, -9
bltz t0, N�o_Fixa_4
bgt t0, t1, N�o_Fixa_4
add a3, t0, zero
j Continua4
N�o_Fixa_4:
li a3, -1
Continua4:
jr ra


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

Dama_Preta:
add t0, a0, zero
la t2, Pretas
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

Achar_Preta:
add t0, a0, zero
la t2, Pretas
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
jal ra, N�o_Ha_Pe�a_Preta

Verificar_Comer_Preta:
la t0, Pretas
lw t1, 0(t0)
beq a0, t1, Possivel_Comer_Preta1
beq a1, t1, Possivel_Comer_Preta2
beq a2, t1, Possivel_Comer_Preta3
beq a3, t1, Possivel_Comer_Preta4
jr ra
Possivel_Comer_Preta1:
sub t0, a0, a4
add a0, a0, t0
j Verificar_Comer_Preta
Possivel_Comer_Preta2:
sub t0, a1, a4
add a1, a1, t0
j Verificar_Comer_Preta
Possivel_Comer_Preta3:
sub t0, a2, a4
add a2, a2, t0
j Verificar_Comer_Preta
Possivel_Comer_Preta4:
sub t0, a3, a4
add a3, a3, t0
j Verificar_Comer_Preta



Ponta_Esquerda:
li t1, 63
addi t0, a0, 9
bltz t0, N�o_Fixa_1
bgt t0, t1, N�o_Fixa_1
add a0, t0, zero
j Continua1E
N�o_Fixa_1E:
li a0, -1
Continua1E:
addi t0, a0, -9
bltz t0, N�o_Fixa_2E
bgt t0, t1, N�o_Fixa_2E
add a1, t0, zero
j Continua2E
N�o_Fixa_2E:
li a1, -1
Continua2E:
li a2, -1
li a3, -1
jr ra

Ponta_Direita:
li t1, 63
addi t0, a0, 7
bltz t0, N�o_Fixa_1
bgt t0, t1, N�o_Fixa_1
add a0, t0, zero
j Continua1D
N�o_Fixa_1D:
li a0, -1
Continua1D:
addi t0, a0, -7
bltz t0, N�o_Fixa_2D
bgt t0, t1, N�o_Fixa_2D
add a1, t0, zero
j Continua2D
N�o_Fixa_2D:
li a1, -1
Continua2D:
li a2, -1
li a3, -1
jr ra

Linha_Coluna_Invalida:
#Printar coluna ou linha invlida e voltar para a pergunta da posi��o
j Calcular_Posi��o


Mover_Dama:


Verificar_Dama:
li t1, 55
bgt a0, t1, Criar_Dama_Branca
li t1, 8
blt a0, t1, Criar_Dama_Preta
jr ra

Criar_Dama_Branca:
li t1, 0
bne a1, t1 Criar
jr ra

Criar:
addi a0, a0, 100
jr ra

Criar_Dama_Preta:
li t1, 1
bne a1, t1 Criar
jr ra

Verificar_Final_Jogo:

Printar_Tela:

N�o_Ha_Pe�a_Branca:
#Falar que n�o h� pe�a nesta posi��o
j Jogada_Branca

N�o_Ha_Pe�a_Preta:
#Falar que n�o h� pe�a nesta posi��o
j Jogada_Preta
