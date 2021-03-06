class DomainsController < SecureController
  def index
    @domain_count = Domain.get_count token: current_user.token

    if params[:search]
      @domains = Domain.search term: params[:search].try(:strip), token: current_user.token
    else
      page = params[:activity_page].nil? ? 1 : params[:activity_page]
      @domains = Domain.get_paginated_domains_list page, token: current_user.token
    end
  end

  def paginated
    if params[:search]
      redirect_to domains_paginated_path(search_domain: params[:search].try(:strip))
    elsif params[:search_domain]
      @domains = Domain.search term: params[:search_domain].try(:strip), token: current_user.token
    else
      page = params[:domain_page].nil? ? 1 : params[:domain_page]
      @domains = Domain.get_paginated_domains_list page, token: current_user.token
    end
  end

  def show
    @partner_nameserver = current_user.partner.default_nameservers
    @nameservers = Nameserver.all token: current_user.token
    @domain      = Domain.find params[:id], token: current_user.token
    @status      = @domain.get_status.join(", ")
    @pdns_record = Powerdns::Record.new
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
    valid_second_level_domain = ["edu", "gov"]
    domain_array = domain.strip.split(".")

    if domain_array.last == "ph"
      if valid_second_level_domain.include?  domain_array[domain_array.length - 2]
        render json: "true".to_json
      else
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
      end
    else
      render json: "true".to_json
    end
  end

  def check_if_exists
    domains = params[:domain].split(',')
    valid = true
    existing_domain = ""
    domains.each do |domain|
      response = Domain.exists? domain.strip, token: current_user.token
      if response == true
        valid = false
        existing_domain = domain
        break
      end
    end
    if valid
      render json: valid.to_json
    else
      result = "Domain " + existing_domain + " already exists."
      render json: result.to_json
    end
  end

  def renewal_validation
    unless params[:domain_name].nil?
      domains = Domain.fetch term: params[:domain_name], token: current_user.token
      domain = domains.first
    end

    term   = params[:term].to_i
    exdate = domain.expires_at.to_date

    if (exdate + term.year - 1.day) > (Date.today + 10.year)
      render json: false
    else
      render json: true
    end
  end

  def partner_valid_domain
    domain_names = params[:list].split(" ")
    result = Domain.check_if_valid_partner_domain domain_names, token: current_user.token
    result = result == "true" ? true : result
    render json: result.to_json
  end
end
