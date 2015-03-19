class WelcomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to domains_path
    else
      flash.clear

      @welcome_page = true
    end
  end
end
