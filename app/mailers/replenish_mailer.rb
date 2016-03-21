class ReplenishMailer < ActionMailer::Base
  default :from => '"dotPH Registrar" <registrar@dot.ph>'
  
  def receipt id: , token:
    @credit = Credit.find id, token: token
    @partner = Partner.find @credit.partner_id, token: token
    @amount = @credit.amount.money
    @transaction_fee = @amount * Credit::TRANSACTION_FEE
    @total = @amount + @transaction_fee

    
    mail to: @partner.email, subject: "Partner Top-up Payment Notice"
  end

end