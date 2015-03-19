require 'test_helper'

describe Authorization do
  describe :authenticate do
    subject { Authorization.authenticate 'username', 'password' }

    context :when_authenticated do
      before do
        stub_request(:post, Authorization.url)
          .to_return(body: { id: 1, token: 'abcd123456' }.to_json, status: 201)
      end

      specify { subject.id.must_equal 1 }
      specify { subject.token.must_equal 'abcd123456' }
    end

    context :when_authentication_fails do
      before do
        stub_request(:post, Authorization.url).to_return(status: 400)
      end

      specify { subject.must_be_nil }
    end
  end
end
