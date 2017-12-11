module SupportFunctions

    def generate_json_seller(trandingName=nil)
    	cpf = Faker::CPF.numeric
        cnpj = Faker::CNPJ.numeric
    	json_seller = SELLER_JSON['seller_complete'].dup

        if trandingName == nil
            json_seller['tradingName'] = Faker::Name.name+'umst'
        else
            json_seller['tradingName'] = trandingName
        end

        json_seller['contact'] = SELLER_JSON['seller_contact'].dup
        json_seller['address'] = SELLER_JSON['seller_address'].dup
        json_seller['companyName'] = 'Company ' + Faker::CNPJ.numeric
        json_seller['nin']['value'] = cnpj
        json_seller['active'] = false
        json_seller['status'] = 'PENDING'
        json_seller['contact']['lastName'] = (0...24).map { (65 + rand(26)).chr }.join
        json_seller['contact']['email'] = "Automatic#{cpf}@wannabe.com"
        json_seller['contact']['nin']['value'] = cpf
        json_seller['commissions'] = nil
        json_seller.delete('trackingId')
      	json_seller['contract']['trackingId'] = Faker::Number.number(32)

        return json_seller
    end

    def create_sellers_lot(x, qtde, name)
        while x <= qtde.to_i do
            puts 'Iniciando o seller '+x.to_s

            trandingName = name+'-'+x.to_s
            json_seller = generate_json_seller(trandingName)
            @response = MSTApi.new.create_seller(json_seller)
            expect(@response.code).to be(201)
            @sellerId = @response.parsed_response['id']
            puts trandingName
            puts @response.parsed_response['id'] if DEBUG
            puts "======================================="
            x+=1
        end
    end

    def logCleanup(response)
        @cleanup << response.parsed_response['id'] if response.code == 201
    end
end

World SupportFunctions
