class DomainsController < SecureController
  def index
    @domains = Domain.all token: current_user.token
  end

  def show
    @domain = Domain.find params[:id], token: current_user.token
  end
end
