class CreditsController < ApplicationController
  def new
  end

  def create
    redirect_to partners_path
  end
end
