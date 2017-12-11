# enconding: utf-8

#=====================================================================================================================
# Steps de Criação de Seller Com Informações do Contrato
#=====================================================================================================================

Dado(/^que eu cadastre um seller e envio os dados do contrato$/) do
	contract = ContractApi.new.get_contract_current()
	@json_seller_contract = SellerContractFactory.create_valid(contract.parsed_response['id'])
	@response = MSTApi.new.create_seller_contract(@json_seller_contract)
	logCleanup(@response)
end

Dado(/^que eu cadastre um seller sem os dados do contrato$/) do
	@json_seller_contract = SellerContractFactory.create_invalid()
	@response_erro = @response = MSTApi.new.create_seller_contract(@json_seller_contract)
	logCleanup(@response)
end

Dado(/^que eu cadastre vairos sellers com o mesmo nome fantasia$/) do
	contract = ContractApi.new.get_contract_current()
	for i in 0..2
		@json_seller_contract = SellerContractFactory.create_sellers_name_fantasy(contract.parsed_response['id'])
  		@response = MSTApi.new.create_seller_contract(@json_seller_contract)
  		logCleanup(@response)
 	end		
end

