class OrderDetail
  include Api::Model

  attr_accessor :type, :price,
                :domain, :authcode, :period, :registrant_handle,
                :object, :credits, :remarks,
                :registered_at, :expires_at,
                :refunded_order_detail

  def refunded_order_detail= order_detail
    @refunded_order_detail = OrderDetail.new order_detail

    self.domain = @refunded_order_detail.domain
    self.period = @refunded_order_detail.period
  end

  def object= object
    @object = AppObject.new object
  end

  def as_json
    if type == 'checkout_credits'
      return {
        type: type,
        credits: credits, 
        authcode: authcode,
        remarks: remarks
      }
    elsif type != 'credits' 
      return {
        type: type,
        domain: domain,
        authcode: authcode,
        period: period,
        registrant_handle: registrant_handle
      }
    else
      return {
        type: type,
        credits: credits, 
        remarks: remarks
      }
    end
  end
end
