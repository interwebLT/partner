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
end
