class DragonPayController < SecureController
  
  TRANSACTION_SOURCE = "partner"
  
  def setup_payment
    if params[:amount].blank? or not is_number? params[:amount]
      flash[:alert] = "Please choose from the following replenish amounts."
      redirect_to checkout_index_path and return
    end
    
    if current_user.admin
      partner = Partner.find params[:partner_id], token: current_user.token
    else
      partner = current_user.partner
    end
    puts "partner #{partner.name}"
    credit = partner.replenish_credits params[:amount], 'Pending DragonPay Payment', current_user.token, Credit::DRAGON_PAY_CREDIT, nil
    
    credit_number = credit[:credit_number]
    
    result = HTTParty.post DRAGON_PAY_TRANSACTION_REGISTRATION_URL, query: setup_payment_for(credit_number)
    
    amount = params[:amount].to_f.money
    token = DRAGON_PAY_GATEWAY.setup_transaction credit_number, amount
    
    redirect_to DRAGON_PAY_GATEWAY.redirect_url_for token
  end
  
  def pending
    redirect_to invoice_path :id => params[:txnid]
  end
  
  private
  
  def setup_payment_for transaction_id
    {
      source: TRANSACTION_SOURCE,
      transaction_id: transaction_id,
      amount: params[:amount]
    }
  end
  
  def is_number? string
    true if Float(string) rescue false
  end

end