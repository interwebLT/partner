class ContactsController < SecureController
  def index
    @contacts = Contact.all token: auth_token
  end

  def show
    @contact = Contact.find params[:id], token: auth_token
    @domain_id = params[:d]
  end

  def update
    @contact = Contact.new contact_params
    @domain_id = params[:contact].delete :d

    if @contact.update token: auth_token
      redirect_to domain_path(@domain_id), notice: 'Contact was updated!'
    else
      render :show
    end
  end

  private

  def contact_params
    params.require(:contact).permit :handle, :local_name, :local_organization,
                                    :local_street, :local_street2, :local_street3,
                                    :local_city, :local_state, :local_postal_code, :local_country_code,
                                    :voice, :voice_ext, :fax, :fax_ext, :email
  end
end
