# language: pt
@done
Funcionalidade: Gerenciar comissões no cadastro do Seller no componente MST
	Para Gerenciar os dados de comissão de um seller
	Como outros sistemas integrados
	Quero adicionar e buscar comissões de um seller


	@create_seller
	Esquema do Cenário: Cadastrar comissão para seller existente
		Dado que cadastre uma comissão de <type> com id <trackingId> e comissão <commisions> para um seller usando o ID
		Então será retornado código <codigo>
		E será possível consultar a comissão com valor <commisions> do seller

	Exemplos:
	|    type    | trackingId | commisions | codigo |
	| "CATEGORY" |   "125"    |   "1200"   |  "201" |
	| "FREIGHT"  |   "125"    |   "1600"   |  "201" |
	| "DEFAULTS" |	 "125"    |   "1600"   |  "201" |

	@create_seller
	Esquema do Cenário: Cadastrar comissão com valores inválidos para um seller existente
		Dado que cadastre uma comissão de <type> com id <trackingId> e comissão <commisions> para um seller usando o ID
		Então será retornado código <codigo> e "message" seja "Unable to process JSON"

	Exemplos:
	|    type    | trackingId | commisions | codigo |
	| "DEFAULT"  |   "125"    |   "2000"   |  "400" |
	| "CATEGORY" |	 "abc"    |   "abc"    |  "400" |