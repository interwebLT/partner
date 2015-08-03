class RegistrationController < SecureController
  def search
    reg = Registration.new current_user.partner, params[:name]

    unless reg.valid?
      redirect_to '/'
      return
    end
    session[:domain_to_register] = params[:name]

    redirect_to '/registration/create_contact'
  end

  def create_contact
    @contact = Contact.new
  end

  def confirm
    domain = session[:domain_to_register]

    @contact = Contact.new params[:contact]
    unless @contact.valid?
      render "create_contact"
      return
    end

    reg = Registration.new current_user.partner, domain
    unless reg.valid?
      redirect_to '/'
      return
    end

    @contact.save current_user.token
    reg.complete current_user.token, @contact.handle

    redirect_to '/'
  end
end