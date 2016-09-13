class Credit
  include Api::Model

  attr_accessor :id, :partner_id, :partner, :credit_number, :amount, :fee, :credited_at, :created_at, :updated_at, :remarks, :type, :verification_code, :status
  
  TRANSACTION_FEE = 0.05
  PAYPAL_CODE = 'EC'
  CHECKOUT_CODE = 'pay_tok'
  
  BANK_CREDIT = 'bank_credit'
  CARD_CREDIT = 'card_credit'
  CHECKOUT_CREDIT = 'checkout_credit'
  PAYPAL_CREDIT = 'paypal_credit'
  DRAGON_PAY_CREDIT = 'dragon_pay_credit'
  
  def to_json
    {
      type: type,
      partner: partner,
      amount: amount,
      fee: self.fees_by_type,
      credited_at: credited_at,
      amount_currency: 'USD',
      verification_code: verification_code,
      remarks: remarks
    }
  end
  
  def self.credit_type verification_code
    if verification_code.blank?
      Credit::BANK_CREDIT
    elsif verification_code.starts_with? Credit::CHECKOUT_CODE
      Credit::CHECKOUT_CREDIT
    elsif verification_code.starts_with? Credit::PAYPAL_CODE
      Credit::PAYPAL_CREDIT
    else
      Credit::DRAGON_PAY_CREDIT
    end
  end
  
  def gateway
    if self.verification_code.blank?
      'Manual'
    elsif self.verification_code.starts_with? Credit::CHECKOUT_CODE
      'Checkout'
    elsif self.verification_code.starts_with? Credit::PAYPAL_CODE
      'Paypal'
    else
      'DragonPay'
    end
  end
  
  def fees_by_type
    if type == DRAGON_PAY_CREDIT
      ''
    else
      (amount.money * TRANSACTION_FEE).format(:symbol => '')
    end
  end

  def filter_included? month, year
    if month.empty? and year.empty?
      return true
    else
      included_month = self.credited_at.to_time.strftime("%m").to_i == month.to_i
      included_year  = self.credited_at.to_time.strftime("%Y").to_i == year.to_i

      if included_month and included_year
        return true
      else
        return false
      end
    end
  end
end

