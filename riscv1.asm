.data
Brancas: 0, 2, 4, 6, 9, 11, 13, 15, 16, 18, 20, 22

Pretas: 57, 59, 61, 63, 48, 50, 52, 54, 41, 43, 45, 47
MsgSelCol: .string "Digite o n�mero da coluna(0 a 7): "
MsgSelLin: .string "Digite o numero da linha(0 a 7): "
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
	addi sp, sp, -16 #salva na pilha as posi��es para onde se pode ir
	sw a0, 0(sp)
	sw a1, 4(sp)
	sw a2, 8(sp)
	sw a3, 12(sp)
	add a6, zero, sp
	add a5, zero, zero
Verifica��es:
	add a1, zero, zero
	jal Verificar_Amigas # entra a0 como a posi��o onde se deseja ir
	# Tem como entrada a posi��o a ser avaliada(a0) e a posi��o onde a pe�a esta(a1) 
	jal Verificar_Comer #Retorna a posi��o posi��o para movimento(a0) e caso comer seja possivel o endere�o da pe�a a ser comida(a1)
	beq a1, zero, N�o_Salvar_Comida
	addi sp, sp, -4
	sw a1, 0(sp)#Salva na pilha a posi��o da pe�a a ser comida
	N�o_Salvar_Comida:
		addi sp, sp, -4
		sw zero, 0(sp)#Salva na pilha 0 pois n�o a pe�a a ser comida
		sw a0, 0(a6)#salva nova posi��o na pilha
		addi a6, a6, 4#Verifica a proxima posi��o
		lw a0, 0(a6)#Proxima posi��o a ser verificada
		li t0, 4
		addi a5, a5, 1
		bne a5, t0, Verifica��es
	#Tirando da pilha as posi��es
	lw a0, 0(sp)
	addi sp, sp, 4
	lw a1, 0(sp)
	addi sp, sp, 4
	lw a2, 0(sp)
	addi sp, sp, 4
	lw a3, 0(sp)
	addi sp, sp, 4
	lw s3, 0(sp) #Posi��o caso a0 coma
	addi sp, sp, 4
	lw s4, 0(sp) #Posi��o caso a1 coma
	addi sp, sp, 4
	lw s5, 0(sp) #Posi��o caso a2 coma
	addi sp, sp, 4
	lw s6, 0(sp) #Posi��o caso a3 coma
	addi sp, sp, 4
	#Caso passe todas as op��es de movimento foram verificadas
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
	add t2, s3, zero
	beq a0, t0, Fim_Jogada
	ecall
	li t0, 1
	add t1, a2, zero
	add t2, s4, zero
	beq a0, t0, Fim_Jogada
	ecall
	li t0, 2
	add t1, a3, zero
	add t2, s5, zero
	beq a0, t0, Fim_Jogada
	ecall
	li t0, 3
	add t1, a4, zero
	add t2, s6, zero
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
	add s3, t2, zero#Posi��o da pe� a ser comida caso haja
#tem como entradas se � branca ou preta(a1) e a posi��o(a0)   e retorna em a0 a mesma posi��o ou a posi��o +100 para indicar que � uma dama
	jal Verificar_Dama
Fim_Jogada_Dama:
	li t0, 0
	bne s3, t0, N�o_Comeu
	li t0, -2
	sw t0, 0(s3)
	addi s7, zero, -1#Flag para a jogada repetida
	sw a0,0(s1)
	jal Printar_Tela
	jal Verificar_Final_Jogo
	add a1, s1, zero
	j Mover_Pe�a
	N�o_Comeu:
		li t0,-1
		beq s7, t0, N�o_comeu_de_Novo #A ajogada repetida s� ocorre caso coma outra pe�a
		sw a0,0(s1)
	jal Printar_Tela
	jal Verificar_Final_Jogo
	j Jogada_PC

N�o_comeu_de_Novo:
#Printar N�o comeu de novo e passar a jogada para o pc
j Jogada_PC



Calcular_Posi��o:
#Digitar posi��o ao qual deseja se mover
	la a0,MsgSelLin # mensagem de leitura de linha
	li a7,4
	ecall
	li a7, 5
	ecall
	li t1, 8
#as Colunas v�o de 0 a 7
	bgeu a0,t1, Linha_Coluna_Invalida 
	add t0, a0, zero
