class DomainHost
  include Api::Model

  attr_accessor :id, :domain, :name, :created_at, :updated_at

  def save token
    p token
    DomainHost.post DomainHost.url(domain.name), to_json, token: token
  end

  def to_json
    {
      name: name
    }
  end

  def self.url domain_id
    super resource: "domains/#{domain_id}/hosts"
  end
end
