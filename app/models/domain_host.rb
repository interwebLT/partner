class DomainHost
  include Api::Model

  attr_accessor :id, :domain, :name, :created_at, :updated_at

  def save token
    DomainHost.post DomainHost.url(domain.name), to_json, token: token
  end

  def to_json
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
end
