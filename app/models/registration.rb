class Registration
  include ActiveModel::Model

  attr_accessor :domain, :period, :registrant

  def initialize params = nil
    super params

    self.registrant ||= Contact.new
    self.registrant = Contact.new self.registrant if self.registrant.is_a? Hash

    self
  end
end
