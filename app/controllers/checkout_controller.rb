class CheckoutController < SecureController
  # Is it staff or admin only? CreditsController.create on registry is admin_only
	#before_filter :staff_only, :only => [:payment_token, :index]
	
	def index
	end
	
	def payment_token
    payload = payment_token_payload params[:value]
		
    response = HTTParty.post  Rails.configuration.checkout_endpoint + "/tokens/payment",
                              headers: checkout_headers,
                              body: payload
    
    # Add additional attributes needed by Checkout form
		hash = JSON.parse response.body
		hash["form_authenticity_token"] = form_authenticity_token
    hash["partner_id"] = current_user.id
    hash["partner_email"] = current_user.email

		render :status => response.code, :json => hash.to_json
  rescue => e
		render :status => :internal_server_error, :json => {"error" => "Failed to fetch payment token. Returned: #{e}"}
	end
	
	def verify
    token = params[:token]
    response = HTTParty.get Rails.configuration.checkout_endpoint + "/charges/#{token}",
                            headers: checkout_headers

    render :status => response.code, :json => response.body
	rescue => e
		render :status => :internal_server_error, :json => {"error" => "Failed to verify charge from Checkout. Returned: #{e}"}
	end
	
	private
	
	def api_key
		Rails.configuration.checkout_sk
	end
  
  def checkout_headers
    {
      "Content-Type" => "application/json",
      "Authorization" => api_key
    }
  end
	
	def payment_token_payload amount
		{
			"value" => amount,
			"currency" => "USD"
		}.to_json
	end
	
end