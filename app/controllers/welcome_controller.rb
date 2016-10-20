class WelcomeController < ApplicationController
  
  skip_before_action :verify_authenticity_token, only: [:zendesk]
  
  def index
    if user_signed_in?
      redirect_to domains_path
    else
      flash.clear

      @welcome_page = true
    end
  end
  
end
