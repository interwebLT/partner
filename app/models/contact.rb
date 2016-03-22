class Contact
  include Api::Model
  include ActiveModel::Model

  attr_accessor :handle,
                :name, :organization, :street, :street2, :street3,
                :city, :state, :postal_code, :country_code,
                :local_name, :local_organization, :local_street, :local_street2, :local_street3,
                :local_city, :local_state, :local_postal_code, :local_country_code,
                :voice, :voice_ext, :fax, :fax_ext, :email

  validates :handle,              presence: true, length: { minimum: 1, maximum: 16 }
  validates :local_name,          presence: true, length: { minimum: 1, maximum: 100 }
  validates :local_organization,  presence: true, length: { minimum: 1, maximum: 100 }
  validates :local_street,        presence: true, length: { minimum: 1, maximum: 50 }
  validates :local_city,          presence: true, length: { minimum: 1, maximum: 50 }
  validates :local_country_code,  presence: true

  validates :voice, presence: true, length: { minimum: 8, maximum: 32 },
                                    format: { with: /^\+[0-9]{1,3}\.[0-9]{4,32}(?:x.+)?$/, multiline: true, message: 'Format is +cc.xxxxxxxxxx' }

  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }

  validates :local_postal_code, length: { minimum: 3, maximum: 10, allow_blank: true },
                                format: { with: /^[a-zA-Z0-9-]*$/, multiline: true, allow_blank: true }

  validates :fax, length: { minimum: 9, maximum: 32, allow_blank: true },
                  format: { with: /^\+[0-9]{1,3}\.[0-9]{4,32}(?:x.+)?$/, multiline: true, allow_blank: true }

  def self.generate_handle
    timestamp = '%10.6f' % Time.now.to_f
    handle = timestamp.sub('.', '')

    Rails.env.test? ? '123456789ABCDEF' : handle
  end

  def all token
    Contact.get Contact.url
  end

  def update token:
    if valid?
      update_params = as_json
      update_params.delete "handle"

      Contact.patch Contact.url(id: self.handle), update_params, token: token
      return true
    end
    return false
  end

  def save token:
    return false unless valid?

    begin
      Contact.post Contact.url, self.as_json, token: token

      return true
    rescue Api::Model::UnprocessableEntity
      self.errors.add :handle, 'already exists'

      return false
    end
  end

  def as_json options = nil
    {
      handle:             self.handle,
      local_name:         self.local_name,
      local_organization: self.local_organization,
      local_street:       self.local_street,
      local_street2:      (self.local_street2.blank?  ? nil : self.local_street2),
      local_street3:      (self.local_street3.blank?  ? nil : self.local_street3),
      local_city:         self.local_city,
      local_state:        (self.local_state.blank?  ? nil : self.local_state),
      local_postal_code:  (self.local_postal_code.blank?  ? nil : self.local_postal_code),
      local_country_code: self.local_country_code,
      voice:              self.voice,
      voice_ext:          (self.voice_ext.blank?  ? nil : self.voice_ext),
      fax:                (self.fax.blank?  ? nil : self.fax),
      fax_ext:            (self.fax_ext.blank?  ? nil : self.fax_ext),
      email:              self.email
    }
  end
end
