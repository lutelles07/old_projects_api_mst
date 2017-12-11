# enconding: utf-8

#=============================================================================================
# Steps da API de Commissions
#=============================================================================================
Dado(/^que cadastre uma comissão de "([^"]*)" com id "([^"]*)" e comissão "([^"]*)" para um seller usando o ID$/) do |type, trackingId, commission|
	@sellerId = @response.parsed_response['id']
	json_seller = COMMISSION_JSON['commission_basic'].dup
	json_seller['trackingId'] = trackingId
	json_seller['type'] = type
	json_seller['value'] = commission
	json_seller['sellerId'] = @sellerId
	@response = MSTApi.new.create_commission(@sellerId, json_seller)
end


Então(/^será possível consultar a comissão com valor "([^"]*)" do seller$/) do |valueCommission|
	response = MSTApi.new.get_commission(@response.parsed_response['id'])
	expect(response.code).to eq(200) 
	expect(response.parsed_response['sellerId']).to eq(@sellerId)
	expect(response.parsed_response['value'].to_i).to eq(valueCommission.to_i)
end
#=============================================================================================



#=============================================================================================
# Steps de Search da API de Commissions
#=============================================================================================
Dado(/^que eu busque uma comissão usando o filtro de sellerId$/) do
	@sellerId = @response.parsed_response['id']
	search = "&sellerId=#{@sellerId}"
	@response = MSTApi.new.get_commission_search(search)
end

Dado(/^que eu busque uma comissão usando o filtro de trackingID$/) do
	@sellerId = @response.parsed_response['id']
	response = MSTApi.new.get_seller(@sellerId)
 
	search = "&trackingId=#{@response.parsed_response['trackingId']}"
	@response = MSTApi.new.get_commission_search(search)
end

Dado(/^que eu busque uma comissão usando o filtro de ordenação por "([^"]*)" em ordem "([^"]*)"$/) do |campo,order|
	case order
		when 'decrescente' then order=-1
		when 'crescente' then order=1
	end

	search = "&sortOrder=1&orderBy=#{campo}&limit=250"
	@response = MSTApi.new.get_commission_search(search)
end

Dado(/^então eu busque uma comissão da página seguinte$/) do
	search = "&sellerId=#{@sellerId}&page=#{@response.parsed_response['meta']['page']+1}"
	@response = MSTApi.new.get_commission_search(search)
end

Dado(/^que eu busque comissões usando o limite de "([^"]*)" resultados por página$/) do |limit|
	search = "&limit=#{limit}"
	@response = MSTApi.new.get_commission_search(search)
end

Dado(/^que eu busque uma comissão usando o filtro de tipo "([^"]*)"$/) do |type|
	search = "&type=#{type}"
	@response = MSTApi.new.get_commission_search(search)
end
#=============================================================================================



#=============================================================================================
# Steps de Assertations da API de Commissions
#=============================================================================================
Então(/^será possível consultar a comissão apenas desse seller$/) do
	expect(@response.parsed_response['items'][0]['sellerId']).to be(@sellerId)
	expect(@response.parsed_response['items'][1]['sellerId']).to be(@sellerId)
end

Dado(/^eu valide que há mais de uma página de resultado$/) do
	expect(@response.parsed_response['meta']['totalPages']).not_to eq(1||0)
end

Então(/^será possível consultar a comissão da página seguinte$/) do
	expect(@response.parsed_response['items'][0]['sellerId']).to be(@sellerId)
	expect(@response.parsed_response['items'][1]['sellerId']).to be(@sellerId)
end

Então(/^será possível consultar a comissão por "([^"]*)" em ordem "([^"]*)"$/) do |campo,order|
	case order
		when 'decrescente'
			expect(@response.parsed_response['items'][0][campo]).to be > @response.parsed_response['items'][200][campo].to_i
		when 'crescente'
			expect(@response.parsed_response['items'][0][campo]).to be < @response.parsed_response['items'][200][campo].to_i
	end
end

Então(/^será possível encontrar apenas "([^"]*)" comissões$/) do |limit|
	expect(@response.parsed_response['items'].length).to be(limit.to_i)
end

Então(/^será possível encontrar apenas comissão do tipo "([^"]*)" no resultado$/) do |type|
	@response.parsed_response['items'].each do |value|
		expect(value['type']).to eq(type)
	end
end
#=============================================================================================
