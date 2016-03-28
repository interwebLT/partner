class DomainHost
  include Api::Model

  attr_accessor :id, :domain, :name, :created_at, :updated_at

  def as_json options = nil
    {
      name: name
    }
  end

  def self.url domain_id, id: nil
    super resource: "domains/#{domain_id}/hosts", id: id
  end

  def self.destroy domain_id, id, token:
    response = delete url(domain_id, id: id), {}, token: token

    new response
  end

  def save token:
    response = self.class.post self.class.url(self.domain), self.as_json, token: token

    !response.nil?
  rescue Api::Model::UnprocessableEntity
    false
  end
end
