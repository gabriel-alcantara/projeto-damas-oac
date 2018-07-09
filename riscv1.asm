.data
Brancas: 0, 2, 4, 6, 9, 11, 13, 15, 16, 18, 20, 22

Pretas: 57, 59, 61, 63, 48, 50, 52, 54, 41, 43, 45, 57
MsgSelCol: .string "Digite o número da coluna(0 a 7): "
MsgSelLin: .string "Digite o numero da linha(0 a 7): "
MsgSelJog: .string "Digite o numero da sua jogada:(0,1,2,3): "
MsgInvLin: .string "Linha ou Coluna inválida"
 .text
 GAMELOOP:
 	jal tp,Printar_Tela
 	jal tp,Jogada_Branca
 	jal Verificar_Final_Jogo
 	jal tp,Jogada_PC
 	jal tp,Verificar_Final_Jogo
 	j GAMELOOP
 # As brancas começam jogando começa jogando, digita-se a linha e a coluna da peça
Jogada_Branca:
 #Marca que a jogada é branca
	li s2, 0
 #retorna e a0 o valor da peça
	 jal Calcular_Posição

#verificar se é dama Branca, entrada a posição da peça
	jal Dama_Branca

#Procurando a peça que deseja mover no vetor. Entra a posição a0 e retorna a posição a0 e o endereço da peça na memória a1
	jal Achar_Branca

#Caso a peça exista ela vêm para cá onde a0 é a posição e a1 o local da memória da peça
Mover_Peça:
#Posições posiveis de mover, retorna na pilha para onde é possível se mover, havendo ou não peças lá e tem entrada a posição da peça
	add s0, a0, zero
	add s1, a1, zero
#s0 é a posição e s1 o local da memoria da peça
#Posições posiveis de mover, retorna de a0 a a3 onde é possível se mover, havendo ou não peças lá e tem entrada a posição da peça os valores -1 caso n possa mover a peça
	jal Possivel_Mover
#ele retorn de a0 a a3 as  posições possiveis de ir e de entrada recebe as posições possiveis de ir de a0 a a3 e a4 a posição da peça
	add a4, s0, zero
	addi sp, sp, -16 #salva na pilha as posições para onde se pode ir
	sw a0, 0(sp)
	sw a1, 4(sp)
	sw a2, 8(sp)
	sw a3, 12(sp)
	add a6, zero, sp   # a6:= topo da pilha
	add a5, zero, zero # a5:= 0
Verificações:
	add a1, zero, zero
	jal Verificar_Amigas # entra a0 como a posição onde se deseja ir
	# Tem como entrada a posição a ser avaliada(a0) e a posição onde a peça esta(a1) 
	jal Verificar_Comer #Retorna a posição posição para movimento(a0) e caso comer seja possivel o endereço da peça a ser comida(a1)
	beq a1, zero, Não_Salvar_Comida
	addi sp, sp, -4
	sw a1, 0(sp)#Salva na pilha a posição da peça a ser comida
	sw a0, 0(a6)	#salva nova posição na pilha
	addi a6, a6,4	#Verifica a proxima posição
	lw a0, 0(a6)	#Proxima posição a ser verificada
	li t0, 4
	addi a5, a5, 1
	bne a5, t0, Verificações
	Não_Salvar_Comida:
		addi sp, sp, -4  
		sw zero, 0(sp)	#Salva na pilha 0 pois não a peça a ser comida
		sw a0, 0(a6)	#salva nova posição na pilha
		addi a6, a6,4	#Verifica a proxima posição
		lw a0, 0(a6)	#Proxima posição a ser verificada
		li t0, 4
		addi a5, a5, 1
		bne a5, t0, Verificações
	#Tirando da pilha as posições
	lw s6, 0(sp)
	addi sp, sp, 4
	lw s5, 0(sp)
	addi sp, sp, 4
	lw s4, 0(sp)
	addi sp, sp, 4
	lw s3, 0(sp)
	addi sp, sp, 4
	lw a0, 0(sp) #Posição caso a0 coma
	addi sp, sp, 4
	lw a1, 0(sp) #Posição caso a1 coma
	addi sp, sp, 4
	lw a2, 0(sp) #Posição caso a2 coma
	addi sp, sp, 4
	lw a3, 0(sp) #Posição caso a3 coma
	addi sp, sp, 4
	#Caso passe todas as opções de movimento foram verificadas
	#Pedir para o jogador escolher para qual das 4 posições ele deseja ir, onde a zero é a primeira a ser apresentada e a 3  a úlima
	add a4, a3, zero
	add a3, a2, zero
	add a2, a1, zero
	add a1, a0, zero
