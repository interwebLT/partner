class Order
  include Api::Model

  attr_accessor :id, :partner, :order_number, :ordered_at,
                :type, :price, :domain, :period, :registrant_handle

  # Legacy
  attr_accessor :total_price, :fee, :status, :currency_code, :order_details

  COMPLETE  = 'complete'
  PENDING   = 'pending'
  ERROR     = 'error'

  def order_details= order_details
    order_detail = order_details.last

    self.type               = order_detail[:type]
    self.price              = order_detail[:price]
    self.domain             = order_detail[:domain]
    self.period             = order_detail[:period]
    self.registrant_handle  = order_detail[:registrant_handle]
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

  def as_json options = nil
    {
      currency_code: 'USD',
      order_details: [
        {
          type:     self.type,
          domain:   self.domain,
          authcode: 'ABC123',
          period:   self.period,
          registrant_handle:  self.registrant_handle
        }
      ]
    }
  end

  def self.get_for_current_month month, year, token:
    site = Rails.configuration.api_url
    url = "#{site}/orders"
    params = {month: month, year: year}.to_query
    response = process_response HTTParty.get(url, query: params, headers: default_headers(token: token))

    response.map { |entry| new entry }
  end
end
