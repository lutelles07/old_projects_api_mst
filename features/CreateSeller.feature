# language: pt

@done
Funcionalidade: Cadastrar Seller no componente MST
	Para centralizar os dados do seller em uma única API
	Como outros sistemas integrados
	Quero cadastrar os dados de um seller

	@ready
	@integrado @createQueue @eu
	Cenário: Realizar cadastro do Seller com todos os dados preenchidos
	    Dado que eu cadastre um seller através da API MST com os dados completo
	    Então o seller será corretamente cadastrado
	    Então o seller terá privacidade de email ativa
	    E passará a ser possível consultá-lo na API MST
	    E passará a ser possível consultá-lo na API Stargate
	    E será postado uma mensagem na fila com o id do seller

	@ready
	Cenário: Realizar cadastro do Seller com dados básicos incluindo os dados de contato
	    Dado que eu cadastre um seller através da API MST com os dados de contato
#	    Então será retornado código "500" e "message" seja "Required field"
	    Então será retornado código "422" e "errors" seja "REQUIRED"

	@ready
		@errordecoder
	Cenário: Cadastrar seller duplicado
		Dado que eu cadastre um seller através da API MST com os dados completo
		E eu tente cadastrar o mesmo seller novamente
#	    Então será retornado código "500" e "message" seja "ConstraintViolationException"
	    Então será retornado código "422" e "errors" seja "DUPLICATED"

	@ready
	Cenário: Cadastrar seller com campos obrigatórios vazios
		Dado que eu cadastre um seller através da API MST com os dados vazio
#		Então será retornado código "422" e "errors" seja "tradingName may not be empty (was null)"
		Então será retornado código "422" e "errors" seja "may not be empty"

	Cenário: Realizar cadastro do Seller com a comissão de uma categoria
	    Dado que eu cadastre um seller através da API MST com uma comissão de categoria
	    Então o seller será corretamente cadastrado
	    E passará a ser possível consultar a comissão de "CATEGORY" na busca do seller na API MST

	Cenário: Realizar cadastro do Seller com a comissão de duas categoria
	    Dado que eu cadastre um seller através da API MST com várias comissões de categoria
	    Então o seller será corretamente cadastrado
	    E passará a ser possível consultar a comissão de "CATEGORY" na busca do seller na API MST

	Cenário: Realizar cadastro do Seller com a comissão de uma categoria e um frete de ids iguais
	    Dado que eu cadastre um seller através da API MST com uma comissão de "CATEGORY" e uma de "FREIGHT" com id "43"
	    Então o seller será corretamente cadastrado
	    E passará a ser possível consultar a comissão de "CATEGORY" e "FREIGHT" na busca do seller na API MST

	Cenário: Realizar cadastro do Seller com a comissão de uma categoria e um frete de ids diferentes
	    Dado que eu cadastre um seller através da API MST com uma comissão de "CATEGORY" e uma de "FREIGHT" com id diferente
	    Então o seller será corretamente cadastrado
	    E passará a ser possível consultar a comissão de "CATEGORY" e "FREIGHT" na busca do seller na API MST

	Cenário: Realizar cadastro do Seller com a comissão padrão e uma de frete de ids diferentes
	    Dado que eu cadastre um seller através da API MST com uma comissão de "DEFAULTS" e uma de "FREIGHT" com id diferente
	    Então o seller será corretamente cadastrado
	    E passará a ser possível consultar a comissão de "DEFAULTS" e "FREIGHT" na busca do seller na API MST

	Cenário: Realizar cadastro do Seller com a comissão de um frete
	    Dado que eu cadastre um seller através da API MST com uma comissão de frete
	    Então o seller será corretamente cadastrado
	    E passará a ser possível consultar a comissão de "FREIGHT" na busca do seller na API MST

	Cenário: Realizar cadastro do Seller com a comissão de dois fretes
	    Dado que eu cadastre um seller através da API MST com várias comissões de frete
	    Então o seller será corretamente cadastrado
	    E passará a ser possível consultar a comissão de "FREIGHT" na busca do seller na API MST

	Cenário: Realizar cadastro do Seller com multiplas comissões
	    Dado que eu cadastre um seller através da API MST múltiplas comissões
	    Então o seller será corretamente cadastrado
	    E passará a ser possível consultar comissões na busca do seller na API MST

	Cenário: Realizar cadastro do Seller com a comissão de dois fretes iguais
	    Dado que eu cadastre um seller através da API MST com duas comissões de "FREIGHT" e id "123"
#		Então será retornado código "500" e "message" seja "ConstraintViolationException"
		Então será retornado código "422" e "message" seja "ConstraintViolationException"

	Cenário: Realizar cadastro do Seller com a comissão de duas categorias iguais
	    Dado que eu cadastre um seller através da API MST com duas comissões de "CATEGORY" e id "123"
		Então será retornado código "422" e "message" seja "ConstraintViolationException"

	Cenário: Realizar cadastro do Seller com a comissão de um tipo inválido
	    Dado que eu cadastre um seller através da API MST com uma comissão de "INVALID"
		Então será retornado código "400" e "message" seja "Unable to process JSON"

	Cenário: Realizar cadastro do Seller com a comissão de um tipo inválido e um tipo válido
	    Dado que eu cadastre um seller através da API MST com uma comissão de "INVALID" e uma de "FREIGHT" com id "43"
		Então será retornado código "400" e "message" seja "Unable to process JSON"

	@test
	@ready
	Cenário: Realizar cadastro de seller com valor duplicado no trackingID
		Dado que eu cadastre um seller através da API MST com o trackingID duplicado
		Então será retornado código "422" e "message" seja "ConstraintViolationException"

	@test
	@ready
	Cenário: Realizar cadastro do Seller e verificar seu status de integração
		Dado que eu cadastre um seller através da API MST com os dados completo
		Então o seller será corretamente cadastrado
		E o seller cadastrado deverá estar com o status de integração como "INTEGRATING"
