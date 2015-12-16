class Credit
  include Api::Model

  attr_accessor :id, :partner, :credit_number, :amount, :credited_at, :created_at, :updated_at, :remarks, :type, :verification_code
  
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

