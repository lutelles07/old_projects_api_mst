# language: pt

Funcionalidade: Atuaizar os dados de todas as API's de um seller em um única rota
	Para facilitar o processo de atualzação de dados do seller
	Como outros sistemas integrados
	Quero atualizar os dados de todas as API's de seller em uma única rota usando o trackingId

	@ready
	@createQueue
		@test
	Cenário: Atualizar seller de dados básicos para dados completos de toda as API's
	    Dado que eu cadastre um seller através da API MST com os dados completo
		E seja retornado código "201"
		E que eu atualize os dados de todas as API's desse seller pelo TrackingId para valores válidos
		Então será retornado código "204"
		E eu poderei consultar todas as API's pela rota do seller
#		E eu poderei consultar os dados na API de commissão
#		E eu poderei consultar os dados na API de políticas
#		E eu poderei consultar os dados na API de plataformas
#		E eu poderei consultar os dados na API de contas
	    E será postado uma mensagem na fila com o id do seller


	@ready
	@create_seller
	Cenário: Atualizar status do seller para status inexistente
		Dado que eu atualize o status do seller para um status inexistente
	    Então será retornado código "422"

	@ready
	Cenário: Validar que campo Integrated não é sobrescrito em update por trackingId
	    Dado que eu cadastre um seller através da API MST com os dados completo
		E seja retornado código "201"
		E que eu atualize os dados de integrated de um seller usando o trackingId e alterando a flag para "true"
 		E seja retornado código "204"
		E que eu atualize os dados de todas as API's desse seller pelo TrackingId para valores válidos
		Então será retornado código "204"
 		E será possível ver os dados do intregrated atualizados para "true"


 	@ready
 	Cenário: Validar que campo EmailPrivacyEnable não é sobrescrito em update por trackingId
	    Dado que eu cadastre um seller através da API MST com os dados completo
		E seja retornado código "201"
		E que eu atualize os dados de privacidade de email de um seller usando o TrackingId
 		E seja retornado código "204"
		E que eu atualize os dados de todas as API's desse seller pelo TrackingId para valores válidos
		Então será retornado código "204"
 		E será possível ver os dados de privacidade de email atualizados

	@create_seller
 	Esquema do Cenário: Validar que campo IntegrationStatus não seja atualizado por valores inválidos
 		Dado que eu altere o status de integração do seller para <invalidType>
		Então será retornado código <statusCode>

	Exemplos:
	|  invalidType  |    statusCode  |
	|  "PENDING"    |     "400"      |
	|  "INTEGRATED" |     "400"      |
	|  ""           |     "400"      |
	|  "null"       |     "204"      |
