# enconding: utf-8

#=====================================================================================================================
# Steps de Criação de Seller
#=====================================================================================================================
Dado(/^que eu cadastre um seller através da API MST com os dados completo$/) do
  json_seller = generate_json_seller()
  puts json_seller if DEBUG

  @response = MSTApi.new.create_seller(json_seller)
  logCleanup(@response)
end

Dado(/^que eu cadastre um seller através da API MST com os dados basico$/) do
  json_seller = SELLER_JSON['seller_basic'].dup

  json_seller['nin']['value'] = Faker::CNPJ.numeric
  json_seller['tradingName'] = 'TestMST-' + Faker::Name.name
  puts json_seller if DEBUG

  @response = MSTApi.new.create_seller(json_seller)
  logCleanup(@response)
end

Dado(/^que eu cadastre um seller através da API MST com os dados de contato$/) do
  cpf = Faker::CPF.numeric
  json_seller = SELLER_JSON['seller_basic'].dup

  json_seller['contact'] = SELLER_JSON['seller_contact'].dup
  json_seller['nin']['value'] = Faker::CNPJ.numeric
  json_seller['tradingName'] = 'TestMST-' + Faker::Name.name
  json_seller['contact']['lastName'] = Faker::Name.last_name
  json_seller['contact']['email'] = "Automatic#{cpf}@wannabe.com"
  json_seller['contact']['nin']['value'] = cpf
  puts json_seller if DEBUG

  @response = MSTApi.new.create_seller(json_seller)
  logCleanup(@response)
end

Dado(/^eu tente cadastrar o mesmo seller novamente$/) do
  expect(@response.code).to eq(201)
  json_seller = MSTApi.new.get_seller(@response.parsed_response['id']).parsed_response

  json_seller['createdAt'] = nil
  json_seller['id'] = nil
  json_seller['trackingId'] = nil

  @response = MSTApi.new.create_seller(json_seller)
  logCleanup(@response)
end

Dado(/^que eu cadastre um seller através da API MST com os dados vazio$/) do
  json_seller = SELLER_JSON['seller_basic'].dup
  json_seller.delete('nin')
  json_seller.delete('tradingName')
  json_seller.delete('companyName')
  json_seller.delete('trackingId')
  puts json_seller if DEBUG

  @response = MSTApi.new.create_seller(json_seller)
  logCleanup(@response)
end

Dado(/^que eu cadastre um seller através da API MST com uma comissão de categoria$/) do
  json_seller = generate_json_seller()
  json_seller['commissions'] = []
  json_seller['commissions'][0] = COMMISSION_JSON['commission_categoy'][0].dup
  # Remove SellerID, should be generated
  json_seller['commissions'][0]["sellerId"] = nil
  puts json_seller if DEBUG

  @response = MSTApi.new.create_seller(json_seller)
  logCleanup(@response)
end

Dado(/^que eu cadastre um seller através da API MST com várias comissões de categoria$/) do
  json_seller = generate_json_seller()
  json_seller['commissions'] = COMMISSION_JSON['commission_categoy'].dup
  # Remove SellerID, should be generated
  json_seller['commissions'][0]["sellerId"] = nil
  json_seller['commissions'][1]["sellerId"] = nil
  puts json_seller if DEBUG

  @response = MSTApi.new.create_seller(json_seller)
  logCleanup(@response)
end

Dado(/^que eu cadastre um seller através da API MST com uma comissão de "([^"]*)" e uma de "([^"]*)" com id "([^"]*)"$/) do |type1, type2, id|
  json_seller = generate_json_seller()
  json_seller['commissions'] = COMMISSION_JSON['commission_categoy'].dup
  json_seller['commissions'][0]['type'] = type1
  json_seller['commissions'][1]['type'] = type2
  json_seller['commissions'][0]['trackingId'] = id
  json_seller['commissions'][1]['trackingId'] = id
  puts json_seller if DEBUG

  @response = MSTApi.new.create_seller(json_seller)
  logCleanup(@response)
end