Opção_Invalida:
	li t6,1
	beq s2,t6,JogadaRandom
	la a0,MsgSelJog # mesagem de seleçao de jogada
	li a7,4
	ecall
	li a7, 5 
	ecall
	j endRandom
	JogadaRandom:
		li a7,30
		addi a0,a0,1970
		li t6,4
		rem s10,a0,t6 # s0 := a0 % 4
		mv a0,s10
	endRandom:
	li t0, 0
	add t1, a1, zero # t1 := posiçao jogada 1
	add t2, s3, zero # t2 := posicao para comer jogada 1
	beq a0, t0, Fim_Jogada
	#ecall
	li t0, 1
	add t1, a2, zero
	add t2, s4, zero
	beq a0, t0, Fim_Jogada
	#ecall
	li t0, 2
	add t1, a3, zero
	add t2, s5, zero
	beq a0, t0, Fim_Jogada
	#ecall
	li t0, 3
	add t1, a4, zero
	add t2, s6, zero
	beq a0, t0, Fim_Jogada
	li s9,-1
	beq a0,s9,Opção_Invalida
	j Opção_Invalida 

# As brancas começam jogando começa jogando, digita-se a linha e a coluna da peça
Jogada_Preta:
  #Marca que a jogada é preta
 	li s2, 1
 #retorna e a0 o valor da peça
 	jal Calcular_Posição
#verificar se é dama Branca, entrada a posição da peça
	jal Dama_Preta
#Procurando a peça que deseja mover no vetor. Entra a posição a0 e retorna a posição a0 e o endereço da peça na memória a1
	jal Achar_Preta


Fim_Jogada:
	add a0, t1, zero # a0: = jogada selecionada
	add a1, s2, zero # a1:= preta ou branca
	add s3, t2, zero #Posição da peça ser comida caso haja
#tem como entradas se é branca ou preta(a1) e a posição(a0)   e retorna em a0 a mesma posição ou a posição +100 para indicar que é uma dama
	jal Verificar_Dama
	Fim_Jogada_Dama:
		li t0, 0
		beq s3, t0, Não_Comeu
		li t0, -2
		sw t0, 0(s3)
		addi s7, zero, -1#Flag para a jogada repetida
		sw a0,0(s1)
		jal Printar_Tela
		jal Verificar_Final_Jogo
		add a1, s1, zero
		j Mover_Peça
		Não_Comeu:
			li t0,-1
			beq s7, t0, Não_comeu_de_Novo #A ajogada repetida só ocorre caso coma outra peça
			sw a0,0(s1)
		#jal Printar_Tela
		#jal Verificar_Final_Jogo
		jr tp # volta pro GAMELOOP

Não_comeu_de_Novo:
#Printar Não comeu de novo e passar a jogada para o pc
jr tp # Volta pro GAMELOOP



Calcular_Posição:
#Digitar posição ao qual deseja se mover
	la a0,MsgSelLin # mensagem de leitura de linha
	li a7,4
	ecall
	li a7, 5
	ecall
	li t1, 8
#as Colunas vão de 0 a 7
	bgeu a0,t1, Linha_Coluna_Invalida 
	add t0, a0, zero
#Calcula-se a posição usando a coluna
	mul t0, t0, t1 # t0 := t0 * 8
	la a0,MsgSelCol # mensagem de leitura de coluna
	li a7,4
	ecall
#pega-se a linha
	 li a7, 5
	ecall
 #as Colunas vão de 0 a 7
	bgeu a0, t1, Linha_Coluna_Invalida 
#acha-se a posição da peça
	add a0, a0, t0
#retorna
	jr ra

Possivel_Mover:
#vai retornar a coluna que a peça esta
	li t1, 8
	rem t0, s0, t1
	li t1,0
	beq t0, t1, Ponta_Esquerda
	li t1,7
	beq t0, t1, Ponta_Direita
	li t1, 63
	addi t0, s0, 7 
	bltz t0, Não_Fixa_1
	bgt t0, t1, Não_Fixa_1
	add a0, t0, zero
	j Continua1
	Não_Fixa_1:
		li a0, -1
	Continua1:
		addi t0, s0, 9
		bltz t0, Não_Fixa_2
		bgt t0, t1, Não_Fixa_2
		add a1, t0, zero
		j Continua2
	Não_Fixa_2:
		li a1, -1
	Continua2:
		addi t0, s0, -7
		bltz t0, Não_Fixa_3
		bgt t0, t1, Não_Fixa_3
	add a2, t0, zero
	j Continua3
	Não_Fixa_3:
		li a2, -1
	Continua3:
		addi t0, s0, -9
		bltz t0, Não_Fixa_4
		bgt t0, t1, Não_Fixa_4
		add a3, t0, zero
		j Continua4
	Não_Fixa_4:
		li a3, -1
	Continua4:
		jr ra

