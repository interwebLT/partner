class CreditsController < SecureController
  def new
  end

  def create
    unless is_number? params[:order][:amount]
      flash[:message] = "Invalid amount"
      render :new
      return
    end

    if current_user.admin
      partner = Partner.find params[:partner_id], token: current_user.token
    else
      partner = current_user.partner
    end
    partner.replenish_credits params[:order][:amount], params[:order][:remarks], current_user.token
    redirect_to partners_path
  end

  private
    def is_number? string
      true if Float(string) rescue false
    end
end
