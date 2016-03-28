class RegisterController < SecureController
  before_filter :staff_only

  def new
  end

  def search
    domain_name = params[:domain_name].downcase

    if !Domain.valid? domain_name
      redirect_to register_path, alert: 'Domain Not Valid'
    elsif !Domain.exists? domain_name, token: auth_token
      redirect_to action: :details, domain_name: domain_name
    else
      redirect_to register_path, alert: 'Domain Not Available'
    end
  end

  def details
    @registration = RegistrationForm.new request_params
    @registration.registrant = registrant if @registration.handle

    if !Domain.valid? @registration.domain_name
      redirect_to register_path
    elsif !Domain.exists? @registration.domain_name, token: auth_token
      @partner = current_user.partner
    else
      redirect_to register_path
    end
  end

  def create_registrant
    @registration = RegistrationForm.new registration_params

    if @registration.save_registrant token: auth_token
      redirect_to action: :summary, domain_name:  @registration.domain_name,
                                    period:       @registration.period,
                                    handle:       @registration.registrant.handle
    else
      @partner = current_user.partner

      render :details
    end
  end

  def summary
    @registration = RegistrationForm.new request_params
    @registration.registrant = registrant if @registration.handle

    if !Domain.valid? @registration.domain_name
      redirect_to register_path
    elsif Domain.exists? @registration.domain_name, token: auth_token
      redirect_to register_path
    elsif !@registration.valid?
      redirect_to action: :details, domain_name:  @registration.domain_name,
                                    period:       @registration.period,
                                    handle:       @registration.handle
    else
      @partner = current_user.partner
    end
  end

  def create_order
    registration = RegistrationForm.new registration_params

    if registration.order.save token: auth_token
      current_user.partner.default_nameservers.each do |nameserver|
        domain_host = DomainHost.new  domain: registration.domain_name,
                                      name:   nameserver.name

        domain_host.save token: auth_token
      end

      redirect_to register_path, notice: 'Domain Registered'
    else
      redirect_to register_path, alert: 'Domain Already Registered!'
    end
  end

  private

  def registration_params
    params.require(:registration_form).permit :domain_name, :period, :handle,
                                              :local_name, :local_organization, :local_street, :local_street2, :local_street3,
                                              :local_city, :local_state, :local_postal_code, :local_country_code,
                                              :voice, :voice_ext, :fax, :fax_ext, :email
  end

  def request_params
    params.permit :domain_name, :period, :handle
  end

  def registrant
    registrant = Contact.find params[:handle], token: auth_token

    registrant.nil? ? Contact.new : registrant
  end
end
