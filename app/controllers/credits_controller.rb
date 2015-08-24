class CreditsController < SecureController
  def new
  end

  def create
    partner = Partner.find params[:partner_id], token: current_user.token
    partner.replenish_credits params[:order][:amount], params[:order][:remarks], current_user.token
    redirect_to partners_path
  end
end
