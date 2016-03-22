class RegisterController < SecureController
  before_filter :staff_only

  def new
  end

  def search
    domain_name = params[:domain_name].downcase

    unless Domain.valid? domain_name
      redirect_to register_path, alert: 'Domain Not Valid'
      return
    end

    unless Domain.exists? domain_name, token: current_user.token
      redirect_to action: :details, domain_name: domain_name
    else
      redirect_to register_path, alert: 'Domain Not Available'
    end
  end

  def details
    domain_name = params[:domain_name]
    period      = params[:period]
    handle      = params[:handle]

    if Domain.valid?(domain_name) and !Domain.exists?(domain_name, token: auth_token)
      @registration = RegistrationForm.new domain_name: domain_name
      @partner      = current_user.partner

      @registration.period = period unless period.blank?

      unless handle.blank?
        registrant = Contact.find handle, token: auth_token

        @registration.registrant = registrant if registrant
      end
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
    @registration = RegistrationForm.new
    @registration.domain_name = params[:domain_name]
    @registration.period      = params[:period]
    @registration.registrant  = Contact.find params[:handle], token: auth_token
  end

  def create_order
    registration = RegistrationForm.new registration_params

    if registration.order.save token: auth_token
      redirect_to register_path, notice: 'Domain Registered'
    else
      redirect_to register_path, alert: 'Domain Already Registered!'
    end
  end

  private

  REGISTRATION_FORM_FIELDS = [
    :domain_name, :period, :handle,
    :local_name, :local_organization, :local_street, :local_street2, :local_street3,
    :local_city, :local_state, :local_postal_code, :local_country_code,
    :voice, :voice_ext, :fax, :fax_ext, :email
  ]

  def registration_params
    params.require(:registration_form).permit(REGISTRATION_FORM_FIELDS)
  end
end
