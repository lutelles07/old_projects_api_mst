Dado(/^que eu atualize os dados de todas as API's desse seller pelo TrackingId para valores válidos$/) do
	@response = @response_base if @response.parsed_response == nil
	@response_base = MSTApi.new.get_seller(@response.parsed_response['id'])
	json_seller = SELLER_COMPLETE

	@response = MSTApi.new.update_all_seller(@response_base.parsed_response['trackingId'], json_seller)
end

Então(/^eu poderei consultar todas as API's pela rota do seller$/) do
	@response_all = MSTApi.new.get_seller_by_tracking_id(@response_base.parsed_response['trackingId'])
	puts @response_all.parsed_response if DEBUG
end

Então(/^eu poderei consultar os dados na API de commissão$/) do
	expect(@response_all.parsed_response['commissions'][0]).to be(nil)
end

Então(/^eu poderei consultar os dados na API de políticas$/) do
	response = MSTApi.new.get_policies(@response_all.parsed_response['policies'][0]['id'])
	expect(response.code).to be(200)
end

Então(/^eu poderei consultar os dados na API de plataformas$/) do
	response = MSTApi.new.get_platform(@response_all.parsed_response['platforms'][0]['id'])
	expect(response.code).to be(200)
end

Então(/^eu poderei consultar os dados na API de contas$/) do
	response = MSTApi.new.get_account(@response_all.parsed_response['accounts'][0]['id'])
	expect(response.code).to be(200)
end

Dado(/^que eu atualize os dados desse seller usando o TrackingId sem enviar as comissões$/) do
	@response_base = MSTApi.new.get_seller(@response.parsed_response['id'])
	json_seller = SELLER_COMPLETE
	json_seller.delete('commissions')

	@response = MSTApi.new.update_all_seller(@response_base.parsed_response['trackingId'], json_seller)end

Então(/^os valores de comissão não serão alterados/) do
	@response_all = MSTApi.new.get_seller_by_tracking_id(@response_base.parsed_response['trackingId'])
	response = MSTApi.new.get_commission(@response_all.parsed_response['commissions'][0]['id'])
	expect(response.code).to be(200)
end

Dado(/^que eu atualize o status do seller de "([^"]*)" para "([^"]*)"$/) do |status_before, status_after|
	@response_base = MSTApi.new.get_seller(@response.parsed_response['id'])
	expect(@response_base.parsed_response['status']).to eq(status_before)
	json_update = { "status" => status_after }

	@response = MSTApi.new.update_status_seller(@response_base.parsed_response['trackingId'], json_update)
end

Então(/^ao consultar o status do seller ele será "([^"]*)"$/) do |status_after|
	response = MSTApi.new.get_seller(@response_base.parsed_response['id'])
	expect(response.parsed_response['status']).to eq(status_after)
end

Dado(/^que eu atualize o status do seller para um status inexistente$/) do
	@response_base = MSTApi.new.get_seller(@response.parsed_response['id'])
	json_update = { "status" => "valor inexistente" }

	@response = MSTApi.new.update_status_seller(@response_base.parsed_response['trackingId'], json_update)
	puts @response if DEBUG
end

Dado(/^que eu altere o status de integração do seller para "([^"]*)"$/) do |invalidIntegrationStatus|
	seller = MSTApi.new.get_seller(@response.parsed_response['id'])

	if invalidIntegrationStatus == "null"
		json_update = { "integrationStatus" => nil, "tradingName" => seller['tradingName'] }
	else
		json_update = { "integrationStatus" => invalidIntegrationStatus}
	end

	@response = MSTApi.new.update_all_seller(seller['trackingId'], json_update)
end