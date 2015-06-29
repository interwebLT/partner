class Order
  include Api::Model

  attr_accessor :id, :partner, :order_number, :total_price, :fee, :ordered_at, :status, :currency_code, :order_details

  COMPLETE = 'complete'

  def order_details= order_details
    @order_details = order_details.collect { |order_detail| OrderDetail.new order_detail }
  end

  def partner= partner
    @partner = Partner.new partner
  end

  def complete?
    status == COMPLETE
  end
end
