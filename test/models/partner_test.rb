require 'test_helper'

describe Partner do
  describe :new do
    subject { Partner.new partner_info_response }

    specify { subject.id.must_equal 1 }
    specify { subject.name.must_equal 'alpha' }
    specify { subject.organization.must_equal 'Company' }
    specify { subject.credits.must_equal 1000.00 }
    specify { subject.site.must_equal 'http://alpha.ph' }
    specify { subject.nature.must_equal 'Business' }
    specify { subject.representative.must_equal 'Representative' }
    specify { subject.position.must_equal 'Position' }
    specify { subject.street.must_equal 'Street' }
    specify { subject.city.must_equal 'City' }
    specify { subject.state.must_equal 'State' }
    specify { subject.postal_code.must_equal '1234' }
    specify { subject.country_code.must_equal 'PH' }
    specify { subject.phone.must_equal '+63.21234567' }
    specify { subject.fax.must_equal '+63.21234567' }
    specify { subject.email.must_equal 'alpha@alpha.ph' }
    specify { subject.local.must_equal true }
    specify { subject.admin.must_equal false }

    specify { subject.default_nameservers.wont_be_empty }
    specify { subject.pricing.wont_be_empty }
  end

  describe :persisted? do
    specify { Partner.new(id: 1).persisted?.must_equal true }
    specify { Partner.new(id: nil).persisted?.must_equal false }
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
end
