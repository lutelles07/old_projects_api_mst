#=====================================================================================================================
# Ações de preparação do teste ou pós teste
#=====================================================================================================================

#############    GESTÃO DE MASSA      ##################
Before do |scenario|
	# Hash para ids a serem removidos
	@cleanup = Array.new
end

After do |scenario|
	#Log do erro retornado no response
	if scenario.failed?
		puts @response.parsed_response if DEBUG
	end

	#limpeza de massa de testes
	if @cleanup != nil
		@cleanup.each do |id|
			response = MSTApi.new.delete_seller(id)
			puts "============ LIMPEZA DE MASSA DE TESTE ==================" if DEBUG
			puts "============ Seller de #{id} deletado. ==================\n\n" if DEBUG
		end
	end
end
#############    GESTÃO DE MASSA      ##################

#=====================================================================================================================
#=====================================================================================================================
Before ('@delete_branches') do
	# Deleta todas as branches do seller
	@response_clear_get = MSTApi.new.get_seller_by_tracking_id("olist")
 	qtde = @response_clear_get.parsed_response['branches'].size
	@response_clear_get.parsed_response['branches'].each do |branch|
		@response_clear = MSTApi.new.delete_branch("olist",branch['id'])
		expect(@response_clear.code).to eq(204)
	end
end

############# CRIAÇÃO DE MASSA DE TESTES ###############
Before ('@create_seller') do
	# Cria o seller antes do cenário
	json_seller = generate_json_seller()
	@response = MSTApi.new.create_seller(json_seller)
	expect(@response.code).to eq(201)
	@cleanup << @response.parsed_response['id']
	@sellerId = @response.parsed_response['id']
	puts @sellerId if DEBUG
	@response_getseller = MSTApi.new.get_seller(@sellerId)
	expect(@response_getseller.code).to eq(200)
	@sellerTrackingId = @response_getseller.parsed_response['trackingId']
	puts @response_getseller.parsed_response if DEBUG
end

Before ('@create_seller_all') do
	# Cria o seller antes do cenário com todos os dados possíveis
	json_seller = generate_json_seller()
	json_seller['commissions'] = SELLER_JSON['seller_commissions'].dup
	json_seller['platforms'] = nil
	json_seller['accounts'] = nil
	json_seller['policies'] = nil

	@response = MSTApi.new.create_seller(json_seller)
	expect(@response.code).to eq(201)
	@cleanup << @response.parsed_response['id']
	puts @response.parsed_response['id'] if DEBUG
end

Before ('@create_account') do
	# Cria o seller e em seguida cria accounts para esse seller antes do cenário
	json_seller = generate_json_seller()
	response = MSTApi.new.create_seller(json_seller)
	expect(response.code).to eq(201)
	@cleanup << response.parsed_response['id']
	@sellerId = response.parsed_response['id']

	json_account = ACCOUNTS_JSON['accounts_basic'].dup
	json_account['sellerId'] = @sellerId
	@response = MSTApi.new.create_account(json_account)
	expect(@response.code).to eq(201)

	puts "Id account: #{@response.parsed_response['id']}" if DEBUG
end

Before ('@create_platform') do
	# Cria o seller e em seguida cria accounts para esse seller antes do cenário
	json_seller = generate_json_seller()
	response = MSTApi.new.create_seller(json_seller)
	expect(response.code).to eq(201)
	@cleanup << response.parsed_response['id']
	@sellerId = response.parsed_response['id']

	json_platform = PLATFORMS_JSON['platforms'].dup
	json_platform['sellerId'] = @sellerId
	@response = MSTApi.new.create_platform(json_platform)
	expect(@response.code).to eq(201)

	puts "Id platform: #{@response.parsed_response['id']}" if DEBUG
end

Before ('@create_policies') do
	# Cria o seller e em seguida cria accounts para esse seller antes do cenário
	json_seller = generate_json_seller()
	response = MSTApi.new.create_seller(json_seller)
	expect(response.code).to eq(201)
	@cleanup << response.parsed_response['id']
	@sellerId = response.parsed_response['id']

	json_policies = POLICIES_JSON['policiesComplete'][0].dup
	json_policies['sellerId'] = @sellerId
	@response = MSTApi.new.create_policies(json_policies)
	expect(@response.code).to eq(201)
	json_policies = POLICIES_JSON['policiesComplete'][1].dup
	json_policies['sellerId'] = @sellerId
	@response = MSTApi.new.create_policies(json_policies)
	expect(@response.code).to eq(201)
	json_policies = POLICIES_JSON['policiesComplete'][2].dup
	json_policies['sellerId'] = @sellerId
	@response = MSTApi.new.create_policies(json_policies)
	expect(@response.code).to eq(201)

	puts "Id policies: #{@response.parsed_response['id']}" if DEBUG
end
############# CRIAÇÃO DE MASSA DE TESTES ###############


#=====================================================================================================================
#=====================================================================================================================


################ GESTÃO CONEXÕES COM O RABBIT ############
Before do
	@RabbitHelper = RabbitHelper.new(ENVIRONMENT['rabbit']['host'])
	@RabbitHelper.openConnection
end

Before ('@createQueue') do
	@RabbitHelper.createQueue(ENVIRONMENT['rabbit']['queueName'], ENVIRONMENT['rabbit']['exchangeName'])
end

After do
	@RabbitHelper.closeConnection
end
################ GESTÃO CONEXÕES COM O RABBIT ############
