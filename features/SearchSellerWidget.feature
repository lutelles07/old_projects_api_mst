# language: pt

@done
Funcionalidade: Buscar Widget de Seller no componente MST
	Para utilizar os dados de um seller em algum fluxo
	Como outros sistemas integrados
	Quero buscar os dados principais apenas de um seller

	@ready
	@create_seller @policies
	Cenário: Buscar o widget do seller e validar que existem todas as informações principais
		Dado que eu procure o widget do seller usando o TrackingID
		Então será retornado código "200"
		E eu verei todos os dados do json de widget do seller preenchidos

	@ready
	@create_seller @policies
	Cenário: Buscar o widget do seller e validar que existem todas as informações principais
		Dado que eu procure o widget do seller usando o ID
		Então será retornado código "200"
		E eu verei todos os dados do json de widget do seller preenchidos
