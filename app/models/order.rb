class Order
  include Api::Model

  attr_accessor :id, :partner, :order_number, :total_price, :fee, :ordered_at, :status, :currency_code, :order_details

  def order_details= order_details
    @order_details = order_details.collect { |order_detail| OrderDetail.new order_detail }
  end

  def partner= partner
    @partner = Partner.new partner
  end

  def status= status
  	if status == 'complete'
  		@status = '<span class="glyphicon glyphicon-ok-circle text-success" data-toggle="tooltip" data-placement="top" title="Complete"></span>'.html_safe
  	end
  end
end
