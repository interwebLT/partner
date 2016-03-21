class CreditsController < SecureController
  def new
  end

  def create
    unless is_number? params[:credit][:amount]
      flash[:message] = "Invalid amount"
      render :new
      return
    end

    if current_user.admin
      partner = Partner.find params[:partner_id], token: current_user.token
    else
      partner = current_user.partner
    end
    credit = if params[:verification_code].blank?
      partner.replenish_credits params[:credit][:amount], params[:credit][:remarks], current_user.token
    else
      partner.replenish_credits params[:credit][:amount], params[:credit][:remarks], current_user.token, 'card_credit', params[:verification_code]
    end
    flash[:notice] = "Replenish credit successful."

    ReplenishMailer.receipt(id: credit[:id], token: current_user.token).deliver_now
  
    redirect_to invoice_path :id => credit[:id]
  end

  private
    def is_number? string
      true if Float(string) rescue false
    end
end
