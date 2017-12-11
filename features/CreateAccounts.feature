# language: pt
@done
Funcionalidade: Gerenciar os dados de conta do Seller
	Para armazenar e obter os dados de conta do seller
	Como outros sistemas integrados
	Quero criar e consultar dados de contas no MST


	@create_seller
	Cenário: Salvar os dados de contas apenas com campos obrigatórios
		Dado que eu cadastro os dados de conta apenas com os campo obrigatórios para um seller
		Então será retornado código "201"
		E será possível consultar os dados de conta desse seller

	@create_seller
	Cenário: Salvar os dados de contas com dados válidos
		Dado que eu cadastre dados de conta válidos para um seller
		Então será retornado código "201"
		E será possível consultar os dados de conta desse seller


	Cenário: Salvar os dados de contas com dados inválidos
		Dado que eu cadastre os dados de conta inválidos para um seller
	    Então será retornado código "422" e "errors" seja "bankAgency may not be null (was null)"


	Cenário: Tentar cadastrar dados de conta sem id do seller
	 	Dado que eu cadastro os dados de conta com o campo de id do seller em branco
	    Então será retornado código "422" e "errors" seja "sellerId may not be null (was null)"

	@create_account
	Cenário: Buscar os dados de contas de um seller por sellerkey
		Dado que eu busque os dados de conta usando o id da conta de um seller
		Então será retornado código "200"
		E será possível consultar os dados de conta desse seller


	Cenário: Buscar dados de conta tenha mais de uma pagina de retorno
		Dado que eu busque os dados de conta de todos os sellers
		E eu valide que há mais de uma página de resultado
		E então eu busque dados de conta da página seguinte
		Então será retornado código "200"
		E será possível consultar os dados de contas

	
	@create_account
	Cenário: Atualizar dados de contas de um seller
		Dado que eu atualize os dados de conta de um seller
		Então será retornado código "204"
		E será possível consultar os dados de conta atualizados desse seller

