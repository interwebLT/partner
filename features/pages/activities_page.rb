class ActivitiesPage < SitePrism::Page
  set_url '/activities'
  set_url_matcher /\/activities$/

  section :header, HeaderSection, 'header'

  elements :activities, '#activities tbody tr'
end

def view_activities
  stub_get to: ObjectActivity.url, returns: activities_response

  site.activities.load
end

def assert_activities_displayed
  site.activities.displayed?.must_equal true

  site.activities.header.menu_activities.present?.must_equal true
  site.activities.header.banner_title.text.must_equal 'Activities'

  site.activities.activities.count.must_equal 2
end

private

def activities_response
  [
    {
      id: 1,
      type: 'create',
      partner:     {
        id: 1,
        name: 'alpha',
        organization: 'Company',
        credits: 0.00,
        site: 'http://alpha.ph',
        nature: 'Alpha Business',
        representative: 'Alpha Guy',
        position: 'Position',
        street: 'Alpha Street',
        city: 'Alpha City',
        state: 'Alpha State',
        postal_code: '1234',
        country_code: 'PH',
        phone: '+63.1234567',
        fax: '+63.1234567',
        email: 'alpha@alpha.ph',
        local: true,
        admin: false
      },
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
      partner:     {
        id: 1,
        name: 'alpha',
        organization: 'Company',
        credits: 0.00,
        site: 'http://alpha.ph',
        nature: 'Alpha Business',
        representative: 'Alpha Guy',
        position: 'Position',
        street: 'Alpha Street',
        city: 'Alpha City',
        state: 'Alpha State',
        postal_code: '1234',
        country_code: 'PH',
        phone: '+63.1234567',
        fax: '+63.1234567',
        email: 'alpha@alpha.ph',
        local: true,
        admin: false
      },
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
  ]
end
