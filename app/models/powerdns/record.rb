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

  def update token:
    if valid?
      update_params = self.as_json
      Powerdns::Record.patch Powerdns::Record.url(id: self.id), update_params, token: token
      return true
    end
    return false
  end
end
