# language: pt

@done
Funcionalidade: Buscar dados de pagamento do Seller no componente MST
	Para saber as informações de pagamento de um Seller
	Quero buscar as informações de endereço e conta de pagamento de um seller

	@ready
	Cenário: Buscar dados de pagamento do Seller a partir do ID
	    Dado que eu procure os dados de pagamento de um seller usando o ID
	    Então será retornado código "200"
				E o campo "address" possua valor
				E o campo "account" possua valor
