class DomainHostsController < SecureController
  def index
    @domain_id = params[:domain_id]

    @domain_host = DomainHost.new
  end

  def add_default_nameservers
    domain = Domain.find params[:id], token: auth_token
    output = true

    if params[:dotph_default]
      nameservers = Nameserver.all token: auth_token
    else
      nameservers = current_user.partner.default_nameservers
    end

    domain.hosts.map{|host| DomainHost.destroy domain.name, host.name, token: auth_token}

    nameservers.each do |nameserver|
      @domain_host = DomainHost.new
      @domain_host.domain = domain.name
      @domain_host.name = nameserver.name

      if @domain_host.save token: auth_token
      else
        output = false
      end
    end

    if output
      if params[:dotph_default]
        redirect_to domain_url(domain.id), notice: 'DotPH Nameservers added!'
      else
        redirect_to domain_url(domain.id), notice: 'Partner Nameservers added!'
      end
    else
      @domain_id = domain.id
      render :index
    end
  end

  def create
    domain = Domain.find params[:domain_id], token: auth_token

    @domain_host = DomainHost.new create_params.merge(domain: domain.name)

    if @domain_host.save token: auth_token
      redirect_to domain_url(domain.id), notice: 'Nameserver added!'
    else
      @domain_id = domain.id

      render :index
    end
  end

  def destroy
    domain  = params[:domain_id]
    host    = DomainHost.destroy domain, params[:id], token: auth_token

    redirect_to domain_url(domain)
  end

  private

  def create_params
    params.require(:domain_host).permit :name
  end
end
