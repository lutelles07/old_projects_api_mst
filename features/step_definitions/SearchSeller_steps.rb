# enconding: utf-8

#=====================================================================================================================
# Steps de Search na API de Seller
#=====================================================================================================================
Dado(/^que eu procure o seller pela rota de pesquisa usando o ID$/) do
	puts @response.parsed_response['id'] if DEBUG
	@response = MSTApi.new.get_seller(@response.parsed_response['id'])
	puts @response if DEBUG
end

Dado(/^que eu procure o seller pela rota de pesquisa usando o ID inexistente$/) do
	@response = MSTApi.new.get_seller(Time.now.to_i.to_s+rand(9999999999999).to_s)
end

Dado(/^que eu procure o seller pela de todos os sellers$/) do
	@response = MSTApi.new.get_seller
end

Dado(/^que eu busque uma lista de seller pelo campo integrated com status "([^"]*)"$/) do |flag|
	@response_base = MSTApi.new.get_seller(@response.parsed_response['id'])
	@response = MSTApi.new.get_integrated(flag)
end

Dado(/^que eu busque uma lista de seller pelo campo emailPrivacyEnabled com status "([^"]*)"$/) do |flag|
  	@response_base = MSTApi.new.get_seller(@response.parsed_response['id'])
  	@response = MSTApi.new.get_emailPrivacyEnabled(flag)
end

#=====================================================================================================================



#=====================================================================================================================
# Steps de Assertations de Search na API de Seller
#=====================================================================================================================
Então(/^eu verei todos os dados do json do seller preenchidos$/) do
	response = MSTApi.new.get_seller(@response.parsed_response['id'])
	expect(response.code).to eq(200)
	expect(response.parsed_response['tradingName']).to include("umst")
	expect(response.parsed_response['contact']["firstName"]).to include("Automatic")
	expect(response.parsed_response['address']['lineOne']).to_not be_nil
end

Então(/^será possível ver os dados do seller e o campo "([^"]*)" como "([^"]*)"$/) do |campo, valor|
	#binding.pry
	items =	@response['items']
	items.each do |item|
		expect(item[campo].to_s).to eq valor
	end
end

#=====================================================================================================================
