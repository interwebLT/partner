class ContactsController < SecureController
  def update
    return_to = params[:contact].delete :domain

    contact = Contact.new params[:contact]
    if contact.valid?
      contact.update current_user.token
      redirect_to domain_url(return_to)
    else
      @domain = Domain.find return_to, token: current_user.token
      @domain.set_registrant contact

      @show_edit = true
      @nameserver = DomainHost.new

      render template: "domains/show"
      # redirect_to "#{domain_url(return_to)}#edit", alert: 'Invalid information entered', invalid_contact: contact
    end
  end

  def index
    @contacts = Contact.all token: current_user.token
  end

  def show
    @contact = Contact.find params[:id], token: current_user.token
  end
end
