# enconding: utf-8

#=============================================================================================
# Steps de Replace da API de seller
#=============================================================================================
Dado(/^que eu faça uma substituição dos dados de comissão usando o id de um seller$/) do
	@seller = MSTApi.new.get_seller(@response.parsed_response['id'])
	puts @seller['trackingId'] if DEBUG
	json_commissions = SELLER_JSON['seller_commissions'].dup
	@response = MSTApi.new.replace_commissions(@seller['trackingId'], json_commissions)
end

Dado(/^que eu faça uma substituição dos dados de comissão usando o id para um seller sem comissão$/) do
	@seller = MSTApi.new.get_seller(@response.parsed_response['id'])
	puts @seller['trackingId'] if DEBUG
	json_commissions = SELLER_JSON['seller_commissions'].dup
	@response = MSTApi.new.replace_commissions(@seller['trackingId'], json_commissions)
end

Dado(/^que eu faça uma substituição sem colocar valores novos de comissão usando o id do seller$/) do
	@seller = MSTApi.new.get_seller(@response.parsed_response['id'])
	puts @seller['trackingId'] if DEBUG
	json_commissions = '{}'
	@response = MSTApi.new.replace_commissions(@seller['trackingId'], json_commissions)
end
#=============================================================================================



#=============================================================================================
# Steps de validação da API de seller
#=============================================================================================
Então(/^as comissões serão inseridas$/) do
	response = MSTApi.new.get_seller_by_tracking_id(@seller['trackingId'])
	expect(response.code).to be(200)
	puts response if DEBUG
	expect(response.parsed_response['commissions'][0]['trackingId']).not_to be nil
end
#=============================================================================================