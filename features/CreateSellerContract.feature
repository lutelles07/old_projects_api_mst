# language: pt

Funcionalidade: Cadastrar Seller no componente com assinatura do contrato MST
	Para centralizar os dados do seller em uma única API
	Como outros sistemas integrados
	Quero cadastrar os dados de um seller com assinatura do contrato

	Cenário: Cadastrar seller com dados básico e assinar contrato atravéz da api do MST
		Dado que eu cadastre um seller e envio os dados do contrato 
		Então será retornado código "201"

	Cenário: Cadastrar seller sem os dados do contrato atravéz da api do MST
		Dado que eu cadastre um seller sem os dados do contrato
		Então será retornado código "422"

	Cenário: Cadastrar varias vezes com o mesmo nome fantasia
		Dado que eu cadastre vairos sellers com o mesmo nome fantasia
		Então será retornado código "201"

	

