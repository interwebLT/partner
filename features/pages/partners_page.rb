class PartnersPage < SitePrism::Page
  set_url '/partners/'
  set_url_matcher /\/partners/

  elements :partners, '#partners tbody tr'
end

def view_partners
  stub_get to: Partner.url, returns: partners_response

  site.partners.load
end

def assert_partners_displayed
  site.partners.displayed?.must_equal true

  site.partners.partners.count.must_equal 3
end

private

def partners_response
  [
    {
      id: 1,
      name: 'alpha',
      organization: 'Alpha Partner',
      credits: 1000.00,
      local: true,
      admin: false
    },
    {
      id: 2,
      name: 'beta',
      organization: 'Beta Partner',
      credits: 0.00,
      local: false,
      admin: false
    },
    {
      id: 3,
      name: 'admin',
      organization: 'Administrator',
      credits: 0.00,
      local: true,
      admin: true
    }
  ]
end
