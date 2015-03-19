class DomainsPage < SitePrism::Page
  set_url '/domains'
  set_url_matcher /\/domains$/

  elements :domains, '#domains tbody tr'

  section :header, HeaderSection, 'header'
end

def view_domains
  stub_get to: Domain.url, returns: domains_response

  site.domains.load
end

def assert_domains_displayed
  site.domains.displayed?.must_equal true

  site.domains.domains.count.must_equal 2
end

private

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
