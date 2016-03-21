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
    @registration = RegistrationForm.new params[:registration_form]

    if @registration.registrant.save token: auth_token
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
    registration = RegistrationForm.new params[:registration_form]

    if registration.order.save token: auth_token
      redirect_to register_path, notice: 'Domain Registered'
    else
      redirect_to register_path, alert: 'Domain Already Registered!'
    end
  end
end
