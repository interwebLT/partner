class Powerdns::Record
  include Api::Model

  attr_accessor :id, :powerdns_domain_id, :name, :type, :content, :ttl, :start_date, :end_date,
                :active, :prio, :change_date, :created_at, :updated_at, :preferences

  @resource = "powerdns/records"

  def self.url id: nil
    super resource: @resource, id: id
  end

  def self.destroy id, token:
    response = delete url(id: id), {}, token: token

    new response
  end

  def self.check_if_exists name, content, type, ttl ,srv_port, srv_weight, srv_content, token
    site = Rails.configuration.api_url
    url = "#{site}/powerdns/records"
    params = {name: name, content: content, type: type, ttl: ttl, srv_port: srv_port, srv_weight: srv_weight, srv_content: srv_content}.to_query
    response =  HTTParty.get(url, query: params, headers: default_headers(token: token)).parsed_response
    return response
  end

  def update token:
    if valid?
      update_params = self.as_json
      Powerdns::Record.patch Powerdns::Record.url(id: self.id), update_params, token: token
      return true
    end
    return false
  end
end
