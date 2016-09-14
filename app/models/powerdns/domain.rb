class Powerdns::Domain
  include Api::Model

  attr_accessor :id, :domain_id, :notified_serial, :name, :created_at, :updated_at
  @resource = "powerdns/domains"
end
