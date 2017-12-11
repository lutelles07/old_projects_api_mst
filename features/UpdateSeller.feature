# language: pt

@done
Funcionalidade: Atualizar dados do Seller no componente MST
	Para manter os dados do seller atualizados
	Como outros sistemas integrados
	Quero atualizar os dados de um seller

	@ready
	@create_seller @createQueue
	Cenário: Atualizar dados do seller
		Dado que eu atualize os dados de um seller usando o id
		Então será retornado código "204"
		E será possível ver os dados atualizados
		E será possível ver que a privacidade de email se mantém inalterada
	    E será postado uma mensagem na fila com o id do seller

	# @remove
	# @create_seller @createQueue
	# Cenário: Atualizar o status de ativo do seller
	# 	Dado que eu atualize os dados de active de um seller usando o id
	# 	Então será retornado código "204"
	# 	E será possível ver os dados de ativação atualizados
	#     E será postado uma mensagem na fila com o id do seller


	@ready
	@create_seller @createQueue
	Cenário: Atualizar o status de privacidade de email do seller
		Dado que eu atualize os dados de privacidade de email de um seller usando o TrackingId
		Então será retornado código "204"
		E será possível ver os dados de privacidade de email atualizados
	    E será postado uma mensagem na fila com o id do seller

	@ready
	Cenário: Atualizar o status de privacidade de email do seller inexistente
		Dado que eu atualize os dados de privacidade de email de um seller usando o TrackingId inexistente
		Então será retornado código "404"

	@ready
  @create_seller
	@atualizar
 	Cenário: Atualizar campo integrated do seller
 		Dado que eu atualize os dados de integrated de um seller usando o trackingId e alterando a flag para "false"
 		Então será retornado código "204"
 		E será possível ver os dados do intregrated atualizados para "false"

 	@create_seller
 	Cenário: Atualizar campo integrated do seller
 		Dado que eu atualize os dados de integrated de um seller usando o trackingId e alterando a flag para "true"
 		Então será retornado código "204"
 		E será possível ver os dados do intregrated atualizados para "true"

 	@create_seller
 	Cenário: Atualizar dados do sem sem o atributo integrationStatus
 		Dado que eu atualize os dados de um seller usando o id sem o atributo statusIntegration
 		Então será retornado código "500"
