# language: pt

Funcionalidade: Gerenciar os dados de políticas do Seller
	Para armazenar e obter os dados de políticas do seller
	Como outros sistemas integrados
	Quero criar e consultar dados de políticas no MST


	@create_seller
	Esquema do Cenário: Cadastrar políticas para seller existente
		Dado que cadastre uma política de <type> com valor válido para um seller usando o ID
		Então será retornado código "201"
		E será possível consultar a politica do seller

	Exemplos:
	|     type    |
	| "DELIVERY"  |
	|  "PRIVACY"  |
	|  "RETURN"   |

	@create_seller
	Esquema do Cenário: Cadastrar políticas com tipos inválidos para um seller existente
		Dado que cadastre uma política de <type> com valor válido para um seller usando o ID
		Então será retornado código "400" e "message" seja "Unable to process JSON"

	Exemplos:
	|     type     |
	| "DELIVERED"  |
	|  "RETURNED"  |


	Cenário: Tentar cadastrar dados de policies sem id do seller
	 	Dado que eu cadastro os dados de policies com o campo de id do seller em branco
	    Então será retornado código "422" e "errors" seja "sellerId may not be null (was null)"

	@create_policies
	Cenário: Tentar cadastrar dados de policies duplicados para o mesmo tipo
	 	Dado que eu cadastro os dados de policies duplicada para o mesmo seller
	    Então será retornado código "500" e "message" seja "Constraint"

	@create_policies
	Cenário: Buscar políticas para seller existente que tenha mais de uma pagina de retorno
		Dado que eu busque políticas existentes
		E eu valide que há mais de uma página de resultado
		E então eu busque uma política da página seguinte
		Então será retornado código "200"
		E será possível consultar a política da página seguinte

	@create_policies
	Cenário: Atualizar os dados de uma polícita de um seller existente
		Dado que eu atualize os dados de uma polícita de um seller
		Então será retornado código "204"
		Então poderei consultar os dados de políticas atualizados