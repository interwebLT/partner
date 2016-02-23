class RegisterController < SecureController
  before_filter :staff_only

  def new
  end

  def search
    unless Domain.exists? params[:domain_name], token: current_user.token
      redirect_to action: :registrant, domain_name: params[:domain_name]
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
    redirect_to register_path, notice: 'Domain Registered'
  end
end
