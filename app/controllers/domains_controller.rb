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

  def renew_multiple
    domain_names = params[:list].split
    domain_id = []

    if domain_names
      domain_names.each do |domain_name|
        domain = Domain.search term: domain_name.strip, token: current_user.token
        domain_id << domain.first.id
      end
    end

    redirect_to action: :renew, domain_id: domain_id.join(","),
      renewal_term: params[:renewal_term], bulk: true
  end

  def renew
    domain_ids = params[:domain_id].split(',')
    renew_saved = true
    renewal_index = 0

    domain_ids.each do |domain_id|
      @domain = Domain.find domain_id, token: current_user.token
      if params[:bulk]
        term = params[:renewal_term][renewal_index.to_s]
      else
        term = params[:renewal_term]
      end

      begin
        @domain.renew(term, token: current_user.token) if @domain.renew_allowed?
        renewal_index += 1
      rescue Exception => ex
        renew_saved = false
        break
        flash[:alert] = ex.message
      end
    end

    if renew_saved
      redirect_to domains_url, notice: "Domain(s) successfully renewed!"
    end
  end
end
