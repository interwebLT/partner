class HostsController < SecureController
  def index
    @hosts = Host.all token: current_user.token
  end

  def show
    @host = Host.find params[:id], token: current_user.token
  end

  def get_host_address
    host = Host.search(term: params[:domain_host], token: current_user.token)
    host_addresses = host.host_addresses
    render json: host_addresses
  end
end
