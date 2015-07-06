class ContactsController < ApplicationController
  def update
    return_to = params[:contact].delete :domain

    contact = Contact.new params[:contact]
    if contact.update current_user.token
      redirect_to domain_url(return_to)
    else
      redirect_to domain_url(return_to), alert: 'Invalid information entered'
    end
  end
end
