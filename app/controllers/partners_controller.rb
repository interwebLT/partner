class PartnersController < SecureController
  before_action :admin_only

  def index
    @partners = Partner.all token: current_user.token
  end

  def show
    @partner = Partner.find(params[:id], token: current_user.token)
  end
end
