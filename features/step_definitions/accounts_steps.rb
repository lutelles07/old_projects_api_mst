# enconding: utf-8

#=============================================================================================
# Steps de create da API de Accounts
#=============================================================================================
Dado(/^que eu cadastre dados de conta válidos em uma branch para um seller$/) do
	@json_branch = BRANCHES_JSON['branch'].dup

	@json_branch['vendor'] = Faker::Number.number(6)
	@json_branch['email'] = Faker::Internet.email
	@json_branch['nin']['value'] = Faker::CNPJ.numeric
	@json_branch['bankCurrentAccount']['number'] = Faker::Number.number(5)

	puts @json_branch if DEBUG
	@response = MSTApi.new.update_branch("olist", @json_branch)
end

Dado(/^que eu cadastre dados de conta válidos para um seller$/) do
	json_account = ACCOUNTS_JSON['accounts'].dup
	json_account['sellerId'] = @response.parsed_response['id']

	@response = MSTApi.new.create_account(json_account)
end

Dado(/^que eu cadastro os dados de conta apenas com os campo obrigatórios para um seller$/) do
	puts @response.parsed_response['id'] if DEBUG
	json_account = ACCOUNTS_JSON['accounts_basic'].dup
	json_account['sellerId'] = @response.parsed_response['id']

	@response = MSTApi.new.create_account(json_account)
end

Dado(/^que eu cadastre os dados de conta inválidos para um seller$/) do
	json_account = ACCOUNTS_JSON['accounts_basic'].dup
	json_account['sellerId'] = Faker::Number.number(8)
	json_account['bankAgency'] = nil

	@response = MSTApi.new.create_account(json_account)
end

Dado(/^que eu cadastro os dados de conta com o campo de id do seller em branco$/) do
	json_account = ACCOUNTS_JSON['accounts_basic'].dup
	json_account['sellerId'] = nil

	@response = MSTApi.new.create_account(json_account)
end

Dado(/^que eu atualize os dados de conta de um seller$/) do
	json_account = ACCOUNTS_JSON['accounts_basic'].dup
	json_account['bankName'] = 'Update bankName'
	json_account['sellerId'] = @sellerId
	@response_base = @response
	@response = MSTApi.new.update_account(@response.parsed_response['id'], json_account)
end
#=============================================================================================

Dado(/^que eu tenha obtenha a primeira branch de um seller$/) do
	@response = MSTApi.new.get_seller_by_tracking_id("olist")
	@id_first_branch = @response.parsed_response['branches'][0]['id']
	expect(@id_first_branch).not_to eq(nil)
end

Quando(/^eu solicitar a exclusão da branch$/) do
	@response = MSTApi.new.delete_branch(@response.parsed_response['trackingId'],@id_first_branch)
end

#=============================================================================================
# Steps de search da API de Accounts
#=============================================================================================
Dado(/^que eu busque os dados de conta usando o id da conta de um seller$/) do
	@response = MSTApi.new.get_account(@response.parsed_response['id'])
end

Dado(/^que eu busque os dados de conta de todos os sellers$/) do
@response = MSTApi.new.get_account()
end

Dado(/^então eu busque dados de conta da página seguinte$/) do
	search = "&page=#{@response.parsed_response['meta']['page']+1}"
	@response = MSTApi.new.get_account_search(search)
end

Então(/^será possível consultar os dados de contas$/) do
	response = MSTApi.new.get_account(@response.parsed_response['id'])
	expect(response.code).to eq(200)
	expect(response.parsed_response['items'][0]['bankName']).not_to be nil
	expect(response.parsed_response['items'][1]['bankName']).not_to be nil
end
#=============================================================================================

#=============================================================================================
# Steps de assertations da API de Accounts
#=============================================================================================
Então(/^será possível consultar os dados de conta desse seller$/) do
	response = MSTApi.new.get_account(@response.parsed_response['id'])
	expect(response.code).to eq(200)
	expect(response.parsed_response['bankName']).to eq(ACCOUNTS_JSON['accounts']['bankName'])
end

Então(/^será possível consultar os dados de conta atualizados desse seller$/) do
	response = MSTApi.new.get_account(@response_base.parsed_response['id'])
	expect(response.code).to eq(200)
	expect(response.parsed_response['bankName']).to eq('Update bankName')
	expect(response.parsed_response['updatedAt']).not_to eq(nil)
end
#=============================================================================================


Então(/^a branch deletada não estará mais nos dados de pagamento do seller$/) do
	@response = MSTApi.new.get_payment_info("olist")
	expect(@response.code).to eq(200)
	puts @response if DEBUG
	expect(@response.parsed_response['id']).not_to eq(@id_first_branch)
end

Então(/^a branch deve estar contida nos dados do Seller$/) do
	@response_test = MSTApi.new.get_seller_by_tracking_id("olist")
	puts @response_test.parsed_response['branches'].last['vendor'] if DEBUG
	puts @json_branch['vendor'] if DEBUG
	expect(@response_test.parsed_response['branches'].last['vendor']).to eq(@json_branch['vendor'].to_i)
end
