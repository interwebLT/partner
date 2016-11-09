class Powerdns::RecordsController < SecureController
  before_action :load_domain, only: [:new, :edit]
  before_action :set_type, only: [:create, :update]

  def new
    @pdns_record = Powerdns::Record.new
  end

  def create
    pdns_record = Powerdns::Record.new pdns_params

    domain_id   = params[:powerdns_record][:powerdns_domain_id]
    domain      = Domain.find domain_id, token: auth_token
    domain_name = domain.name

    if pdns_record.name.empty?
      pdns_record.name = domain_name
    else
      pdns_record.name = pdns_record.name + ".#{domain_name}"
    end

    if pdns_record.save token: auth_token
      @domain      = Domain.find domain_id, token: auth_token
      @nameservers = Nameserver.all token: current_user.token
    else
      redirect_to domain_url(domain_id), notice: 'Not Saved!'
    end
  end

  def edit
    @pdns_record = Powerdns::Record.find params[:id], token: auth_token
    @subdomain = @pdns_record.name
    if @subdomain == @domain_name
      @subdomain.slice!(@domain_name)
    else
      @subdomain.slice!(".#{@domain_name}")
    end
  end

  def update
    pdns_record = Powerdns::Record.find params[:id], token: auth_token
    domain_id = params[:domain_id]
    update_record pdns_record, domain_id
  end

  def destroy
    domain = params[:domain_id]
    Powerdns::Record.destroy params[:id], token: auth_token
    @domain      = Domain.find domain, token: auth_token
    @nameservers = Nameserver.all token: current_user.token
  end

  def check_if_exists
    name        = params[:name]
    content     = params[:content]
    type        = params[:type]
    ttl         = params[:ttl]
    srv_port    = params[:srv_port]
    srv_weight  = params[:srv_weight]
    srv_content = params[:srv_content]

    valid = Powerdns::Record.check_if_exists name, content, type, ttl, srv_port, srv_weight, srv_content, auth_token
    # render json: valid
    if !valid
      result = "Record Already Exists."
      render json: result.to_json
    else
      render json: "true".to_json
    end
  end

  private
  def pdns_params
    params.require(:powerdns_record).permit :name, :type, :prio, :content, :powerdns_domain_id, :end_date,
                                            :ttl, :change_date, preferences: [:weight, :port, :srv_content]
  end

  def update_record pdns_record, domain_id
    domain      = Domain.find domain_id, token: auth_token
    domain_name = domain.name

    if params[:powerdns_record][:name].empty?
      pdns_record.name = domain_name
    else
      pdns_record.name = params[:powerdns_record][:name] + ".#{domain_name}"
    end

    pdns_record.type    = params[:powerdns_record][:type]
    pdns_record.prio    = params[:powerdns_record][:prio]
    pdns_record.ttl     = params[:powerdns_record][:ttl]
    pdns_record.content = params[:powerdns_record][:content]
    unless pdns_record.preferences.nil?
      pdns_record.preferences[:weight]       = params[:powerdns_record][:preferences][:weight]
      pdns_record.preferences[:port]         = params[:powerdns_record][:preferences][:port]
      pdns_record.preferences[:srv_content]  = params[:powerdns_record][:preferences][:srv_content]
    end

    if pdns_record.update token: auth_token
      @domain      = Domain.find domain_id, token: auth_token
      @nameservers = Nameserver.all token: current_user.token
      # redirect_to domain_url(domain_id), notice: 'DNS Record updated!'
    else
      redirect_to domain_url(domain_id), notice: 'Not Updated!'
    end
  end

  def load_domain
    domain = Domain.find(params[:domain_id], token: auth_token)
    @domain_id = domain.id
    @domain_name = domain.name
    @domain_expires_at = domain.expires_at
    @powerdns_records = domain.powerdns_records.map{|record| record.name}
  end

  def set_type
    unless params[:powerdns_record][:type] == "SRV"
      params[:powerdns_record][:preferences] = nil
    end
  end
end
