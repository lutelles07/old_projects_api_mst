# language: pt

Funcionalidade: Gerenciar busca de comissões
	Para Buscar os dados de comissão de um seller
	Como outros sistemas integrados
	Quero buscar comissões de um seller usando ou não filtros de pesquisa

	@create_seller_all
	Cenário: Buscar comissão para seller existente usando filtro de ID
		Dado que eu busque uma comissão usando o filtro de sellerId
		Então será retornado código "200"
		E será possível consultar a comissão apenas desse seller

	@create_seller_all
	Cenário: Buscar comissão para seller existente que tenha mais de uma pagina de retorno
		Dado que eu busque uma comissão usando o filtro de sellerId
		E eu valide que há mais de uma página de resultado
		E então eu busque uma comissão da página seguinte
		Então será retornado código "200"
		E será possível consultar a comissão da página seguinte

	@create_seller_all
	Cenário: Buscar comissão para seller existente usando filtro de TrackingID
		Dado que eu busque uma comissão usando o filtro de trackingID
		Então será retornado código "200"
		E será possível consultar a comissão apenas desse seller

	Cenário: Ordenar resultado de busca de comissão com ordenação crescente
		Dado que eu busque uma comissão usando o filtro de ordenação por "seller" em ordem "crescente"
		Então será retornado código "200"
		E será possível consultar a comissão por "sellerId" em ordem "crescente"

	Cenário: Ordenar resultado de busca de comissão com ordenação decrescente
		Dado que eu busque uma comissão usando o filtro de ordenação por "seller" em ordem "decrescente"
		Então será retornado código "200"
		E será possível consultar a comissão por "sellerId" em ordem "crescente"

	Cenário: Ordenar resultado de busca de comissão usando uma limite de resultados
		Dado que eu busque comissões usando o limite de "30" resultados por página
		Então será retornado código "200"
		E será possível encontrar apenas "30" comissões

	Esquema do Cenário: Ordenar resultado de busca de comissão usando uma limite de resultados
		Dado que eu busque uma comissão usando o filtro de tipo <type>
		Então será retornado código "200"
		E será possível encontrar apenas comissão do tipo <type> no resultado

		Exemplos:
		|     type    |
		|  "CATEGORY" |
		|  "DEFAULTS" |
		|  "FREIGHT"  |