Dama_Branca:
	add t0, a0, zero#Posição da peça
	la a1, Brancas
	lw t1, 0(a1)
	addi t0, t0, 100 #Somo-se 100 a posição para verificar se há alguma dama neste local
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
	addi t0, t0, 100 #Somo-se 100 a posição para verificar se há alguma dama neste local
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
	beq t0, a0, Mover_Peça
	addi a1,a1, 4
	lw t0, 0(a1)
	beq t0, a0, Mover_Peça
	addi a1,a1, 4
	lw t0, 0(a1)
	beq t0, a0, Mover_Peça
	addi a1,a1, 4
	lw t0, 0(a1)
	beq t0, a0, Mover_Peça
	addi a1,a1, 4
	lw t0, 0(a1)
	beq t0, a0, Mover_Peça
	addi a1,a1, 4
	lw t0, 0(a1)
	beq t0, a0, Mover_Peça
	addi a1,a1, 4
	lw t0, 0(a1)
	beq t0, a0, Mover_Peça
	addi a1,a1, 4
	lw t0, 0(a1)
	beq t0, a0, Mover_Peça
	addi a1,a1, 4
	lw t0, 0(a1)
	beq t0, a0, Mover_Peça
	addi a1,a1, 4
	lw t0, 0(a1)
	beq t0, a0, Mover_Peça
	addi a1,a1, 4
	lw t0, 0(a1)
	beq t0, a0, Mover_Peça
	addi a1,a1, 4
	lw t0, 0(a1)
	beq t0, a0, Mover_Peça
	jal ra, Não_Ha_Peça_Branca

Achar_Preta:
	add t0, a0, zero
	la a0, Pretas
	lw t0, 0(a1)
	beq t0, a0, Mover_Peça
	addi a1,a1, 4
	lw t0, 0(a1)
	beq t0, a0, Mover_Peça
	addi a1,a1, 4
	lw t0, 0(a1)
	beq t0, a0, Mover_Peça
	addi a1,a1, 4
	lw t0, 0(a1)
	beq t0, a0, Mover_Peça
	addi a1,a1, 4
	lw t0, 0(a1)
	beq t0, a0, Mover_Peça
	addi a1,a1, 4
	lw t0, 0(a1)
	beq t0, a0, Mover_Peça
	addi a1,a1, 4
	lw t0, 0(a1)
	beq t0, a0, Mover_Peça
	addi a1,a1, 4
	lw t0, 0(a1)
	beq t0, a0, Mover_Peça
	addi a1,a1, 4
	lw t0, 0(a1)
	beq t0, a0, Mover_Peça
	addi a1,a1, 4
	lw t0, 0(a1)
	beq t0, a0, Mover_Peça
	addi a1,a1, 4
	lw t0, 0(a1)
	beq t0, a0, Mover_Peça
	addi a1,a1, 4
	lw t0, 0(a1)
	beq t0, a0, Mover_Peça
	jal ra, Não_Ha_Peça_Preta



Verificar_Comer:
	li t0, 0
	beq s2, t0, Verificar_Comer_Branca#Se o jogador estiver com as brancas Verifica se há uma Preta
	j Verificar_Comer_Preta

	Verificar_Comer_Preta: #Se o jogador estiver com as pretas Verifica se há uma Branca
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
		bne a0, t1, Não_Inimiga#Caso haja uma peça inimiga verifica se é possvel comer ela
		beq a1, t4, Não_Pode_Comer#Indentifica a flag sabendo q esta passando pela segunda vez nela, endo assim há duas inimigas em sequencia ou seja não da pra comer
		add t4, a0, zero #Posição para onde a peça iria inicialmente
		sub t3, t4, s0#Diferença ente a posição q deja ir e onde a peça esta
		add a0, a0, t3#Tem-se  a posição seguinte para onde a peça deve ir
		addi sp, sp -12
		sw t0, 0(sp)
		sw t1, 4(sp)
		sw ra, 8(sp)
		li t1,8
		rem t0, a0, t1 #Verifica a coluna da posição onde deseja ir
		rem t1, t4, t1 #Verifica da posição previa, onde ele desejava ir
		sub  t0, t1, t0 # Pega a diferença entre elas
		li t1, 1
		blt t0, t1, Válido#Verifica se a diferença deles é maior q 1 se for é uma posição invalida
		li t1, -1
		bgt t0, t1, Válido#Verifica se a diferença deles é maior q 1 se for é uma posição invalida
		addi a0, zero, -1
		addi a1, zero, -1#Pois não havera peça para ser comida
		lw t0, 0(sp)#Desempilha
		addi sp, sp, 4
		lw t1, 0(sp)
		addi sp, sp, 4
		lw ra, 0(sp)
		addi sp, sp, 4
		add a1, t0, zero #Salva o endereço da peça a ser comida
		jr ra
		Válido:
			jal Verificar_Amigas #Verifica se há uma peça amiga na posição
			addi a1, zero, -2#flag para a função saber q esta passando pela segunda vez nela
			j Verificar_Comer
			lw t0, 0(sp)
			addi sp, sp, 4
			lw t1, 0(sp)
			addi sp, sp, 4
			lw ra, 0(sp)
			addi sp, sp, 4
			jr ra
	Não_Inimiga:
		addi t0, t0, 4
		addi t2, t2, 1
		bne t2, t3, Loop_Verificar_Inimiga
		beq a1, t4, Salto#Indentifica a flag sabendo q esta passando pela segunda vez nela, então é possivel comer a peça, a0 já esta com o valor correto falta o a1
		jr ra
	Salto:
		lw t0, 0(sp)#Desempilha
		addi sp, sp, 4
		lw t1, 0(sp)
		addi sp, sp, 4
		lw ra, 0(sp)
		addi sp, sp, 4
		add a1, t0, zero #Salva o endereço da peça a ser comida
		jr ra
		beq t2, t3, Voltar
		addi t2, t2, 1
		addi t0, t0, 4
		add a1, zero, zero#Pois não havera peça para ser comida
	j Loop_Verificar_Inimiga

	Não_Pode_Comer:
		lw t0, 0(sp)#Desempilha
		addi sp, sp, 4
		lw t1, 0(sp)
		addi sp, sp, 4
		lw ra, 0(sp)
		addi sp, sp, 4
		addi a0, zero, -1
		add a1, zero, zero
		jr ra

