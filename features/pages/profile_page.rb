class ProfilePage < SitePrism::Page
  set_url '/profile'
  set_url_matcher /profile/

  elements :default_nameservers, '#default_nameservers tbody tr'
end

def view_current_partner
  stub_get to: User.partner_url, returns: current_partner_response

  site.profile.load
end

def assert_current_partner_info_displayed
  site.profile.displayed?.must_equal true

  site.profile.default_nameservers.count.must_equal 2
end

private

def current_partner_response
  {
    id: 1,
    name: 'alpha',
    organization: 'Company',
    credits: 1000.00,
    site: 'http://alpha.ph',
    nature: 'Business',
    representative: 'Representative',
    position: 'Position',
    street: 'Street',
    city: 'City',
    state: 'State',
    postal_code: '1234',
    country_code: 'PH',
    phone: '+63.21234567',
    fax: '+63.21234567',
    email: 'alpha@alpha.ph',
    local: true,
    admin: false,
    default_nameservers: [
      {
        name: 'ns3.domains.ph'
      },
      {
        name: 'ns4.domains.ph'
      }
    ],
    pricing: []
  }
end
