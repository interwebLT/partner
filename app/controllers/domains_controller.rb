class DomainsController < SecureController
  def index
    if params[:search]
      @domains = Domain.search term: params[:search], token: current_user.token
    else
      @domains = Domain.all token: current_user.token
    end
    @domain_count = @domains.count
    @domains = @domains.paginate page: params[:page], per_page: 20
  end

  def show
    @partner_nameserver = current_user.partner.default_nameservers
    @nameservers = Nameserver.all token: current_user.token
    @domain = Domain.find params[:id], token: current_user.token
    @status = @domain.get_status.join(", ")
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

  def check_ns_authorization
    domain  = params[:domain]
    partner = current_user.username
    host    = params[:host]

    if domain.strip.split(".").include?("ph")
      response = Domain.check_ns_authorization domain, partner, host, current_user.token

      unless response
        result = "Host cannot be created because domain is owned by a different registrar."
        render json: result.to_json
      else
        exist = Domain.exists? domain.strip, token: current_user.token
        unless exist
          result = "Host cannot be created because domain does not exist."
          render json: result.to_json
        else
          render json: exist.to_json
        end
      end
    else
      render json: "true".to_json
    end
  end

  def check_if_exists
    domains = params[:domain].split(',')
    valid = true
    domains.each do |domain|
      response = Domain.exists? domain.strip, token: current_user.token
      if response == true
        valid = false
        break
      end
    end
    render json: valid.to_json
  end
end
