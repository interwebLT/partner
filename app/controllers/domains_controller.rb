class DomainsController < SecureController
  def index
    if params[:search]
      @domains = Domain.search term: params[:search], token: current_user.token
    else
      @domains = Domain.all token: current_user.token
    end
  end

  def show
    @nameservers = Nameserver.all token: current_user.token
    @domain = Domain.find params[:id], token: current_user.token
  end

  def renew
    @domain = Domain.find params[:domain_id], token: current_user.token
    term = params[:renewal_term]
    begin
      @domain.renew(term, token: current_user.token) if @domain.renew_allowed?
    rescue Exception => ex
      flash[:alert] = ex.message
    end

    redirect_to domains_url
  end
end
