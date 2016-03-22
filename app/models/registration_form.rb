class RegistrationForm
  include ActiveModel::Model

  attr_accessor :domain_name, :period, :registrant

  validates :domain_name, presence: true

  validate  :domain_name_must_be_valid,
            :registrant_has_valid_fields

  def initialize params = nil
    self.registrant = Contact.new

    params.delete(:registrant) if params

    super params
  end

  def method_missing method, *args
    self.registrant.send method, *args if self.registrant.respond_to? method
  end

  def save_registrant token:
    result = self.registrant.save token: token

    copy_registrant_errors

    result
  end

  def order
    Order.new ordered_at:         DateTime.now,
              type:               'domain_create',
              domain:             self.domain_name,
              period:             self.period.to_i,
              registrant_handle:  self.registrant.handle
  end

  private

  def domain_name_must_be_valid
    errors.add :domain_name, 'is not valid' unless Domain.valid? domain_name
  end

  def registrant_has_valid_fields
    self.registrant.valid?

    copy_registrant_errors
  end

  def copy_registrant_errors
    self.registrant.errors.each do |error|
      self.registrant.errors[error].each do |message|
        errors.add error, message
      end
    end
  end
end
