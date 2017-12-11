Dado(/^que cadastre uma política de "([^"]*)" com valor válido para um seller usando o ID$/) do |type|
  json_policies = POLICIES_JSON['policies'].dup
  json_policies['sellerId'] = @response.parsed_response['id']
  json_policies['type'] = type

  @response = MSTApi.new.create_policies(json_policies)
end

Dado(/^que eu cadastro os dados de policies com o campo de id do seller em branco$/) do
  json_policies = POLICIES_JSON['policies'].dup

  @response = MSTApi.new.create_policies(json_policies)
end

Dado(/^que eu cadastro os dados de policies duplicada para o mesmo seller$/) do
  json_policies = POLICIES_JSON['policies'].dup
  json_policies['sellerId'] = @response.parsed_response['id']

  @response = MSTApi.new.create_policies(json_policies)
end

Dado(/^que eu busque políticas existentes$/) do
  @response = MSTApi.new.get_policies()
end

Dado(/^então eu busque uma política da página seguinte$/) do
  expect(@response.parsed_response['items'][0]).not_to be nil
  expect(@response.parsed_response['items'][1]).not_to be nil
end

Então(/^será possível consultar a política da página seguinte$/) do
  search = "&page=#{@response.parsed_response['meta']['page']+1}"
  @response = MSTApi.new.get_policies_search(search)
end

Então(/^será possível consultar a politica do seller$/) do
  response = MSTApi.new.get_policies(@response.parsed_response['id'])
  expect(response.code).to eq(200)
  expect(response.parsed_response['value']).to eq(POLICIES_JSON['policies']['value'])
end

Dado(/^que eu atualize os dados de uma polícita de um seller$/) do
  json_policies = MSTApi.new.get_policies(@response.parsed_response['id'])
  json_policies['value'] = 'UpdateTestAutomatic'
  json_policies.delete('id')
  json_policies.delete('created_at')
  @response_base = @response
  @response = MSTApi.new.update_policies(@response.parsed_response['id'], json_policies)
end

Então(/^poderei consultar os dados de políticas atualizados$/) do
  response = MSTApi.new.get_policies(@response_base.parsed_response['id'])
  expect(response.code).to eq(200)
  expect(response.parsed_response['value']).to eq('UpdateTestAutomatic')
end