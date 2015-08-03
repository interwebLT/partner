class DomainsController < SecureController
  def index
    if params[:search]
      @domains = Domain.search term: params[:search], token: current_user.token
    else
      @domains = Domain.all token: current_user.token
    end
  end

  def show
    @domain = Domain.find params[:id], token: current_user.token
    @nameserver = DomainHost.new
    @nameserver.domain = @domain
  end

  def update
  end

  def renew
    @domain = Domain.find params[:domain_id], token: current_user.token

    @domain.renew(current_user.token)
    
    redirect_to domains_url
  end
end
