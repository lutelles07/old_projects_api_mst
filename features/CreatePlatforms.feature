# language: pt

Funcionalidade: Gerenciar os dados de plataformas do Seller
	Para armazenar e obter os dados de plataformas do seller
	Como outros sistemas integrados
	Quero criar e consultar dados de plataformas no MST

	@create_seller
	Cenário: Salvar os dados de plataforma apenas com campos obrigatórios
		Dado que eu cadastro os dados de plataforma apenas com os campo obrigatorios para um seller
		Então será retornado código "201"
		E será possível consultar os dados de plataforma

	Cenário: Salvar os dados de plataforma com dados inválidos
		Dado que eu cadastre os dados de plataforma inválidos para um seller
	    Então será retornado código "422" e "errors" seja "domain may not be null (was null)"

	Cenário: Tentar cadastrar dados de plataforma sem id do seller
	 	Dado que eu cadastro os dados de plataforma com o campo de id do seller em branco
	    Então será retornado código "422" e "errors" seja "sellerId may not be null (was null)"

	
	@create_platform
	Cenário: Buscar os dados de plataforma pelo id da plataforma
		Dado que eu busque os dados de plataforma usando o id da plataforma de um seller
		Então será retornado código "200"
		E será possível consultar os dados de plataforma

	Cenário: Buscar dados de plataforma tenha mais de uma pagina de retorno
		Dado que eu busque os dados de plataforma de todos os sellers
		E eu valide que há mais de uma página de resultado
		E então eu busque dados de plataforma da página seguinte
		Então será retornado código "200"
		E será possível consultar as plataformas cadastradas

	
	@create_platform
	Cenário: Atualizar dados de plataforma de um seller
		Dado que eu atualize os dados de plataforma de um seller
		Então será retornado código "204"
		E será possível consultar os dados de plataforma atualizados desse seller

	
	@create_seller
	Cenário: Cadastrar plataformas com mais de uma plataforma endpoint
		Dado que eu cadastre os dados de plataforma de um seller com dois endpoints diferentes
		Então será retornado código "201"
		E será possível consultar os dados dos endpoints dessa plataforma
