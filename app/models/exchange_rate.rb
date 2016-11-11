class ExchangeRate
  include Api::Model

  attr_accessor :id, :from_date, :to_date, :usd_rate, :currency, :created_at, :updated_at

  def self.get_current_rate date, token
    current_rate = ExchangeRate.search term: Date.today, token: token
    return current_rate
  end
end
