class GlobalWhois < Whois
  def self.url id: nil
    "#{Rails.configuration.x.whois_url}/#{id}"
  end
end
