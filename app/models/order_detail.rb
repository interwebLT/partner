class OrderDetail
  include Api::Model

  attr_accessor :type, :price,
                :domain, :authcode, :period, :registrant_handle, :registered_at,
                :renewed_at,
                :expires_at
end
