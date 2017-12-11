class MSTApi
    include HTTParty

    base_uri ENVIRONMENT['mst']
    format :json
    headers 'Content-Type' => 'application/json',
            'Accept' => 'application/json'

    def initialize
        @auth = {
            username: AUTH['mst']['username'],
            password: AUTH['mst']['password']
        }
    end


#=============================================================================================
# API de Sellers
#=============================================================================================
    def create_seller(json_seller)
        self.class.post("/api/sellers", :body => json_seller.to_json, :basic_auth => @auth)
    end

    def update_active_seller(id, status)
        self.class.put("/api/sellers/#{id}/active/#{status}", :basic_auth => @auth)
    end

    def update_email_privacy_enabled(trackingId, json_update)
        self.class.put("/api/sellers/trackingId/#{trackingId}/emailPrivacyEnabled", :body =>json_update.to_json ,:basic_auth => @auth)
    end

    def update_status_seller(trackingId, json_update)
        self.class.put("/api/sellers/trackingId/#{trackingId}/status", :body =>json_update.to_json ,:basic_auth => @auth)
    end

    def get_seller(id=nil)
    	self.class.get("/api/sellers/#{id}", :basic_auth => @auth)
    end

    def get_seller_by_tracking_id(trackingId=nil)
        self.class.get("/api/sellers/trackingId/#{trackingId}", :basic_auth => @auth)
    end

    def update_seller(id, json_seller)
        self.class.put("/api/sellers/#{id}", :body => json_seller.to_json, :basic_auth => @auth)
    end

    def update_all_seller(trackingId, json_seller)
        self.class.put("/api/sellers/trackingId/#{trackingId}", :body => json_seller.to_json, :basic_auth => @auth)
    end

    def get_sellers_by_status(status)
        self.class.get("/api/sellers?sortOrder=1&orderBy=createdAt&status=#{status}", :basic_auth => @auth)
    end

    def replace_commissions(trackingId, json_update)
        self.class.put("/api/sellers/trackingId/#{trackingId}/commissions", :body => json_update.to_json, :basic_auth => @auth)
    end

    def update_integrated(trackingId, flag)
         self.class.put("/api/sellers/trackingId/#{trackingId}/integrated/#{flag}", :basic_auth => @auth)
    end

    def get_integrated(flag)
        self.class.get("/api/sellers?integrated=#{flag}&limit=3", :basic_auth => @auth)
    end

    def delete_seller(id)
        self.class.delete("/api/sellers/#{id}", :basic_auth => @auth)
    end

    def get_emailPrivacyEnabled(flag)
        self.class.get("/api/sellers?emailPrivacyEnabled=#{flag}&limit=3", :basic_auth => @auth)
    end

    def create_seller_contract(json_seller)
        self.class.post("/api/sellers", :body => json_seller.to_json, :basic_auth => @auth)
    end

    def get_payment_info(id)
        self.class.get("/api/sellers/trackingId/#{id}/payment-info", :basic_auth => @auth)
    end

    def update_branch(id, json_seller)
        self.class.put("/api/sellers/trackingId/#{id}/branches", :body => json_seller.to_json, :basic_auth => @auth)
    end

    def delete_branch(id, branch)
        self.class.delete("/api/sellers/trackingId/#{id}/branches/#{branch}", :basic_auth => @auth)
    end

    def get_seller_widget(trackingId)
        self.class.get("/api/sellers/trackingId/#{trackingId}/widget", :basic_auth => @auth)
    end

    def get_seller_widget_by_id(id)
        self.class.get("/api/sellers/#{id}/widget", :basic_auth => @auth)
    end


#=============================================================================================

end
