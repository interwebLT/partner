class PaypalController < SecureController
  
  def setup_payment
    if params[:amount].blank? or not is_number? params[:amount]
      flash[:alert] = "Please choose from the following replenish amounts."
      redirect_to checkout_index_path and return
    end
    
    amount = params[:amount].to_f.money
    approval_url = PaypalPayment.new(amount: amount).setup
    
    redirect_to approval_url
  end
  
  def returns
    payment_id = params[:paymentId]
    token = params[:token]
    payer_id = params[:PayerID]
    service = PaypalPaymentExecution.new payment_id: payment_id, payer_id: payer_id
    payment = service.execute
    if payment.state == 'approved'
      total = payment.transactions.first.amount.total.to_f
      amount = total.money / (1 + Credit::TRANSACTION_FEE)
      credit_hash = {
        'credit[amount]' => amount.format({:symbol => '', :thousands_separator => ''}),
        'credit[remarks]' => 'Replenish Credits',
        'verification_code' => token,
        'partner_id' => current_user.id
      }
      redirect_to "#{credits_url}?#{credit_hash.to_query}"
    else
      flash[:alert] = "Paypal payment failed. Please try again."
      redirect_to :controller => :checkout, :action => :index
    end
  end
  
  def cancel
    flash[:alert] = "Paypal payment cancelled."
    redirect_to :controller => :checkout, :action => :index
  end
  
  private
  
  def is_number? string
    true if Float(string) rescue false
  end

  def redirect_urls
    RedirectUrls.new({
      :return_url => "#{RETURN_URL}",
      :cancel_url => "#{CANCEL_URL}"
    })
  end

end