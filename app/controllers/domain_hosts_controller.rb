class DomainHostsController < SecureController
  def index
    @domain_id = params[:domain_id]

    @domain_host = DomainHost.new
  end

  def create
    domain = Domain.find params[:domain_id], token: auth_token

    domain_host = DomainHost.new create_params.merge(domain: domain.name)
    domain_host.save token: auth_token

    redirect_to domain_url(domain.id)
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
