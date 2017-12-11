class ContractApi
  include HTTParty

  base_uri ENVIRONMENT['contractapi']
  format :json
  headers 'Content-Type' => 'application/json',
    'Accept' => 'application/json'

  def initialize
    @auth = {
      username: AUTH['contractapi']['username'],
      password: AUTH['contractapi']['password']
    }
  end


#==================================================================================================
# CONTRACT API
#==================================================================================================

  def get_contract_current()
    self.class.get("/api/contracts/current", :basic_auth => @auth)
  end

end
