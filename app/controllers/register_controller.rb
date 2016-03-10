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

    unless domain_name.blank?
      @registration = RegistrationForm.new domain_name: domain_name
      @partner = current_user.partner
    else
      redirect_to register_path
    end
  end

  def create
    @registration = RegistrationForm.new params[:registration_form]

    if @registration.save token: current_user.token
      redirect_to register_path, notice: 'Domain Registered'
    elsif Contact.find @registration.registrant.handle, token: current_user.token
      redirect_to register_path, alert: 'Domain Already Registered!'
    else
      @partner = current_user.partner

      render :details
    end
  end
end
