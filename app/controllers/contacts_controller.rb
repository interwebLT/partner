class ContactsController < SecureController
  def index
    @contacts = Contact.all token: current_user.token
  end

  def show
    @contact = Contact.find params[:id], token: current_user.token
  end
end
