# enconding: utf-8

#=====================================================================================================================
# Steps de Search na API de Seller
#=====================================================================================================================
Dado(/^que eu procure o widget do seller usando o ID$/) do
	@response = MSTApi.new.get_seller_widget_by_id(@sellerId)
	expect(@response.code).to eq(200)
	puts @response if DEBUG
end

Dado(/^que eu procure o widget do seller usando o TrackingID$/) do
	@response = MSTApi.new.get_seller_widget(@sellerTrackingId)
	expect(@response.code).to eq(200)
	puts @response if DEBUG
end

#=====================================================================================================================



#=====================================================================================================================
# Steps de Assertations de Search na API de Seller
#=====================================================================================================================
Então(/^eu verei todos os dados do json de widget do seller preenchidos$/) do
	expect(@response.parsed_response['tradingName']).to include("umst")
	expect(@response.parsed_response['contact']["firstName"]).to include("Automatic")
	expect(@response.parsed_response['address']['lineOne']).to_not be_nil
	# POLICIES
	json_policies = POLICIES_JSON['policiesCurrent'].dup
	expect(@response.parsed_response['policies']).to_not be_nil
	expect(@response.parsed_response['policies']).to eq(json_policies)
end

#=====================================================================================================================
