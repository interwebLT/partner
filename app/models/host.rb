class Host
  include Api::Model

  attr_accessor :id, :name, :partner, :host_addresses, :created_at, :updated_at

  def all token
    Host.get Host.url
  end

  def host_addresses= addresses
    @host_addresses = addresses.collect { |add| HostAddress.new add }
  end

  def self.search(term:,token:)
    response = get url, {search: term}, token: token
    host = Host.new response
  end
end