class ExchangeRate
  include Api::Model

  attr_accessor :id, :from_date, :to_date, :usd_rate, :currency, :created_at, :updated_at
end
