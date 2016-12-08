class ReportsController < SecureController
  before_action :except_admin

  def index
    if params[:month].nil? && params[:year].nil?
      @date_display = Date.today
      @month = Date.today.month.to_s
      @year  = Date.today.year.to_s

      @credits  = Credit.get_for_current_month @month, @year, token: current_user.token
      @orders   = Order.get_for_current_month @month, @year, token: current_user.token
    else
      @date_display = Date.new params[:year].to_i, params[:month].to_i
      @month = params[:month]
      @year  = params[:year]

      @credits  = Credit.get_for_current_month @month, @year, token: current_user.token
      @orders   = Order.get_for_current_month @month, @year, token: current_user.token
    end
  end
end
