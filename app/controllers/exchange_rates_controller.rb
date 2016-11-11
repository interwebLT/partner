class ExchangeRatesController < SecureController
  def get_current_rate
    @current_rate = ExchangeRate.search term: Date.today, token: current_user.token
  end
end