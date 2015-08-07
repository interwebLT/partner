class OrderDetail
  include Api::Model

  attr_accessor :type, :price,
                :domain, :authcode, :period, :registrant_handle, :registered_at,
                :object,
                :expires_at,
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
    {
      type: type,
      domain: domain,
      authcode: authcode,
      period: period,
      registrant_handle: registrant_handle,
      registered_at: registered_at
    }
  end
end
