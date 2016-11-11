class DragonPay
  current_rate = ExchangeRate.get_current_rate

  if !current_rate.nil?
    USD_TO_PESO = current_rate.usd_rate.to_i
  else
    USD_TO_PESO = 47
  end

  def initialize dragonpay_config
    @merchant_id = dragonpay_config['merchant_id']
    @password = dragonpay_config['password']

    @client = Savon.client wsdl: dragonpay_config['wsdl']

    @payment_url = dragonpay_config['payment_url']
  end

  def setup_transaction callback_token, amount
    txn_id = callback_token
    amount = (amount * USD_TO_PESO).format({:symbol => '', :delimiter => ''})
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