#Calcula-se a posi��o usando a coluna
	mul t0, t0, t1 # t0 := t0 * 8
	la a0,MsgSelCol # mensagem de leitura de coluna
	li a7,4
	ecall
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
	add t0, a0, zero#Posi��o da pe�a
	la a1, Brancas
	lw t1, 0(a1)
	addi t0, t0, 100 #Somo-se 100 a posi��o para verificar se h� alguma dama neste local
	beq t0, t1, Mover_Dama
	addi a1,a1, 4
	lw t1, 0(a1)
	beq t0, t1, Mover_Dama
	addi a1,a1, 4
	lw t1, 0(a1)
	beq t0, t1, Mover_Dama
	addi a1,a1, 4
	lw t1, 0(a1)
	beq t0, t1, Mover_Dama
	addi a1,a1, 4
	lw t1, 0(a1)
	beq t0, t1, Mover_Dama
	addi a1,a1, 4
	lw t1, 0(a1)
	beq t0, t1, Mover_Dama
	addi a1,a1, 4
	lw t1, 0(a1)
	beq t0, t1, Mover_Dama
	addi a1,a1, 4
	lw t1, 0(a1)
	beq t0, t1, Mover_Dama
	addi a1,a1, 4
	lw t1, 0(a1)
	beq t0, t1, Mover_Dama
	addi a1,a1, 4
	lw t1, 0(a1)
	beq t0, t1, Mover_Dama
	addi a1,a1, 4
	lw t1, 0(a1)
	beq t0, t1, Mover_Dama
	addi a1,a1, 4
	lw t1, 0(a1)
	beq t0, t1, Mover_Dama
	jr ra

Dama_Preta:
	add t0, a0, zero
	la a1, Pretas
	lw t1, 0(a1)
	addi t0, t0, 100 #Somo-se 100 a posi��o para verificar se h� alguma dama neste local
	beq t0, t1, Mover_Dama
	addi a1,a1, 4
	lw t1, 0(a1)
	beq t0, t1, Mover_Dama
	addi a1,a1, 4
	lw t1, 0(a1)
	beq t0, t1, Mover_Dama
	addi a1,a1, 4
	lw t1, 0(a1)
	beq t0, t1, Mover_Dama
	addi a1,a1, 4
	lw t1, 0(a1)
	beq t0, t1, Mover_Dama
	addi a1,a1, 4
	lw t1, 0(a1)
	beq t0, t1, Mover_Dama
	addi a1,a1, 4
	lw t1, 0(a1)
	beq t0, t1, Mover_Dama
	addi a1,a1, 4
	lw t1, 0(a1)
	beq t0, t1, Mover_Dama
	addi a1,a1, 4
	lw t1, 0(a1)
	beq t0, t1, Mover_Dama
	addi a1,a1, 4
	lw t1, 0(a1)	
	beq t0, t1, Mover_Dama
	addi a1,a1, 4
	lw t1, 0(a1)
	beq t0, t1, Mover_Dama
	addi a1,a1, 4
	lw t1, 0(a1)
	beq t0, t1, Mover_Dama
	jr ra

Achar_Branca:
	add t0, a0, zero
	la a1, Brancas
	lw t0, 0(a1)
	beq t0, a0, Mover_Pe�a
	addi a1,a1, 4
	lw t0, 0(a1)
	beq t0, a0, Mover_Pe�a
	addi a1,a1, 4
	lw t0, 0(a1)
	beq t0, a0, Mover_Pe�a
	addi a1,a1, 4
	lw t0, 0(a1)
	beq t0, a0, Mover_Pe�a
	addi a1,a1, 4
	lw t0, 0(a1)
	beq t0, a0, Mover_Pe�a
	addi a1,a1, 4
	lw t0, 0(a1)
	beq t0, a0, Mover_Pe�a
	addi a1,a1, 4
	lw t0, 0(a1)
	beq t0, a0, Mover_Pe�a
	addi a1,a1, 4
	lw t0, 0(a1)
	beq t0, a0, Mover_Pe�a
	addi a1,a1, 4
	lw t0, 0(a1)
	beq t0, a0, Mover_Pe�a
	addi a1,a1, 4
	lw t0, 0(a1)
	beq t0, a0, Mover_Pe�a
	addi a1,a1, 4
	lw t0, 0(a1)
	beq t0, a0, Mover_Pe�a
	addi a1,a1, 4
	lw t0, 0(a1)
	beq t0, a0, Mover_Pe�a
	jal ra, N�o_Ha_Pe�a_Branca

Achar_Preta:
	add t0, a0, zero
	la a0, Pretas
	lw t0, 0(a1)
	beq t0, a0, Mover_Pe�a
	addi a1,a1, 4
	lw t0, 0(a1)
	beq t0, a0, Mover_Pe�a
	addi a1,a1, 4
	lw t0, 0(a1)
	beq t0, a0, Mover_Pe�a
	addi a1,a1, 4
	lw t0, 0(a1)
	beq t0, a0, Mover_Pe�a
	addi a1,a1, 4
	lw t0, 0(a1)
	beq t0, a0, Mover_Pe�a
	addi a1,a1, 4
	lw t0, 0(a1)
	beq t0, a0, Mover_Pe�a
	addi a1,a1, 4
	lw t0, 0(a1)
	beq t0, a0, Mover_Pe�a
	addi a1,a1, 4
	lw t0, 0(a1)
	beq t0, a0, Mover_Pe�a
	addi a1,a1, 4
	lw t0, 0(a1)
	beq t0, a0, Mover_Pe�a
	addi a1,a1, 4
	lw t0, 0(a1)
	beq t0, a0, Mover_Pe�a
	addi a1,a1, 4
	lw t0, 0(a1)
	beq t0, a0, Mover_Pe�a
	addi a1,a1, 4
	lw t0, 0(a1)
	beq t0, a0, Mover_Pe�a
	jal ra, N�o_Ha_Pe�a_Preta



