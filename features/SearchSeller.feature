# language: pt

@done
Funcionalidade: Buscar Seller no componente MST
	Para utilizar os dados de um seller em algum fluxo
	Como outros sistemas integrados
	Quero buscar os dados de um seller

	@ready
	@create_seller
	Cenário: Buscar cadastro do Seller a partir do ID
	    Dado que eu procure o seller pela rota de pesquisa usando o ID
	    Então será retornado código "200" e "trackingId" seja "testmst"

	@ready
	@create_seller
	Cenário: Buscar cadastro de todos os Sellers
	    Dado que eu procure o seller pela de todos os sellers
	    Então será retornado código "200"

	Cenário: Buscar cadastro do Seller não existente
	    Dado que eu procure o seller pela rota de pesquisa usando o ID inexistente
	    Então será retornado página de "Error 404"

	@ready
	@create_seller_all
	Cenário: Buscar o cadastro do seller e validar que existem todas as informações
		Dado que eu procure o seller pela rota de pesquisa usando o ID
		Então será retornado código "200"
		E eu verei todos os dados do json do seller preenchidos

	@ready
	@create_seller
	Cenário: Busca de seller pelo campo integrated do seller
		Dado que eu busque uma lista de seller pelo campo integrated com status "false"
		Então será retornado código "200"
		E será possível ver os dados do seller e o campo "integrated" como "false"

	@ready
	@create_seller
	Cenário: Busca de seller pelo campo integrated do seller
		Dado que eu busque uma lista de seller pelo campo integrated com status "true"
		Então será retornado código "200"
		E será possível ver os dados do seller e o campo "integrated" como "true"

	@ready
	@create_seller
	Cenário: Busca de seller pelo campo privacidade de email
		Dado que eu busque uma lista de seller pelo campo emailPrivacyEnabled com status "false"
		Então será retornado código "200"
		E será possível ver os dados do seller e o campo "emailPrivacyEnabled" como "false"

	@ready
	@create_seller
	Cenário: Busca de seller pelo campo privacidade de email
		Dado que eu busque uma lista de seller pelo campo emailPrivacyEnabled com status "true"
		Então será retornado código "200"
		E será possível ver os dados do seller e o campo "emailPrivacyEnabled" como "true"
