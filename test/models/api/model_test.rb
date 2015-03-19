require 'test_helper'

class Dummy
  include Api::Model

  attr_accessor :id, :name
end

class CustomResource
  include Api::Model

  self.resource = 'custom'

  attr_accessor :id, :name
end

describe Api::Model do
  describe :url do
    subject { Dummy.site }

    specify { Dummy.url.must_equal "#{subject}/dummies" }
    specify { Dummy.url(id: 1).must_equal "#{subject}/dummies/1" }
    specify { Dummy.url(id: 1, params: { foo: 'bar' }).must_equal "#{subject}/dummies/1?foo=bar" }
    specify { Dummy.url(params: { foo: 'bar' }).must_equal "#{subject}/dummies?foo=bar" }
  end

  describe :resource do
    subject { CustomResource.site }

    specify { CustomResource.url.must_equal "#{subject}/custom" }
  end

  describe :all do
    before do
      dummies = [
        {
          id: 1,
          name: 'One'
        },
        {
          id: 2,
          name: 'Two'
        }
      ]

      stub_request(:get, Dummy.url)
        .with(headers: default_headers)
        .to_return(body: dummies.to_json)
    end

    specify { Dummy.all(token: default_token).wont_be_empty }
  end

  private

  def default_token
    'abcd123456'
  end

  def default_headers
    { 'Authorization' => "Token token=#{default_token}" }
  end
end
