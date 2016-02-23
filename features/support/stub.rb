def stub_get to:, returns:
  if returns.is_a? Fixnum
    stub_request(:get, to).to_return(status: returns)
  else
    stub_request(:get, to).to_return(body: returns.to_json)
  end
end

def stub_post to:, returns:, with: nil
  request = stub_request :post, to

  default_headers = {
    'Authorization' => 'Token token=abcd123456',
    'Content-Type'  => 'application/json',
    'Accept'        => 'application/json'
  }

  request.with headers: default_headers, body: with.to_json if with

  if returns.is_a? Fixnum
    request.to_return status: returns
  else
    request.to_return status: 201, body: returns.to_json
  end
end

def stub_patch to:, returns:
  stub_request(:patch, to).to_return(status: 200, body: returns.to_json)
end
