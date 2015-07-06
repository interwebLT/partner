class ContactsController < ApplicationController
  def update
    return_to = params[:contact].delete :domain

    contact = Contact.new params[:contact]
    contact.update current_user.token

    redirect_to domain_url(return_to)
  end
end
