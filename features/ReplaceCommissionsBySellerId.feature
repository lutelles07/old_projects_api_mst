# language: pt
Funcionalidade: Substituir os dados de comissão de um seller
	Para facilitar o processo de atualzação de dados de comissão 
	Como api do Ahoy
	Quero substituir todas as comissões existentes em um seller por ID

	@create_seller_all
	Cenário: Substituir uma comissão usado a rota por id do seller
		Dado que eu faça uma substituição dos dados de comissão usando o id de um seller
		Então será retornado código "204"
		E as comissões serão inseridas

	@create_seller
	Cenário: Inserir comissão usado a rota por id do seller
		Dado que eu faça uma substituição dos dados de comissão usando o id para um seller sem comissão
		Então será retornado código "204"
		E as comissões serão inseridas

	@create_seller
	Cenário: Enviar uma comissão em branco usado a rota por id do seller
		Dado que eu faça uma substituição sem colocar valores novos de comissão usando o id do seller
	    Então será retornado código "400" e "message" seja "Unable to process JSON"
