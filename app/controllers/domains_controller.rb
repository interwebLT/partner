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
    @registrant = @domain.registrant

    @nameserver = DomainHost.new
    @nameserver.domain = @domain
  end

  def update
    @domain = Domain.find params[:id], token: current_user.token
    @registrant = Contact.new params[:contact]

    if @registrant.valid?
      @registrant.update token: current_user.token

      redirect_to @domain
    else
      @show_edit  = true
      @nameserver = DomainHost.new

      render :show
    end
  end

  def renew
    @domain = Domain.find params[:domain_id], token: current_user.token

    begin
      @domain.renew token: current_user.token if @domain.renew_allowed?
    rescue Exception => ex
      flash[:alert] = ex.message
    end

    redirect_to domains_url
  end
end
