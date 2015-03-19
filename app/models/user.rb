class User
  include Api::Model
  extend Devise::Models

  define_model_callbacks :validation

  devise :api_authenticatable

  attr_accessor :id, :username, :password, :token, :partner_id, :partner_name, :credits, :transactions_allowed, :admin, :staff

  def self.url id = nil
    super id: id, resource: 'user'
  end

  def self.partner_url
    url + '/partner'
  end

  def self.authenticate username, password
    authorization = Authorization.authenticate username, password

    info(token: authorization.token) if authorization
  end

  def self.info(token:)
    begin
      new get url, token: token
    rescue Api::Model::NotFound
      nil
    end
  end

  def partner
    Partner.new self.class.get self.class.partner_url, token: token
  end
end
