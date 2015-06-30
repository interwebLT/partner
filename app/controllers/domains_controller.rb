class DomainsController < SecureController
  def index
    @domains = Domain.all token: current_user.token
  end

  def show
    @domain = Domain.find params[:id], token: current_user.token
  end

  def renew
    @domain = Domain.find params[:domain_id], token: current_user.token

    @domain.renew(current_user.token)
    
    redirect_to domains_url
  end
end
