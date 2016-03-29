class Whois
  include Api::Model

  attr_accessor :name

  def self.url id: nil
    "#{Rails.configuration.x.whois_url}/#{id}"
  end
end
