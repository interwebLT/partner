class DomainInfoPage < SitePrism::Page
  set_url '/domains/{id}'
  set_url_matcher %r{/domains/\d+}

  elements :domain_activities, '#domain_activities tbody tr'
  elements :domain_hosts, '#domain_hosts tbody tr'
end

def view_domain_info
  stub_get to: Domain.url(id: 1), returns: domain_info_response

  site.domain_info.load(id: 1)
end

def assert_domain_info_displayed
  site.domain_info.displayed?.must_equal true
  site.domain_info.domain_activities.count.must_equal 2
  site.domain_info.domain_hosts.count.must_equal 2
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
    registrant: {
      name: 'Registrant',
      organization: 'Organization',
      street: 'Street',
      street2: nil,
      street3: nil,
      city: 'City',
      state: 'State',
      postal_code: 1234,
      country_code: 'PH',
      email: 'contact@domain.ph',
      voice: '+63.2134567',
      fax: nil
    },
    registrant_handle: 'contact',
    admin_handle: nil,
    billing_handle: nil,
    tech_handle: nil,
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
