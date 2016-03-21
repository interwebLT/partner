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

  def order
    Order.new ordered_at:         DateTime.now,
              type:               'domain_create',
              domain:             self.domain_name,
              period:             self.period.to_i,
              registrant_handle:  self.registrant.handle
  end
end
