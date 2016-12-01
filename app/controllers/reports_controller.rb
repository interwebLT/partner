class ReportsController < SecureController
  before_action :except_admin

  def index
    if params[:month].nil? && params[:year].nil?
      @credits = Credit.all token: current_user.token
      @orders  = Order.all token: current_user.token
      @date_display = Date.today
      @month = Date.today.month.to_s
      @year  = Date.today.year.to_s
    else
      @credits  = Credit.all token: current_user.token
      @orders   = Order.all token: current_user.token
      @date_display = Date.new params[:year].to_i, params[:month].to_i
      @month = params[:month]
      @year  = params[:year]
    end
  end
end
