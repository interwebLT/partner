class ContactsController < SecureController
  def index
    @contacts = Contact.all token: auth_token
  end

  def show
    @contact = Contact.find params[:id], token: auth_token
    @domain_id = params[:d]
    @domain = Domain.find params[:d], token: auth_token
  end

  def edit_multiple
    @contact = Contact.new

    unless params[:list].nil?
      @list_for_edit = params[:list].split.join(', ')
      list_for_edit = params[:list].split
      ids = []

      list_for_edit.each do |item|
        domain = Domain.search term: item, token: current_user.token
        if domain
          ids << domain.first.id
        end
      end
      params[:ids] = ids
    end
  end

  def update
    if params[:ids].nil?
      @contact = Contact.new contact_params
      @domain_id = params[:contact].delete :d

      if @contact.update token: auth_token
        redirect_to domain_path(@domain_id), notice: 'Contact was updated!'
      else
        render :show
      end
    else
      multiple_update_success = true
      domain_ids_list = params[:ids].split

      domain_ids_list.each do |domain_id|
        domain = Domain.find(domain_id, token: auth_token)
        handle = domain.registrant_handle

        @contact = Contact.new contact_params
        @contact.handle = handle
        @contact.update token: auth_token

        if @contact.update token: auth_token
        else
          multiple_update_success = false
          render :edit_multiple
          break
        end
      end

      if multiple_update_success
        redirect_to domains_path, notice: 'Multiple Domains updated!'
      end
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