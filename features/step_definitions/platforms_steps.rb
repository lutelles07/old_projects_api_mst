# enconding: utf-8

#=============================================================================================
# Steps de create/update da API de Platforms
#=============================================================================================
Dado(/^que eu cadastro os dados de plataforma apenas com os campo obrigatorios para um seller$/) do
  json_platform = PLATFORMS_JSON['platforms'].dup
  json_platform['sellerId'] = @response.parsed_response['id']

  @response = MSTApi.new.create_platform(json_platform)
end

Dado(/^que eu cadastre os dados de plataforma inválidos para um seller$/) do
  json_platform = PLATFORMS_JSON['platforms'].dup
  json_platform['sellerId'] = Faker::Number.number(8)
  json_platform['domain'] = nil

  @response = MSTApi.new.create_platform(json_platform)
end

Dado(/^que eu cadastro os dados de plataforma com o campo de id do seller em branco$/) do
  json_platform = PLATFORMS_JSON['platforms'].dup
  json_platform['sellerId'] = nil

  @response = MSTApi.new.create_platform(json_platform)
end

Dado(/^que eu atualize os dados de plataforma de um seller$/) do
  json_platform = PLATFORMS_JSON['platforms'].dup
  json_platform['trackingId'] = 'UpdateTestAutomatic'
  json_platform['sellerId'] = @sellerId
  @response_base = @response
  @response = MSTApi.new.update_platform(@response.parsed_response['id'], json_platform)
end

Dado(/^que eu cadastre os dados de plataforma de um seller com dois endpoints diferentes$/) do
  json_platform = PLATFORMS_JSON['platforms'].dup
  json_platform['sellerId'] = @response.parsed_response['id']
  json_platform['endpoints'] = PLATFORMS_JSON['endpoints'].dup

  @response = MSTApi.new.create_platform(json_platform)
end
#=============================================================================================


#=============================================================================================
# Steps de search da API de Platforms
#=============================================================================================
Dado(/^que eu busque os dados de plataforma usando o id da plataforma de um seller$/) do
  @response = MSTApi.new.get_platform(@response.parsed_response['id'])
end

Dado(/^que eu busque os dados de plataforma de todos os sellers$/) do
  @response = MSTApi.new.get_platform()
end

Dado(/^então eu busque dados de plataforma da página seguinte$/) do
  search = "&page=#{@response.parsed_response['meta']['page']+1}"
  @response = MSTApi.new.get_platform_search(search)
end
#=============================================================================================


#=============================================================================================
# Steps de validations da API de Platforms
#=============================================================================================
Então(/^será possível consultar os dados de plataforma$/) do
  response = MSTApi.new.get_platform(@response.parsed_response['id'])
  expect(response.code).to eq(200)
  expect(response.parsed_response['trackingId']).to eq(PLATFORMS_JSON['platforms']['trackingId'])
end

Então(/^será possível consultar as plataformas cadastradas$/) do
  expect(@response.parsed_response['items'][0]).not_to be nil
  expect(@response.parsed_response['items'][1]).not_to be nil

end

Então(/^será possível consultar os dados de plataforma atualizados desse seller$/) do
  response = MSTApi.new.get_platform(@response_base.parsed_response['id'])
  expect(response.code).to eq(200)
  expect(response.parsed_response['trackingId']).to include('Update')
end

Então(/^será possível consultar os dados dos endpoints dessa plataforma$/) do
  response = MSTApi.new.get_platform(@response.parsed_response['id'])
  expect(response.code).to eq(200)
  expect(response.parsed_response['endpoints'][0]).to include(PLATFORMS_JSON['endpoints'][0])
end
#=============================================================================================