class Dummy
  include Api::Model

  attr_accessor :id, :name

  def as_json options = nil
    {
      name: name
    }
  end
end

class CustomResource
  include Api::Model

  self.resource = 'custom'

  attr_accessor :id, :name
end

RSpec.describe Api::Model do
  let(:default_token) { 'abcd123456' }

  let(:default_headers) {
    {
      'Authorization' => "Token token=#{default_token}",
      'Content-Type'  => 'application/json',
      'Accept'        => 'application/json'
    }
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

  describe '.post' do
    subject { Dummy.post 'http://test.host/dummies', {}, token: default_token }

    let(:status) { 201 }

    before do
      stub_request(:post, Dummy.url)
        .with(headers: default_headers, body: {})
        .to_return status: status, body: {}.to_json
    end

    it { is_expected.to eql({}) }

    context 'when response code is 422' do
      let(:status)  { 422 }

      it { expect { subject }.to raise_error Api::Model::UnprocessableEntity }
    end
  end

  describe '.find' do
    subject { Dummy.find 1, token: default_token }

    let(:status) { 200 }

    before do
      stub_request(:get, Dummy.url(id: 1))
        .with(headers: default_headers)
        .to_return status: status, body: {}.to_json
    end

    it { is_expected.not_to be nil }

    context 'when response code is 404' do
      let(:status)  { 404 }

      it { expect { subject }.to raise_error Api::Model::NotFound }
    end
  end

  describe '#save' do
    subject do
      dummy = Dummy.new

      dummy.save token: token
    end

    let(:headers) {
      {
        'Authorization' => 'Token token=ABC123',
        'Content-Type'  => 'application/json',
        'Accept'        => 'application/json'
      }
    }

    let(:token) { 'ABC123' }

    before do
      stub_request(:post, Dummy.url)
        .with(headers: headers, body: 'dummies/post_request'.body)
        .to_return status: status, body: {}.to_json
    end

    context 'when response code is 200' do
      let(:status) { 200 }

      it { is_expected.to be true }
    end

    context 'when response code is 422' do
      let(:status) { 422 }

      it { is_expected.to be false }
    end
  end
end
