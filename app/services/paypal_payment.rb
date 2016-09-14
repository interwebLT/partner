class PaypalPayment
  include PayPal::SDK::REST
  include PayPal::SDK::Core::Logging

  RETURN_URL = Rails.configuration.paypal_return_url
  CANCEL_URL = Rails.configuration.paypal_cancel_url

  def initialize amount:
    @amount = amount * (1 + ::Credit::TRANSACTION_FEE)
  end

  def setup
    @payment = create_payment
    @payment.create
    get_approval_url
  end

  private

  def create_payment
    Payment.new({
      :intent => "sale",
      :payer => {
        :payment_method => 'paypal'  
      },
      :transactions => paypal_transactions,
      :redirect_urls => redirect_urls
    })
  end

  def paypal_transactions
    item_list = ItemList.new({
      :items =>  {
        name: "Top up",
        quantity: "1",
        price: @amount.format({:symbol => ''}) ,
        currency: 'USD'
      }
    })
    transactions = []
    transaction = Transaction.new({
      :amount => {
        :total => @amount.format({:symbol => ''}),
        :currency => @amount.currency.to_s
      },
      :item_list => item_list
    })
    transactions << transaction
  end

  def get_approval_url
    approval_link = ''
    @payment.links.each do |link|
      if link.rel == 'approval_url'
        approval_link = link.href
      end
    end
    approval_link
  end

  def redirect_urls
    RedirectUrls.new({
      :return_url => "#{RETURN_URL}",
      :cancel_url => "#{CANCEL_URL}"
    })
  end

end