class DomainsPage < SitePrism::Page
  set_url '/domains'
  set_url_matcher /\/domains$/

  elements :domains, '#domains tbody tr'
  elements :renew_buttons, '#domains tbody tr td a .renew'

  section :header, HeaderSection, 'header'
end

def view_domains
  stub_get to: Domain.url, returns: domains_response

  site.domains.load
end

def renew_domain
  view_domains

  stub_get to: Domain.url(id: 1), returns: show_domain_response
  stub_renewal

  within first('#domains tbody tr') do
    click_on 'Renew'
  end
end

def assert_domains_displayed
  site.domains.displayed?.must_equal true

  site.domains.domains.count.must_equal 2
end

private

def stub_renewal
 stub_request(:post, "http://test.host/orders").
 #       with(:body => "{\"currency_code\":\"USD\",\"order_details\":[{\"type\":\"domain_renew\",\"domain\":\"domain.ph\",\"authcode\":null,\"period\":1,\"registrant_handle\":null,\"registered_at\":null,\"renewed_at\":\"2015-06-30T18:07:30.004+08:00\"}]}",
 #            :headers => {'Accept'=>'application/json', 'Authorization'=>'Token token=abcd123456', 'Content-Type'=>'application/json'}).
        to_return(:status => 200, :body =>       
        {
          type: 'domain_renew',
          price:  35.00,
          domain: 'domain.ph',
          object: nil,
          period: 1,
          renewed_at: '2015-02-14T01:01:00Z'
        }.to_json, 
        :headers => {})
end

def show_domain_response
  {
    id: 1,
    name: 'domain.ph',
    expires_at: DateTime.now,
    expired: false,
    registrant: {
      name: 'Registrant'
    }
  }
end

def domains_response
  [
    {
      id: 1,
      name: 'domain.ph',
      expires_at: DateTime.now,
      expired: false,
      registrant: {
        name: 'Registrant'
      }
    },
    {
      id: 2,
      name: 'domain.com.ph',
      expires_at: DateTime.now,
      expired: false,
      registrant: {
        name: 'Registrant'
      }
    }
  ]
end
