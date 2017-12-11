Dado(/^que eu consulte os dados de comissão passando os dados de categorias e filtro de melhor comissão$/) do
  @response = MSTApi.new.get_commission_legacy(DATA['legacyWithCommission']['trackingId'], DATA['legacyWithCommission']['idCategory'], 'best')
end

Então(/^será retornado apenas valor da comissão com o valor esperado$/) do
  puts @response.parsed_response[0]['value'] if DEBUG
  puts DATA['legacyWithCommission']['value'] if DEBUG
  expect(@response.parsed_response[0]['value']).to be(DATA['legacyWithCommission']['value'])
end

Dado(/^que eu consulte os dados de comissão de um seller que não tenha comissões cadastradas$/) do
  @response = MSTApi.new.get_commission_legacy(DATA['legacyWithoutCommission']['trackingId'], DATA['legacyWithoutCommission']['idCategory'], 'best')
end

Então(/^será retornado comissão "([^"]*)"$/) do |value|
  expect(@response.parsed_response[0]['value']).to be(value.to_i)
end

Dado(/^que eu consulte os dados de comissão de um seller que não exista$/) do
  @response = MSTApi.new.get_commission_legacy('xxINEXISTENTExx', '99', 'best')
end

Então(/^será retornado valores de comissão em branco$/) do
  expect(@response.parsed_response[0]).to be nil
end

Dado(/^que eu consulte os dados de um seller cadastrado no WWW5$/) do
  response = MSTApi.new.get_sellers_by_status('SENT_TO_WWW5')
  @seller = response.parsed_response['items'][0]
  puts @seller if DEBUG
  @response = MSTApi.new.get_seller_legacy(@seller['trackingId'])
end

Então(/^será retornado dados do seller que estejam cadastrados no WWW5$/) do
  expect(@response.parsed_response['cnpj']).to eq(@seller['nin']['value'])
end

Dado(/^que eu consulte os dados de um seller que não existe no WWW5 por sellerKey$/) do 
  @response = MSTApi.new.get_seller_legacy('SellerOnlyMST')
end

Dado(/^que eu consulte a comissões cadastradas de um seller por sellerKey$/) do
  response = MSTApi.new.get_sellers_by_status('SENT_TO_WWW5')
  puts response if DEBUG
  @seller = response.parsed_response['items'][0]
  puts @seller if DEBUG
  @response = MSTApi.new.get_all_commissions_legacy(@seller['trackingId'])
end

Então(/^será retornado todas as comissões negociadas por esse seller$/) do
  expect(@response.parsed_response['commissions'][0]['value']).not_to be(nil)
end

Então(/^será retornado dados do seller$/) do
  expect(@response.parsed_response['companyName']).not_to be(nil)
end

Então(/^será retornado a comissão padrão do seller$/) do
  expect(@response.parsed_response['commissions'][0]['type']).not_to include('default')
end

Dado(/^que eu consulte os dados de um seller por sellerKey que não exista no WWW5 e no MST$/) do 
  @response = MSTApi.new.get_all_commissions_legacy('xxINEXISTENTExx')
end

Dado(/^que eu consulte a comissões cadastradas de um seller por cnpj$/) do
  response = MSTApi.new.get_sellers_by_status('SENT_TO_WWW5')
  @seller = response.parsed_response['items'][0]
  puts @seller if DEBUG
  @response = MSTApi.new.get_all_commissions_legacy_by_cnpj(@seller['nin']['value'])
end

Dado(/^que eu consulte os dados de um seller por cnpj que não exista no WWW5 e no MST$/) do 
  @response = MSTApi.new.get_all_commissions_legacy_by_cnpj(999999999999)
end
