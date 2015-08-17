class Registration
  include ActiveModel::Validations

  attr_accessor :domain, :partner, :token

  validate :validate_domain
  validate :domain_exists

  def initialize(token, partner, domain)
    self.token = token
    self.domain = domain
    self.partner = partner
  end

  def validate_domain
    unless valid_domain? domain
      errors.add :name, "invalid format on domain name"
    end
  end

  def domain_exists
    if Domain.exists? domain, token: token
      errors.add :name, "already exists"
    end
  end

  def complete handle
    create_order handle
  end

  private
    def create_order handle
      order = Order.new( {
        partner: nil,
        currency_code: 'USD'
      } )
      order.partner = partner

      detail = {
        type: 'domain_create',
        price: 70.00,
        domain: domain,
        authcode: 'dummy-code',
        period: 1,
        registrant_handle: handle
        }
      order.order_details = [detail]

      return order.save token
    end

    def valid_domain? (domain)
      # 3-63 characters, alphanumeric with optional dashes,
      valid_domain = /^[A-Za-z0-9][A-Za-z0-9\-]{2,62}(\.com|\.net|\.org)?\.ph$/
      has_consecutive_dash = /--/
      all_numeric = /^[0-9]+\..+$/

      return !(domain.nil? or domain.length == 0 or
               domain =~ has_consecutive_dash or
               domain =~ all_numeric or not
               domain =~ valid_domain)
    end

end
