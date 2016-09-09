class Credit
  include Api::Model

  attr_accessor :id, :partner_id, :partner, :credit_number, :amount, :fee, :credited_at, :created_at, :updated_at, :remarks, :type, :verification_code

  TRANSACTION_FEE = 0.05
  PAYPAL_CODE = 'EC'
  CHECKOUT_CODE = 'pay_tok'

  def to_json
    {
      type: type,
      partner: partner,
      amount: amount,
      fee: (amount.money * TRANSACTION_FEE).format(:symbol => ''),
      credited_at: credited_at,
      amount_currency: 'USD',
      verification_code: verification_code,
      remarks: remarks
    }
  end

  def gateway
    if self.verification_code.blank?
      'Manual'
    elsif self.verification_code.starts_with? Credit::CHECKOUT_CODE
      'Checkout'
    elsif self.verification_code.starts_with? Credit::PAYPAL_CODE
      'Paypal'
    else
      'Unknown'
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

