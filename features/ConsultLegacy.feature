# language: pt

Funcionalidade: Consultar dados da base da dados legada
	Para dar suporte a informações que ainda não estão totalmente migradas para o MST
	Como outros sistemas integrados
	Quero consultar dados a partir do MST na base de dados legada

	Cenário: Consultar comissão de seller com filtro de melhor comissão
		Dado que eu consulte os dados de comissão passando os dados de categorias e filtro de melhor comissão
		Então será retornado código "200"
		E será retornado apenas valor da comissão com o valor esperado

	Cenário: Consultar comissão de seller que não tenha comissão cadastrada
		Dado que eu consulte os dados de comissão de um seller que não tenha comissões cadastradas
		Então será retornado código "200"
		E será retornado comissão "0"

	Cenário: Consultar comissão de seller que não exista
		Dado que eu consulte os dados de comissão de um seller que não exista
		Então será retornado código "200"
		E será retornado valores de comissão em branco

	Cenário: Consultar dados do seller no WWW5
		Dado que eu consulte os dados de um seller cadastrado no WWW5
		Então será retornado código "200"
		E será retornado dados do seller que estejam cadastrados no WWW5

	Cenário: Consultar dados do seller que não existe no WWW5
		Dado que eu consulte os dados de um seller que não existe no WWW5 por sellerKey
		Então será retornado código "404"

	Cenário: Consultar todas as comissões cadastradas para um seller no WWW5
		Dado que eu consulte a comissões cadastradas de um seller por sellerKey
		Então será retornado código "200"
		E será retornado todas as comissões negociadas por esse seller
		E será retornado dados do seller
		E será retornado a comissão padrão do seller


	Cenário: Consultar dados do seller que não existe nem no WWW5 e nem no MST
		Dado que eu consulte os dados de um seller por sellerKey que não exista no WWW5 e no MST
		Então será retornado código "404"

	Cenário: Consultar todas as comissões cadastradas para um seller no WWW5 por cnpj
		Dado que eu consulte a comissões cadastradas de um seller por cnpj
		Então será retornado código "200"
		E será retornado todas as comissões negociadas por esse seller
		E será retornado dados do seller
		E será retornado a comissão padrão do seller

	Cenário: Consultar dados do seller que não existe nem no WWW5 e nem no MST por cnpj
		Dado que eu consulte os dados de um seller por cnpj que não exista no WWW5 e no MST
		Então será retornado código "404"
