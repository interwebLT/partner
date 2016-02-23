class Dummy
  include Api::Model

  attr_accessor :id, :name
end

class CustomResource
  include Api::Model

  self.resource = 'custom'

  attr_accessor :id, :name
end

RSpec.describe Api::Model do
  let(:default_token) { 'abcd123456' }

  let(:default_headers) {
    { 'Authorization' => "Token token=#{default_token}" }
  }

  describe '.url' do
    subject { Dummy.url params }

    let(:params) {
      {}
    }

    it { is_expected.to eql 'http://test.host/dummies' }

    context 'when id is provided' do
      let(:params) {
        { id: 1 }
      }

      it { is_expected.to eql 'http://test.host/dummies/1' }
    end

    context 'when params is provided' do
      let(:params) {
        {
          params: {
            foo: 'bar'
          }
        }
      }

      it { is_expected.to eql 'http://test.host/dummies?foo=bar' }
    end

    context 'when id and params are provided' do
      let(:params) {
        {
          id: 1,
          params: {
            foo: 'bar'
          }
        }
      }

      it { is_expected.to eql 'http://test.host/dummies/1?foo=bar' }
    end
  end

  describe '.resource' do
    subject { CustomResource.url }

    it { is_expected.to eql 'http://test.host/custom' }
  end

  describe '.all' do
    subject { Dummy.all token: default_token }

    before do
      stub_request(:get, Dummy.url)
        .with(headers: default_headers)
        .to_return body: [{}].to_json
    end

    it { is_expected.not_to be_empty }
  end
end
