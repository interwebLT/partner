class RegisterController < SecureController
  before_filter :staff_only

  def new
  end

  def search
    redirect_to action: :registrant, domain_name: params[:domain_name]
  end

  def registrant
    @domain_name = params[:domain_name]

    @registrant = Contact.new
  end

  def create
    redirect_to register_path, notice: 'Domain Registered'
  end
end
