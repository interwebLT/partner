class PartnerInfoPage < SitePrism::Page
  set_url '/partners/{id}'
  set_url_matcher %r{/partners/\d+}

  elements :default_nameservers, '#default_nameservers tbody tr'
  elements :pricing, '#pricing tbody tr'
end

def view_partner_info
  stub_get to: Partner.url(id: 1), returns: partner_info_response

  site.partner_info.load(id: 1)
end

def assert_partner_info_displayed
  site.partner_info.displayed?.must_equal true

  site.partner_info.default_nameservers.count.must_equal 2
  site.partner_info.pricing.count.must_equal 12
end

private

def partner_info_response
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
    pricing: [
      {
        id: 1,
        action: 'domain_create',
        period: 1,
        price: 35.00
      },
      {
        id: 2,
        action: 'domain_create',
        period: 2,
        price: 70.00
      },
      {
        id: 3,
        action: 'domain_create',
        period: 3,
        price: 105.00
      },
      {
        id: 4,
        action: 'domain_create',
        period: 4,
        price: 140.00
      },
      {
        id: 5,
        action: 'domain_create',
        period: 5,
        price: 175.00
      },
      {
        id: 6,
        action: 'domain_create',
        period: 6,
        price: 210.00
      },
      {
        id: 7,
        action: 'domain_create',
        period: 7,
        price: 245.00
      },
      {
        id: 8,
        action: 'domain_create',
        period: 8,
        price: 280.00
      },
      {
        id: 9,
        action: 'domain_create',
        period: 9,
        price: 315.00
      },
      {
        id: 10,
        action: 'domain_create',
        period: 10,
        price: 350.00
      },
      {
        id: 11,
        action: 'domain_renew',
        period: 1,
        price: 32.00
      },
      {
        id: 12,
        action: 'domain_renew',
        period: 2,
        price: 64.00
      }
    ]
  }
end
