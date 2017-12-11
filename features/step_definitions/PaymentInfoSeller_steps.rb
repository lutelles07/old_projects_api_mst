# enconding: utf-8

#=====================================================================================================================
# Steps de Search na API de Seller
#=====================================================================================================================
Dado(/^que eu procure os dados de pagamento de um seller usando o ID$/) do
	#####puts @response.parsed_response['trackingId'] if DEBUG
	@response = MSTApi.new.get_payment_info("olist")
	expect(@response.code).to eq(200)
	#####debug:
	puts @response if DEBUG
end
