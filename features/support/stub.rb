def stub_get to:, returns:
  stub_request(:get, to).to_return(body: returns.to_json)
end

def stub_post to:, returns:
  stub_request(:post, to).to_return(status: 201, body: returns.to_json)
end

def stub_patch to:, returns:
  stub_request(:patch, to).to_return(status: 200, body: returns.to_json)
end
