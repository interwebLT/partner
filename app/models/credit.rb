class Credit
  include Api::Model

  attr_accessor :id, :partner_id, :partner, :credit_number, :amount, :credited_at, :created_at, :updated_at, :remarks, :type, :verification_code
  
  TRANSACTION_FEE = 0.05
  
  def to_json
    {
      type: type,
      partner: partner,
      amount: amount,
      credited_at: credited_at,
      amount_currency: 'USD',
      verification_code: verification_code,
      remarks: remarks
    }
  end

end