Ponta_Esquerda:
	li t1, 63
	addi t0, a0, 9
	bltz t0, Não_Fixa_1
	bgt t0, t1, Não_Fixa_1
	add a0, t0, zero
	j Continua1E
	Não_Fixa_1E:
		li a0, -1
	Continua1E:
		addi t0, a0, -7
		bltz t0, Não_Fixa_2E
		bgt t0, t1, Não_Fixa_2E
		add a1, t0, zero
		j Continua2E
	Não_Fixa_2E:
		li a1, -1
	Continua2E:
		li a2, -1
		li a3, -1
		jr ra

Ponta_Direita:
	li t1, 63
	addi t0, a0, 7
	bltz t0, Não_Fixa_1
	bgt t0, t1, Não_Fixa_1
	add a0, t0, zero
	j Continua1D
	Não_Fixa_1D:
		li a0, -1
	Continua1D:
		addi t0, a0, -9
		bltz t0, Não_Fixa_2D
		bgt t0, t1, Não_Fixa_2D
		add a1, t0, zero
		j Continua2D
	Não_Fixa_2D:
		li a1, -1
	Continua2D:
		li a2, -1
		li a3, -1
		jr ra

Linha_Coluna_Invalida:
#Printar coluna ou linha invlida e voltar para a pergunta da posição
la a0,MsgInvLin
li a7,4
ecall
j Calcular_Posição


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
		bne a0, t1, Não_Amiga1
		addi a0, zero, -1
		jr ra
	Não_Amiga1:
		beq t2, t3, Voltar
		addi t2, t2, 1 # t2++
		addi t0, t0, 4 #t0+=4
		j Loop_Verificar_Amiga
Voltar:
	jr ra

Mover_Dama:


Verificar_Dama: 
	li t1, 55
	bgt s3, t1, Criar_Dama_Branca
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
	#Caso tds as peças de um dos doi lados seja eliminada
	#Verificar Brancas
	la t0, Brancas
	li t4, 0
	li t3, 12
	add t5, zero, zero
	add t6, zero, zero
	Loop2:
	lw t1, 0(t0)
	li t2, -1
	bne t1, t2, Sem_Pretas
	addi t4,t4, 1
	addi t0, t0, 4
	j Loop2
	Sem_Pretas:
	beq t5, t6, Voltar
	li, t5, 1 #Flag indicando q o jogo não acabou
	la t0, Brancas
	li t4, 0
	li t3, 12
	j Loop2
	
	


Printar_Tela:
jr tp
Não_Ha_Peça_Branca:
#Falar que não há peça nesta posição
j Jogada_Branca

Não_Ha_Peça_Preta:
#Falar que não há peça nesta posição
j Jogada_Preta

Jogada_PC:
	li s2,1  # marca que jogada eh preta
	LEVEL1:	
		Loop_random:li a7,30
			li t0,12
			la t1,Pretas
			ecall # chamada de numero aleatorio
			mv s0,a0
			addi s0,s0,1970
			rem t2,s0,t0 # t2:= s0 % 12
			li s11,4
			mul t2,t2,s11 # t2 := t2*4
			add t1,t1,t2
			lw t2,0(t1) # peça aletoria
			li t3,-1
			beq t2,t3,Loop_random
			li t6,100
			mv a0,t2 # a0 := posiçao da peça
			mv a1,t1 # a1 := enderaço da peça
			bge t2,t1,Mover_Dama
			j Mover_Peça
			
			
			
		
