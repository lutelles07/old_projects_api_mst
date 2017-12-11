class StargateApi
    include HTTParty

    base_uri ENVIRONMENT['stargate']
    format :json
    headers 'Content-Type' => 'application/json',
            'Accept' => 'application/json'

    def initialize
        @auth = {
            username: AUTH['stargate']['username'],
            password: AUTH['stargate']['password']
        }
    end

    def get_seller(sellerkey)
    	response = self.class.get("/services/api/sellers/sellerKey/#{sellerkey}", 
            :basic_auth => @auth)
    end

end