class ContactsController < ApplicationController
  def update
    return_to = params[:contact].delete :domain
    
    redirect_to domain_url(return_to)
  end
end
