class Contact
  include Api::Model
  include ActiveModel::Model

  attr_accessor :handle,
                :name, :organization, :street, :street2, :street3,
                :city, :state, :postal_code, :country_code,
                :local_name, :local_organization, :local_street, :local_street2, :local_street3,
                :local_city, :local_state, :local_postal_code, :local_country_code,
                :voice, :voice_ext, :fax, :fax_ext, :email

  validates :local_name,  presence: true, length: { minimum: 1, maximum: 100 }
  validates :local_organization,  presence: true, length: { minimum: 1, maximum: 100 }
  validates :local_street,  presence: true, length: { minimum: 1, maximum: 50 }
  validates :local_city,  presence: true, length: { minimum: 1, maximum: 50 }
  validates :local_country_code,  presence: true

  validates :voice, presence: true, length: { minimum: 10, maximum: 32 },
                                    format: { with: /^\+[0-9]{1,3}\.[0-9]{4,32}(?:x.+)?$/, multiline: true, message: 'Format is +cc.xxxxxxxxxx' }

  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }

  validates :local_postal_code, length: { minimum: 3, maximum: 10, allow_blank: true },
                                format: { with: /^[a-zA-Z0-9-]*$/, multiline: true, allow_blank: true }

  validates :fax, length: { minimum: 10, maximum: 32, allow_blank: true },
                  format: { with: /^\+[0-9]{1,3}\.[0-9]{4,32}(?:x.+)?$/, multiline: true, allow_blank: true }

  def initialize(params=nil)
    super(params)
    unless params
      return
    end

    timestamp = '%10.6f' % Time.now.to_f
    timestamp.sub('.', '')

    unless params[:handle]
      self.handle = "PH#{timestamp}"[0...16]
    end
  end

  def all token
    Contact.get Contact.url
  end

  def update token:
    if valid?
      update_params = params
      update_params.delete "handle"

      Contact.patch Contact.url(id: self.handle), update_params, token: token
      return true
    end
    return false
  end

  def save token
    return false unless valid?

    begin
      Contact.post Contact.url, params, token: token

      return true
    rescue Api::Model::UnprocessableEntity
      self.errors.add :handle, 'already exists'

      return false
    end
  end

  def params
    json = self.as_json
    return json
  end
end
