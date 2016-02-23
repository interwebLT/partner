class Order
  include Api::Model

  attr_accessor :id, :partner, :order_number, :total_price, :fee, :ordered_at, :status, :currency_code, :order_details

  COMPLETE  = 'complete'
  PENDING   = 'pending'
  ERROR     = 'error'

  def order_details= order_details
    @order_details = order_details.collect { |order_detail| OrderDetail.new order_detail }
  end

  def complete?
    status == COMPLETE
  end

  def pending?
    status == PENDING
  end

  def error?
    status == ERROR
  end

  def save token:
    Order.post Order.url(id: id), to_json, token: token
  end

  def to_json
    {
      currency_code: currency_code,
      order_details: @order_details.collect { |det| det.as_json }
    }
  end
end
