.data
Brancas: 0, 2, 4, 6, 9, 11, 13, 15, 16, 18, 20, 22

Pretas: 57, 59, 61, 63, 48, 50, 52, 54, 41, 43, 45, 47

MsgSelCol: .string "Digite o número da coluna(0 a 7): "
MsgSelLin: .string "Digite o numero da linha(0 a 7): "
 .text
# GAMELOOP:
 	# jal ra,Jogada_Branca
 	# jal ra,Jogada_Preta
 	# jal ra, VerificaPartida
 
 
 # As brancas começam jogando começa jogando, digita-se a linha e a coluna da peça
Jogada_Branca:
 #Marca que a jogada é branca
	li s2, 0
 	jal Calcular_Posição  #retorna e a0 o valor da peça
 	li tp,0  # tp== 0 peça branca : tp==1 peça preta
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
#Caso a peça exista ela vêm para cá onde a0 é a posição e a1 o local da memória da peça
Mover_Peça:     # tp== 0 peça branca : tp==1 peça preta
	add s0, a0, zero # s0 := posicao da peça
	add s1, a1, zero # s1 := endereço da peça
	beq tp,zero,Comida_branca
	Comida_preta:
	
	Comida_branca:
		# s3 ==1 se pode comer atras para esquerda
		# s4== 1 se pode comer atras para direita
		# s5 == 1 se pode comer frente esquerda
		# s6 == 1 se pode comer frente direta
		addi s3,zero,0
		addi s4,zero,0
		addi s5,zero,0
		addi s6,zero,0
		comer_atras_esquerda:	addi t0,s0,-9 
			addi a0,t0,0 # a0 := posicao atras a esquerda da peça
			jal ra,Procura_Pretas # a0 recebe -1 se nao tem peça inimiga na posicao
			li t1,-1
			beq a0,t1,comer_atras_direita # se nao tem peca para comer verifica outra posiçao
			addi a0,s0,-18
			jal ra,Procura_pretas
			bne a0,t1,comer_atras_direita  # se nao esta pode comer a peça, verifica outra posiçao
			li s3,1
		comer_atras_direita: addi t0,s0,-7
			addi a0,t0,0 #a1:= posicao atras a direita da peça
			jal ra,Procura_Pretas # a0 recebe -1 se nao tem peca inimiga na posicao
			beq a0,t1,comer_frente_direita # se nao tem peca para comer, verifica outra posicao
			addi a0,s0,-14     
			jal ra,Procura_pretas
			bne a0,t1,comer_frente_direita # se nao pode comer a peça,verifica outra posiçao
			li s4,1
		comer_frente_direita: addi t0,s0,9
			addi a0,t0,0 # a2:= posicao frente a direta da peça
			jal ra,Procura_Pretas # a0 recebe -1 se nao tem peça inimiga na posiçao
			beq a0,t1,comer_frente_direta # se 

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
	add a0, t1, zero
	add a1, s2, zero
#tem como entradas se é branca ou preta(a1) e a posição(a0)   e retorna em a0 a mesma posição ou a posição +100 para indicar que é uma dama
	jal Verificar_Dama
Fim_Jogada_Dama:
	sw a0,0(s1)
	jal Printar_Tela
	jal Verificar_Final_Jogo
	j Jogada_PC




Procura_Pretas:# a0 esta a posição procurada
		la t0,Pretas
		addi t2,t0,48 # t2  recebe o ultimo endereço do vetor Pretas
	For:	lw t1, 0(t0) # t1:= posiçao de uma peça preta
		beq t1,a0,Fim_for #  if t1==a0 : acho a peça
		addi t0,t0,4
		bge t2,t0,For # if(t2>t0) : PC= For ; verifica se já percurou todo o vetor
		addi a0,zero,-1 # -1 indicando posicao vazia ou com peca aliada
		j ra
	Fim_for:
		addi a0,t1,0 # posicao da peca inimiga
		j ra  
		
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
	mul t0, t0, t1
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


Achar_Preta:
	add t0, a0, zero
	la t2, Pretas
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
	jal ra, Não_Ha_Peça_Preta



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

Não_Ha_Peça_Branca:
	#Falar que não há peça nesta posição
j Jogada_Branca

Não_Ha_Peça_Preta:
#Falar que não há peça nesta posição
j Jogada_Preta

Jogada_PC:
