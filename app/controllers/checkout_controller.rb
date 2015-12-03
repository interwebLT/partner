class CheckoutController < SecureController
	before_filter :staff_only, :only => [:payment_token, :index]
	
	def index
	end
	
	def payment_token
		payload = payment_token_payload params[:value]
		
		response = fetch_token payload
		json = response.body
		hash = JSON.parse json
		hash["form_authenticity_token"] = form_authenticity_token
		puts "#{hash}"
		puts "#{hash.to_json}"
		render :status => response.code, :json => hash.to_json
  rescue => e
		render :status => :internal_server_error, :json => {"error" => "Failed to fetch payment token. Returned: #{e}"}
	end
	
	def verify
		response = verify_charge params[:token]
		render :status => response.code, :json => response.body
	rescue => e
		render :status => :internal_server_error, :json => {"error" => "Failed to verify charge from Checkout. Returned: #{e}"}
	end
	
	private
	
	def api_key
		# TODO: externalize key
		"sk_test_fff76289-8b53-4c2b-88ab-921c27f0f421"
	end
	
	def fetch_token payload
    uri = URI.parse("https://sandbox.checkout.com/api2/v2/tokens/payment")
    https = Net::HTTP.new uri.host, uri.port
    https.use_ssl = true

		request = Net::HTTP::Post.new uri.request_uri, initheader = {"Content-Type" => "application/json",  "Authorization" => api_key}
		request.body = payload

		response = https.request request
	end
	
	def payment_token_payload amount
		{
			"value" => amount,
			"currency" => "USD"
		}.to_json
	end
	
	def verify_charge token
		uri = URI.parse("https://sandbox.checkout.com/api2/v2/charges/#{token}")
    https = Net::HTTP.new uri.host, uri.port
    https.use_ssl = true

		request = Net::HTTP::Get.new uri.request_uri, initheader = {"Authorization" => api_key}

		response = https.request request
	end

end