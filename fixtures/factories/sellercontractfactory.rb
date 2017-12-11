class SellerContractFactory

  def self.create_valid(id)
    seller_contract = YAML.load_file('./fixtures/seller_contract.yaml').dup
    
    seller_contract['trackingId'] = Faker::Number.number(50)
    seller_contract['companyName'] = "testmst"+Faker::Company.name
    seller_contract['tradingName'] = Faker::Company.name
    seller_contract['description'] = Faker::Company.name
    seller_contract['nin']['value'] = Faker::CNPJ.numeric
    seller_contract['contact']['firstName'] = Faker::Name.first_name
    seller_contract['contact']['lastName'] = Faker::Name.last_name
    seller_contract['contact']['email'] = Faker::Internet.email
    seller_contract['contact']['phone'] = "23232323"
    seller_contract['contact']['nin']['value'] = Faker::CPF.numeric
    seller_contract['contract']['baseContract']['id'] = id
    seller_contract['contract']['trackingId'] = Faker::Number.number(32)

    return seller_contract
  end

  def self.create_invalid()

    seller_contract = YAML.load_file('./fixtures/seller_contract.yaml').dup
    
    seller_contract['trackingId'] = Faker::Number.number(50)
    seller_contract['companyName'] = "testmst"+Faker::Company.name
    seller_contract['tradingName'] = Faker::Company.name
    seller_contract['description'] = Faker::Company.name
    seller_contract['nin']['value'] = Faker::CNPJ.numeric
    seller_contract['contact']['firstName'] = Faker::Name.first_name
    seller_contract['contact']['lastName'] = Faker::Name.last_name
    seller_contract['contact']['email'] = Faker::Internet.email
    seller_contract['contact']['phone'] = "23232323"
    seller_contract['contact']['nin']['value'] = Faker::CPF.numeric
    
    return seller_contract

  end

  def self.create_sellers_name_fantasy(id)
    seller_contract = YAML.load_file('./fixtures/seller_contract.yaml').dup
    
    seller_contract['companyName'] = "testmst nome fantasia"
    seller_contract['tradingName'] = "testmst nome fantasia"
    seller_contract['description'] = Faker::Company.name
    seller_contract['nin']['value'] = Faker::CNPJ.numeric
    seller_contract['contact']['firstName'] = Faker::Name.first_name
    seller_contract['contact']['lastName'] = Faker::Name.last_name
    seller_contract['contact']['email'] = Faker::Internet.email
    seller_contract['contact']['phone'] = "23232323"
    seller_contract['contact']['nin']['value'] = Faker::CPF.numeric
    seller_contract['contract']['baseContract']['id'] = id
    seller_contract['contract']['trackingId'] = Faker::Number.number(32)

    return seller_contract
      
  end

end