Verificar_Comer:
	li t0, 0
	beq s2, t0, Verificar_Comer_Branca#Se o jogador estiver com as brancas Verifica se h� uma Preta
	j Verificar_Comer_Preta

	Verificar_Comer_Preta: #Se o jogador estiver com as pretas Verifica se h� uma Branca
		la t0, Brancas
		li t2, 0
		li t3, 11
	j Loop_Verificar_Inimiga

	Verificar_Comer_Branca:
		la t0, Pretas
		li t2, 0
		li t3, 11
	j Loop_Verificar_Inimiga

	Loop_Verificar_Inimiga:
		lw t1, 0(t0)
		li t4, -2
		bne a0, t1, N�o_Inimiga#Caso haja uma pe�a inimiga verifica se � possvel comer ela
		beq a1, t4, N�o_Pode_Comer#Indentifica a flag sabendo q esta passando pela segunda vez nela, endo assim h� duas inimigas em sequencia ou seja n�o da pra comer
		add t4, a0, zero #Posi��o para onde a pe�a iria inicialmente
		sub t3, t4, s0#Diferen�a ente a posi��o q deja ir e onde a pe�a esta
		add a0, a0, t3#Tem-se  a posi��o seguinte para onde a pe�a deve ir
		addi sp, sp -12
		sw t0, 0(sp)
		sw t1, 4(sp)
		sw ra, 8(sp)
		li t1,8
		rem t0, a0, t1 #Verifica a coluna da posi��o onde deseja ir
		rem t1, t4, t1#Verifica da posi��o previa, onde ele desejava ir
		sub  t0, t1, t0 # Pega a diferen�a entre elas
		li t1, 1
		blt t0, t1, V�lido#Verifica se a diferen�a deles � maior q 1 se for � uma posi��o invalida
		li t1, -1
		bgt t0, t1, V�lido#Verifica se a diferen�a deles � maior q 1 se for � uma posi��o invalida
		addi a0, zero, -1
		addi a1, zero, -1#Pois n�o havera pe�a para ser comida
		V�lido:
			jal Verificar_Amigas #Verifica se h� uma pe�a amiga na posi��o
			addi a1, zero, -1#flag para a fun��o saber q esta passando pela segunda vez nela
			j Verificar_Comer
			lw t0, 0(sp)
			addi sp, sp, 4
			lw t1, 0(sp)
			addi sp, sp, 4
			lw ra, 0(sp)
			jr ra
N�o_Inimiga:
	bne a1, t4, Salto#Indentifica a flag sabendo q esta passando pela segunda vez nela, ent�o � possivel comer a pe�a, a0 j� esta com o valor correto falta o a1
	lw t0, 0(sp)#Desempilha
	addi sp, sp, 4
	lw t1, 0(sp)
	addi sp, sp, 4
	lw ra, 0(sp)
	add a1, t0, zero #Salva o endere�o da pe�a a ser comida
	jr ra
	Salto:
		beq t2, t3, Voltar
		addi t2, t2, 1
		addi t0, t0, 4
		add a1, zero, zero#Pois n�o havera pe�a para ser comida
	j Loop_Verificar_Inimiga

	N�o_Pode_Comer:
		lw t0, 0(sp)#Desempilha
		addi sp, sp, 4
	lw t1, 0(sp)
	addi sp, sp, 4
	lw ra, 0(sp)
	addi a0, zero, -1
	add a1, zero, zero
	jr ra

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
		addi t0, a0, -7
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
		addi t0, a0, -9
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


Verificar_Amigas:
	li t0, 0
	beq s2, t0, Verificar_Brancas_Amigas
	j Verificar_Pretas_Amigas

	Verificar_Brancas_Amigas:
		la t0, Brancas
		li t2, 0
		li t3, 11
	j Loop_Verificar_Amiga

	Verificar_Pretas_Amigas:
	la t0, Pretas
	li t2, 0
	li t3, 11
	j Loop_Verificar_Amiga
 
	Loop_Verificar_Amiga:
		lw t1, 0(t0)
		bne a0, t1, N�o_Amiga1
		addi a0, zero, -1
		jr ra
	N�o_Amiga1:
		beq t2, t3, Voltar
		addi t2, t2, 1
	addi t0, t0, 4
	j Loop_Verificar_Amiga
	Voltar:
		jr ra

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

Jogada_PC:
