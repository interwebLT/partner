class HostsController < SecureController
  def index
    @hosts = Host.all token: current_user.token
  end

  def show
    @host = Host.find params[:id], token: current_user.token
  end
end
