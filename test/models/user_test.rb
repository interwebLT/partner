require 'test_helper'

describe User do
  describe :info do
    subject { User.info token: default_token }

    context :when_existing do
      before do
        stub_request(:get, User.url)
          .with(headers: default_headers)
          .to_return(body: current_user_response.to_json)
      end

      specify { subject.id.must_equal 1 }
      specify { subject.username.must_equal 'alpha' }
      specify { subject.token.must_equal 'abcd123456' }
      specify { subject.partner_name.must_equal 'alpha' }
      specify { subject.credits.must_equal 20.00 }
      specify { subject.staff.must_equal false }
    end

    context :when_not_existing do
      before do
        stub_request(:get, User.url).to_return(status: 404)
      end

      specify { subject.must_be_nil }
    end
  end

  describe :partner do
    subject { User.new token: default_token }

    before do
      stub_request(:get, User.partner_url)
        .with(headers: default_headers)
        .to_return(body: current_partner_response.to_json)
    end

    specify { subject.partner.id.must_equal 1 }
    specify { subject.partner.name.must_equal 'alpha' }
    specify { subject.partner.credits.must_equal 1000.00 }
  end

  private

  def current_user_response
    {
      id: 1,
      username: 'alpha',
      token: 'abcd123456',
      partner_name: 'alpha',
      credits: 20.00,
      staff: false
    }
  end

  def current_partner_response
    {
      id: 1,
      name: 'alpha',
      credits: 1000.00
    }
  end
end
