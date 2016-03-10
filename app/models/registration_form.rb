class RegistrationForm
  include ActiveModel::Model

  attr_accessor :domain_name, :period, :registrant

  def initialize params = nil
    self.registrant = Contact.new

    params.delete(:registrant) if params

    super params
  end

  def errors
    self.registrant.errors
  end

  def method_missing method, *args
    self.registrant.send method, *args if self.registrant.respond_to? method
  end

  def save token:
    if self.registrant.save token: token
      order = Order.new create_order_request

      order.save token: token
    else
      false
    end
  end

  private

  def create_order_request
    {
      currency_code: 'USD',
      ordered_at: DateTime.now.iso8601,
      order_details: [
        {
          type: 'domain_create',
          domain:   self.domain_name,
          authcode: 'ABC123',
          period:   self.period.to_i,
          registrant_handle:  self.registrant.handle
        }
      ]
    }
  end
end
