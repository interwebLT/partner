class RegisterController < SecureController
  before_filter :staff_only

  def new
  end

  def search
    domain_name = params[:domain_name]

    unless Domain.valid? domain_name
      redirect_to register_path, alert: 'Domain Not Valid'
      return
    end

    unless Domain.exists? domain_name, token: current_user.token
      redirect_to action: :registrant, domain_name: domain_name
    else
      redirect_to register_path, alert: 'Domain Not Available'
    end
  end

  def registrant
    @domain_name = params[:domain_name]

    unless @domain_name.blank?
      @registrant = Contact.new
    else
      redirect_to register_path
    end
  end

  def create
    @domain_name = params[:contact].delete :domain_name
    @registrant = Contact.new params[:contact]

    if @registrant.valid?
      redirect_to register_path, notice: 'Domain Registered'
    else
      render :registrant
    end
  end
end
