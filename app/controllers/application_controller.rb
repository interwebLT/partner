class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from Api::Model::NotFound, with: :resource_not_found

  private

  def resource_not_found
    redirect_to root_path, alert: 'Resource not found.'
  end
end
