class Powerdns::RecordsController < SecureController
  before_action :load_domain, only: [:new, :edit]

  def new
    @pdns_record = Powerdns::Record.new
  end

  def create
    pdns_record = Powerdns::Record.new pdns_params

    domain_id = params[:powerdns_record][:powerdns_domain_id]

    if pdns_record.save token: auth_token
      redirect_to domain_url(domain_id), notice: 'DNS Record added!'
    else
      redirect_to domain_url(domain_id), notice: 'Not Saved!'
    end
  end

  def edit
    @pdns_record = Powerdns::Record.find params[:id], token: auth_token
  end

  def update
    pdns_record = Powerdns::Record.find params[:id], token: auth_token
    domain_id = params[:domain_id]

    pdns_record.name = params[:powerdns_record][:name]
    pdns_record.type = params[:powerdns_record][:type]
    pdns_record.prio = params[:powerdns_record][:prio]
    pdns_record.content = params[:powerdns_record][:content]

    if pdns_record.update token: auth_token
      redirect_to domain_url(domain_id), notice: 'DNS Record updated!'
    else
      redirect_to domain_url(domain_id), notice: 'Not Updated!'
    end
  end

  def destroy
    domain = params[:domain_id]
    Powerdns::Record.destroy params[:id], token: auth_token
    redirect_to domain_url(domain)
  end

  private
  def pdns_params
    params.require(:powerdns_record).permit :name, :type, :prio, :content, :powerdns_domain_id,
                                            :ttl, :change_date
  end

  def load_domain
    @domain_id = params[:domain_id]
    @domain_name = Domain.find(@domain_id, token: auth_token).name
  end
end
