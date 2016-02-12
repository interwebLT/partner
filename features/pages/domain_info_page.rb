class DomainInfoPage < SitePrism::Page
  set_url '/domains/{id}'
  set_url_matcher %r{/domains/\d+}

  elements :domain_activities, '#domain_activities tbody tr'
  elements :domain_hosts, '#domain_hosts tbody tr'

  section :registrant, ContactSection, '#registrant-contact-edit'
end

def view_domain_info
  stub_get to: Domain.url(id: 1), returns: domain_info_response

  site.domain_info.load(id: 1)
end

def assert_domain_info_displayed
  site.domain_info.displayed?.must_equal true
  site.domain_info.domain_activities.count.must_equal 3
  site.domain_info.domain_hosts.count.must_equal 2
end

def add_host
  stub_add_host

  within first('#new_domain_host') do
    fill_in 'domain_host_name', with: 'ns5.domains.ph'
    click_on 'Create Domain host'
  end
end

def stub_add_host
 stub_request(:post, "http://test.host/domains/domain.ph/hosts").
        to_return(:status => 200, :body =>
        {
          id: 67,
          name: "ns5.domains.ph",
          created_at: "2015-07-14T08:17:23.967Z",
          updated_at: "2015-07-14T08:17:23.967Z"
        }.to_json,
        :headers => {})
end

private

def domain_info_response
  {
    id: 1,
    zone: 'ph',
    name: 'domain.ph',
    partner: 'alpha',
    registered_at: '2014-01-01T00:00:00Z',
    expires_at: '2015-01-01T00:00:00Z',
    registrant_handle: 'registrant',
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
    admin_handle: 'admin',
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
    billing_handle: 'billing',
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
    tech_handle: 'tech',
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
        partner: partner,
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
        partner: partner,
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
      },
      {
        id: 3,
        partner: partner,
        type: 'transfer',
        activity_at: '2015-04-16T19:30:00Z',
        object: {
          id: 1,
          type: 'domain',
          name: 'domain.ph'
        },
        losing_partner: 'beta'
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

def partner
  {
    id: 1,
    name: 'alpha',
    organization: 'Alpha Partner',
    credits: 1000.00,
    local: true,
    admin: false
  }
end
