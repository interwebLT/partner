class ReportsController < SecureController
  before_action :except_admin

  def index
    @credits = Credit.all token: current_user.token
    @orders = Order.all token: current_user.token
  end
end
