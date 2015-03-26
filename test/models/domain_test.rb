require 'test_helper'

describe Domain do
  describe :new do
    subject { Domain.new get_response }

    specify { subject.id.must_equal 1 }
    specify { subject.zone.must_equal 'ph' }
    specify { subject.name.must_equal 'domain.ph' }
    specify { subject.partner.must_equal 'alpha' }
    specify { subject.registered_at.must_equal '2015-02-27 20:30'.in_time_zone }
    specify { subject.expires_at.must_equal '2017-02-27 20:30'.in_time_zone }
    specify { subject.expiring.must_equal false }
    specify { subject.expired.must_equal true }

    specify { subject.registrant.wont_be_nil }
    specify { subject.admin_contact.wont_be_nil }
    specify { subject.billing_contact.wont_be_nil }
    specify { subject.tech_contact.wont_be_nil }

    specify { subject.client_hold.must_equal false }
    specify { subject.client_delete_prohibited.must_equal false }
    specify { subject.client_renew_prohibited.must_equal false }
    specify { subject.client_transfer_prohibited.must_equal false }
    specify { subject.client_update_prohibited.must_equal false }

    specify { subject.activities.wont_be_empty }
    specify { subject.hosts.wont_be_empty }
  end

  describe :expired? do
    subject { Domain.new(expired: true) }

    specify { subject.expired?.must_equal true }
  end

  describe :expiring? do
    subject { Domain.new(expiring: true) }

    specify { subject.expiring?.must_equal true }
  end

  describe :find do
    subject { Domain.find id, token: default_token }

    before do
      domain_response = {
        id: 1,
        zone: 'ph',
        name: 'domain.ph',
        registered_at: Date.today,
        expires_at: 1.year.from_now,
        expired: false,
        expiring: false
      }

      stub_request(:get, Domain.url(id: id))
        .with(headers: default_headers)
        .to_return(body: domain_response.to_json)
    end

    let(:id) { 1 }

    specify {subject.name.must_equal 'domain.ph' }
  end

  describe :exists? do
    subject { Domain.exists? domain_name, token: default_token }

    before do
      stub_request(:get, Domain.url(params: { name: domain_name }))
        .with(headers: default_headers)
        .to_return(body: domain_response.to_json)
    end

    let(:domain_name) { 'domain.ph' }

    context :when_existing do
      let(:domain_response) { { name: domain_name } }

      specify { subject.must_equal true }
    end

    context :when_not_existing do
      let(:domain_response) { [] }

      specify { subject.must_equal false }
    end
  end

  describe :valid? do
    specify { Domain.valid?('domain-123.ph').must_equal true }
    specify { Domain.valid?('').must_equal false }
    specify { Domain.valid?('a.ph').must_equal false }
    specify { Domain.valid?('abcd123456789012345678901234567890123456789012345678901234567890.ph').must_equal false }
    specify { Domain.valid?('test-123-!@#$.ph').must_equal false }
    specify { Domain.valid?('domain123.com.ph').must_equal true }
    specify { Domain.valid?('domain123.net.ph').must_equal true }
    specify { Domain.valid?('domain123.org.ph').must_equal true }
    specify { Domain.valid?('a.com.ph').must_equal false }
    specify { Domain.valid?('com.ph').must_equal false }
    specify { Domain.valid?('org.ph').must_equal false }
    specify { Domain.valid?('net.ph').must_equal false }
    specify { Domain.valid?('mil.ph').must_equal false }
    specify { Domain.valid?('ngo.ph').must_equal false }
    specify { Domain.valid?('edu.ph').must_equal false }
    specify { Domain.valid?('gov.ph').must_equal false }
    specify { Domain.valid?('domain123.foo').must_equal false }
    specify { Domain.valid?('123.ph').must_equal false }
    specify { Domain.valid?('-domain123.ph').must_equal false }
    specify { Domain.valid?('domain--123.ph').must_equal false }
    specify { Domain.valid?(nil).must_equal false }
    specify { Domain.valid?('domain123').must_equal false }
  end

  private

  def get_response
    {
      id: 1,
      zone: 'ph',
      name: 'domain.ph',
      partner: 'alpha',
      registered_at: '2015-02-27T20:30:00Z',
      expires_at: '2017-02-27T20:30:00Z',
      registrant: {
        handle: 'registrant',
        name: 'Registrant',
        organization: 'Organization',
        street: 'Street',
        street2: nil,
        street3: nil,
        city: 'City',
        state: 'State',
        postal_code: '1234',
        country_code: 'PH',
        local_name: 'Registrant',
        local_organization: 'Organization',
        local_street: 'Street',
        local_street2: nil,
        local_street3: nil,
        local_city: 'City',
        local_state: 'State',
        local_postal_code: '1234',
        local_country_code: 'PH',
        voice: '+63.2134567',
        voice_ext: nil,
        fax: '+63.2134567',
        fax_ext: nil,
        email: 'registrant@domain.ph'
      },
      admin_contact: {
        handle: 'admin',
        name: 'Admin',
        organization: 'Organization',
        street: 'Street',
        street2: nil,
        street3: nil,
        city: 'City',
        state: 'State',
        postal_code: '1234',
        country_code: 'PH',
        local_name: 'Admin',
        local_organization: 'Organization',
        local_street: 'Street',
        local_street2: nil,
        local_street3: nil,
        local_city: 'City',
        local_state: 'State',
        local_postal_code: '1234',
        local_country_code: 'PH',
        voice: '+63.2134567',
        voice_ext: nil,
        fax: '+63.2134567',
        fax_ext: nil,
        email: 'admin@domain.ph'
      },
      billing_contact: {
        handle: 'billing',
        name: 'Billing',
        organization: 'Organization',
        street: 'Street',
        street2: nil,
        street3: nil,
        city: 'City',
        state: 'State',
        postal_code: '1234',
        country_code: 'PH',
        local_name: 'Billing',
        local_organization: 'Organization',
        local_street: 'Street',
        local_street2: nil,
        local_street3: nil,
        local_city: 'City',
        local_state: 'State',
        local_postal_code: '1234',
        local_country_code: 'PH',
        voice: '+63.2134567',
        voice_ext: nil,
        fax: '+63.2134567',
        fax_ext: nil,
        email: 'billing@domain.ph'
      },
      tech_contact: {
        handle: 'tech',
        name: 'Tech',
        organization: 'Organization',
        street: 'Street',
        street2: nil,
        street3: nil,
        city: 'City',
        state: 'State',
        postal_code: '1234',
        country_code: 'PH',
        local_name: 'Tech',
        local_organization: 'Organization',
        local_street: 'Street',
        local_street2: nil,
        local_street3: nil,
        local_city: 'City',
        local_state: 'State',
        local_postal_code: '1234',
        local_country_code: 'PH',
        voice: '+63.2134567',
        voice_ext: nil,
        fax: '+63.2134567',
        fax_ext: nil,
        email: 'tech@domain.ph'
      },
      client_hold: false,
      client_delete_prohibited: false,
      client_renew_prohibited: false,
      client_transfer_prohibited: false,
      client_update_prohibited: false,
      expiring: false,
      expired: true,
      activities: [
        {
          id: 1,
          type: 'create',
          activity_at: '2015-03-03T15:00:00Z',
          object: {
            id: 1,
            type: 'domain',
            name: 'domain.ph'
          }
        },
        {
          id: 2,
          type: 'update',
          activity_at: '2015-03-03T15:00:00Z',
          object: {
            id: 1,
            type: 'domain',
            name: 'domain.ph'
          },
          property_changed: 'name',
          old_value: 'old_name',
          new_value: 'new_name'
        }
      ],
      hosts: [
        {
          id: 1,
          name: 'ns3.domains.ph',
          created_at: '2015-03-04T18:00:00Z',
          updated_at: '2015-03-04T18:00:00Z'
        },
        {
          id: 2,
          name: 'ns4.domains.ph',
          created_at: '2015-03-04T18:00:00Z',
          updated_at: '2015-03-04T18:00:00Z'
        }
      ]
    }
  end
end
