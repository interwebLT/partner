class CheckoutController < SecureController
  # Is it staff or admin only? CreditsController.create on registry is admin_only
	#before_filter :staff_only, :only => [:payment_token, :index]
  
	def index
	end
  
  def transaction
    unless is_number? params[:amount]
      flash[:alert] = "Please choose from the following replenish amounts."
      redirect_to checkout_index_path and return
    end
    @amount = params[:amount].money
    @transaction_fee = @amount * Credit::TRANSACTION_FEE
    @total = @amount + @transaction_fee
  end
  
  def invoice
    if params[:id].blank?
      flash[:alert] = "Record not found."
      redirect_to root_path and return
    end
    @credit = Credit.find params[:id], token: current_user.token
    @amount = @credit.amount.money
    @transaction_fee = @credit.fee.money
    @total = @amount + @transaction_fee
  end
  
  def receipt
    if params[:id].blank?
      flash[:alert] = "Record not found."
      redirect_to root_path and return
    end
    @credit = Credit.find params[:id], token: current_user.token
    @partner = Partner.find @credit.partner_id, token: current_user.token
    @amount = @credit.amount.money
    @transaction_fee = @credit.fee.money
    @total = @amount + @transaction_fee
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
    puts "#{e}"
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
    fee = (1 + Credit::TRANSACTION_FEE).money
    amount_f = amount.to_f / 100
    amount_money = amount_f.money
    credit = (amount_money / fee).money

    return {
			"value" => amount,
			"currency" => "USD",
      "trackId" => current_user.partner_name.downcase,
      "products" => [
        {
          "name" => "Topup for #{current_user.partner_name.downcase}",
          "price" => amount_money.format,
          "quantity" => 1
        }
      ],
      "description" => "#{credit.format} credit for #{current_user.partner_name.downcase}"
		}.to_json
	end
	
  def is_number? string
    true if Float(string) rescue false
  end

end