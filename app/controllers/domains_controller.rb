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
    @domain = Domain.find params[:id], token: current_user.token
    contact = Contact.new params[:contact]

    if contact.valid?
      contact.update token: current_user.token

      redirect_to @domain
    else
      @domain.set_registrant contact
      @show_edit  = true
      @nameserver = DomainHost.new

      render :show
    end
  end

  def renew
    @domain = Domain.find params[:domain_id], token: current_user.token

    begin
      @domain.renew(current_user.token)
    rescue Exception => ex
      flash[:alert] = ex.message
    end
    redirect_to domains_url
  end
end
