class TransferRequest
  include Api::Model
  
  RESOURCE_NAME = 'transfer_requests'
  
  REQUEST_PERIOD = {
    '01'  => '1 year',
    '02'  => '2 years',
    '03'  => '3 years',
    '04'  => '4 years',
    '05'  => '5 years',
    '06'  => '6 years',
    '07'  => '7 years',
    '08'  => '8 years',
    '09'  => '9 years',
    '10' => '10 years'
  }
  
  attr_accessor :id, :domain, :period, :auth_code, :response_message
  
  def as_json options = nil
    {
      domain: domain,
      period: period,
      auth_code: auth_code
    }
  end
  
  def save token:
    save_url = TransferRequest.url resource: RESOURCE_NAME
    response = self.class.post save_url, self.as_json, token: token
    
    !response.nil?
  rescue Api::Model::UnprocessableEntity => e
    @response_message = e.message
    false
  end
  
  def update token:
    response = TransferRequest.patch url, "", token: token
    
    !response.nil?
  rescue Api::Model::UnprocessableEntity =>e
    @response_message = e.message
    false
  end
  
  def delete token:
    response = TransferRequest.delete url, "", token: token
    
    !response.nil?
  rescue Api::Model::UnprocessableEntity => e
    @response_message = e.message
    false
  end

  private
  
  def url
    TransferRequest.url id: self.id, resource: RESOURCE_NAME
  end

end