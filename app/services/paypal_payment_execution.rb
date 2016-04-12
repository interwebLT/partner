class PaypalPaymentExecution
  include PayPal::SDK::REST
  include PayPal::SDK::Core::Logging
  
  def initialize payment_id:, payer_id:
    @payment_id = payment_id
    @payer_id = payer_id
  end
  
  def execute
    payment = Payment.new( { :id => @payment_id } )
    payment_execution = PaymentExecution.new( { :payer_id => @payer_id })
    payment.execute payment_execution
    payment
  end

end