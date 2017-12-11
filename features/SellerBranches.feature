# language: pt
@done
Funcionalidade: Gerenciar os dados de conta do Seller através de Branchs
	Para armazenar e obter os dados de contas do seller
	Como outros sistemas integrados
	Quero criar mais de uma conta atralada ao seller através de Branchs

	@ready @delete_branches
	Cenário: Salvar os dados de contas em uma Branch com dados válidos
		Dado que eu cadastre dados de conta válidos em uma branch para um seller
		Então será retornado código "204"
			E a branch deve estar contida nos dados do Seller

	@ready
	Cenário: Deletar os dados de uma Branch
		Dado que eu tenha obtenha a primeira branch de um seller
		Quando eu solicitar a exclusão da branch
		Então será retornado código "204"
			E a branch deletada não estará mais nos dados de pagamento do seller



	# Cenário: Salvar os dados de contas com dados inválidos
	# 	Dado que eu cadastre os dados de conta inválidos para um seller
	#     Então será retornado código "422" e "errors" seja "bankAgency may not be null (was null)"

# 201	Created
# 204	no content
# 400	bad request
# 401	Unauthorized
# 403	Forbidden
# 404	not found
# 500 internal server error
