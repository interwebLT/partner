class DomainHostsController < SecureController
  def create
    domain = Domain.find params[:domain_id], token: current_user.token

    host = DomainHost.new params[:domain_host]
    host.domain = domain
    host.save current_user.token

    redirect_to domain_url(domain.id)
  end

  def destroy
    domain  = params[:domain_id]
    host    = DomainHost.destroy domain, params[:id], token: current_user.token

    redirect_to domain_url(domain)
  end
end
