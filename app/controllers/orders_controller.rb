class OrdersController < SecureController
  before_action :admin_only

  def index
    @orders = Order.all token: current_user.token
  end
end
