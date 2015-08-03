class Contact
  include Api::Model
  include ActiveModel::Model

  attr_accessor :handle,
                :name, :organization, :street, :street2, :street3,
                :city, :state, :postal_code, :country_code,
                :local_name, :local_organization, :local_street, :local_street2, :local_street3,
                :local_city, :local_state, :local_postal_code, :local_country_code,
                :voice, :voice_ext, :fax, :fax_ext, :email

  validates_presence_of :name, :organization, :street, :city, :country_code, :voice, :email

  validates_format_of :postal_code, with: /^[a-zA-Z0-9-]*$/, multiline: true, allow_blank: true
  validates_format_of :voice, with: /^\+[0-9]{1,3}\.[0-9]{4,32}(?:x.+)?$/, multiline: true
  validates_format_of :fax, with: /^\+[0-9]{1,3}\.[0-9]{4,32}(?:x.+)?$/, multiline: true, allow_blank: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  validates_length_of :name, :organization, minimum: 1, maximum: 100
  validates_length_of :street, :city, minimum: 1, maximum: 50
  validates_length_of :postal_code, minimum: 3, maximum: 10, allow_blank: true
  validates_length_of :voice, minimum: 10, maximum: 32
  validates_length_of :fax, minimum: 10, maximum: 32, allow_blank: true

  def all token
    Contact.get Contact.url
  end

  def update token
    if valid?
      Contact.patch Contact.url(id: self.handle), params, token: token
      return true
    end
    return false
  end

  def save token
    if valid?
      Contact.post Contact.url(id: self.handle), params, token: token
      return true
    end
    return false
  end

  def params
    json = self.as_json 
    json.delete "handle"
    return json
  end
end