Dado(/^que eu cadastre um seller através da API MST com uma comissão de "([^"]*)" e uma de "([^"]*)" com id diferente$/) do |type1, type2|
  json_seller = generate_json_seller()
  json_seller['commissions'] = COMMISSION_JSON['commission_categoy'].dup
  json_seller['commissions'][0]['type'] = type1
  json_seller['commissions'][1]['type'] = type2
  puts json_seller if DEBUG

  @response = MSTApi.new.create_seller(json_seller)
  logCleanup(@response)
end

Dado(/^que eu cadastre um seller através da API MST com uma comissão de frete$/) do
  json_seller = generate_json_seller()
  json_seller['commissions'] = []
  json_seller['commissions'][0] = COMMISSION_JSON['commission_freight'][0].dup
  puts json_seller if DEBUG

  @response = MSTApi.new.create_seller(json_seller)
  logCleanup(@response)
end

Dado(/^que eu cadastre um seller através da API MST com várias comissões de frete$/) do
  json_seller = generate_json_seller()
  json_seller['commissions'] = COMMISSION_JSON['commission_freight'].dup
  puts json_seller if DEBUG

  @response = MSTApi.new.create_seller(json_seller)
  logCleanup(@response)
end

Dado(/^que eu cadastre um seller através da API MST múltiplas comissões$/) do
  json_seller = generate_json_seller()
  json_seller['commissions'] = SELLER_JSON['seller_commissions'].dup
  puts json_seller if DEBUG

  @response = MSTApi.new.create_seller(json_seller)
  logCleanup(@response)
end

Dado(/^que eu cadastre um seller através da API MST com duas comissões de "([^"]*)" e id "([^"]*)"$/) do |type, id|
  json_seller = generate_json_seller()
  json_seller['commissions'] = COMMISSION_JSON['commission_categoy'].dup
  json_seller['commissions'][0]['type'] = type
  json_seller['commissions'][1]['type'] = type
  json_seller['commissions'][0]['trackingId'] = id
  json_seller['commissions'][1]['trackingId'] = id
  puts json_seller if DEBUG

  @response = MSTApi.new.create_seller(json_seller)
  logCleanup(@response)
end

Dado(/^que eu cadastre um seller através da API MST com uma comissão de "([^"]*)"$/) do |type|
  json_seller = generate_json_seller()
  json_seller['commissions'] = []
  json_seller['commissions'][0] = COMMISSION_JSON['commission_categoy'][0].dup
  json_seller['commissions'][0]['type'] = type
  puts json_seller if DEBUG

  @response = MSTApi.new.create_seller(json_seller)
  logCleanup(@response)
end

Dado(/^que eu cadastre um seller através da API MST com o trackingID duplicado$/) do
  json_seller = generate_json_seller()
  response = MSTApi.new.create_seller(json_seller)
  logCleanup(response)

  json_seller = MSTApi.new.get_seller(response.parsed_response['id']).parsed_response
  json_seller.delete('createdAt')
  json_seller.delete('id')
  puts json_seller if DEBUG

  @response = MSTApi.new.create_seller(json_seller)
  logCleanup(@response)
end
#=====================================================================================================================


#=====================================================================================================================
# Steps de Assertations da criação na API de Sellers
#=====================================================================================================================
Então(/^o seller será corretamente cadastrado$/) do
  expect(@response.code).to eq(201)
  expect(@response.parsed_response['id']).to be_a(Fixnum)
  puts @response.headers["Location"].to_s if DEBUG
end

Então(/^o seller terá privacidade de email ativa$/) do
  response = MSTApi.new.get_seller(@response.parsed_response['id'])
  puts response if DEBUG
  expect(response.parsed_response['emailPrivacyEnabled']).to be(true)
  puts @response.headers["Location"].to_s if DEBUG
end

Então(/^passará a ser possível consultá\-lo na API MST$/) do
  response = MSTApi.new.get_seller(@response.parsed_response['id'])
  expect(response.code).to eq(200)
  expect(response.parsed_response["trackingId"]).to include('umst')
end

Então(/^passará a ser possível consultá\-lo na API Stargate$/) do
  response = MSTApi.new.get_seller(@response.parsed_response['id'])
  puts response.parsed_response['trackingId'] if DEBUG
  response_stargate = StargateApi.new.get_seller(response.parsed_response['trackingId'])
  puts response_stargate if DEBUG
  expect(response_stargate.code).to eq(200)

  expect(response_stargate.parsed_response['name']).to include("umst")
  expect(response_stargate.parsed_response['sellerOwner']["firstName"]).to include("Automatic")
  expect(response_stargate.parsed_response['address']['id']).to be_a(Fixnum)
end

Então(/^passará a ser possível consultar a comissão de "([^"]*)" na busca do seller na API MST$/) do |type|
  response = MSTApi.new.get_seller(@response.parsed_response['id'])
  expect(response.code).to eq(200)
  expect(response.parsed_response['commissions'][0]['type']).to eq(type)
end

Então(/^passará a ser possível consultar a comissão de "([^"]*)" e "([^"]*)" na busca do seller na API MST$/) do |type1, type2|
  response = MSTApi.new.get_seller(@response.parsed_response['id'])
  expect(response.code).to eq(200)
  expect(response.parsed_response['commissions'][0]['type']).to eq(type1)
  expect(response.parsed_response['commissions'][1]['type']).to eq(type2)
end

Então(/^passará a ser possível consultar comissões na busca do seller na API MST$/) do
  response = MSTApi.new.get_seller(@response.parsed_response['id'])
  expect(response.code).to eq(200)
  expect(response.parsed_response['commissions'][0]['type']).not_to be(nil)
  expect(response.parsed_response['commissions'][1]['type']).not_to be(nil)
end
#=====================================================================================================================

Então(/^o seller cadastrado deverá estar com o status de integração como "([^"]*)"$/) do |integrationStatus|
  seller = MSTApi.new.get_seller(@response.parsed_response['id'])
  expect(seller.parsed_response['integrationStatus']).to eq(integrationStatus)
end
