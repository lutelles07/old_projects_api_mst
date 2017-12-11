# enconding: utf-8

#=====================================================================================================================
# Steps de Update na API de Seller
#=====================================================================================================================
Dado (/^que eu atualize os dados de active de um seller usando o id$/) do
	binding.pry
	@response_base = MSTApi.new.get_seller(@response.parsed_response['id'])
	@response = MSTApi.new.update_active_seller(@response_base.parsed_response['id'], true)
end

Dado(/^que eu atualize os dados de um seller usando o id$/) do
    @response_base = MSTApi.new.get_seller(@response.parsed_response['id'])
    json_seller = (@response_base.parsed_response).dup
    json_seller['contact']['firstName'] = 'Up-'+ json_seller['contact']['firstName']
    json_seller['address']['lineOne'] = 'Up-' + json_seller['address']['lineOne']
    json_seller['address']['postalCode'] = '99999999'
    json_seller['companyName'] = 'Updated' + json_seller['companyName']
    json_seller.delete('commissions')
    json_seller.delete('createdAt')
    json_seller.delete('updatedAt')
    json_seller.delete('id')
    json_seller.delete('trackingId')

    puts "Json do seller: " if DEBUG
    puts @response_base if DEBUG
    puts "Json do update: " if DEBUG
    puts json_seller.to_json if DEBUG

	@response = MSTApi.new.update_seller(@response_base.parsed_response['id'], json_seller)
end

Dado(/^que eu faça uma atualização enviando os dados de comissão usando o trackingId para um seller inexistente$/) do
    @response = MSTApi.new.update_seller('nil', nil)
end

Dado (/^que eu atualize os dados de privacidade de email de um seller usando o TrackingId$/) do
    @response_base = MSTApi.new.get_seller(@response.parsed_response['id'])
    object = {:enabled => false}
    puts object if DEBUG
    @response = MSTApi.new.update_email_privacy_enabled(@response_base.parsed_response['trackingId'], object)
end

Dado(/^que eu atualize os dados de privacidade de email de um seller usando o TrackingId inexistente$/) do
  object = {:enabled => false}
  @response = MSTApi.new.update_email_privacy_enabled('trackingIdInexistente', object)
end

Dado(/^que eu atualize os dados de integrated de um seller usando o trackingId e alterando a flag para "([^"]*)"$/) do |flag|
    @response_base = MSTApi.new.get_seller(@response.parsed_response['id'])
    puts @response_base if DEBUG
    @response = MSTApi.new.update_integrated(@response_base.parsed_response['trackingId'], flag)
end

#=====================================================================================================================

#=====================================================================================================================
# Steps de Assertations de Update na API de Seller
#=====================================================================================================================
Então(/^será possível ver os dados atualizados$/) do
	response = MSTApi.new.get_seller(@response_base.parsed_response['id'])

	expect(response.parsed_response['contact']["firstName"]).to include("Up")
    expect(response.parsed_response['address']['lineOne']).to include('Up')
    expect(response.parsed_response['address']['postalCode']).to include('99999999')
    expect(response.parsed_response['companyName']).to include('Updated')
end

Então(/^será possível ver que a privacidade de email se mantém inalterada$/) do
    response = MSTApi.new.get_seller(@response_base.parsed_response['id'])

    expect(response.parsed_response['emailPrivacyEnabled']).to be(true)
end

Então(/^será possível ver os dados de ativação atualizados$/) do
	response = MSTApi.new.get_seller(@response_base.parsed_response['id'])
	expect(@response_base.parsed_response['active']).to_not equal(response.parsed_response['active'])
end

Então(/^será possível ver os dados de privacidade de email atualizados$/) do
    response = MSTApi.new.get_seller_by_tracking_id(@response_base.parsed_response['trackingId'])
    expect(response.parsed_response['emailPrivacyEnabled']).to be(false)
end

Então(/^será possível ver os dados do intregrated atualizados para "([^"]*)"$/) do |flag|
    response = MSTApi.new.get_seller(@response_base.parsed_response['id'])
    expect(response.parsed_response['integrated'].to_s).to eq(flag)
end

Dado(/^que eu atualize os dados de um seller usando o id sem o atributo statusIntegration$/) do
    @response_base = MSTApi.new.get_seller(@response.parsed_response['id'])
    @response_base.delete('integrationStatus')
    @response = MSTApi.new.update_seller(@response.parsed_response['id'], @response_base)
end
#=====================================================================================================================
