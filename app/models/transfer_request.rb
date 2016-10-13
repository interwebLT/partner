class TransferRequest
  include Api::Model
  
  RESOURCE_NAME = 'transfer_requests'
  
  attr_accessor :domain, :period, :auth_code
  
  def as_json options = nil
    {
      domain: domain,
      period: period,
      auth_code: auth_code
    }
  end
  
  def save token:
    save_url = TransferRequest.url resource: RESOURCE_NAME
    puts "save_url #{save_url}"
    response = self.class.post save_url, self.as_json, token: token

    !response.nil?
  rescue Api::Model::UnprocessableEntity
    false
  end
  
  def update token:
    puts "update_url #{url}"
    response = TransferRequest.patch url, "", token: token
    
    !response.nil?
  rescue Api::Model::UnprocessableEntity
    false
  end
  
  def delete token:
    puts "delete_url #{url}"
    response = TransferRequest.delete url, "", token: token
    
    !response.nil?
  rescue Api::Model::UnprocessableEntity
    false
  end

  private
  
  def url
    TransferRequest.url id: URI.encode(self.domain, /\W/), resource: RESOURCE_NAME
  end

end