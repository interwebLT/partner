class DragonPay
  def initialize dragonpay_config
    @merchant_id = dragonpay_config['merchant_id']
    @password = dragonpay_config['password']

    @client = Savon.client wsdl: dragonpay_config['wsdl']

    @payment_url = dragonpay_config['payment_url']
  end

  def setup_transaction callback_token, amount, token
    current_rate = ExchangeRate.get_current_rate Date.today, token

    if !current_rate.nil?
      current_rate_amount = current_rate.last.usd_rate.to_i
    else
      current_rate_amount = 47
    end

    txn_id = callback_token
    amount = (amount * current_rate_amount).format({:symbol => '', :delimiter => ''})
    ccy = 'PHP'
    description = 'Replenish Credits'

    params = {
      'merchantId' => @merchant_id,
      'password' => @password,
      'merchantTxnId' => txn_id,
      'amount' => amount,
      'ccy' => ccy,
      'description' => description,
      'param1' => 'THISISANOPTIONALPARAM'
    }
    response = @client.call :get_txn_token,  message: params
    return response.body[:get_txn_token_response][:get_txn_token_result]
  end

  def redirect_url_for token
    return "#{@payment_url}?tokenid=#{token}"
  end
end
