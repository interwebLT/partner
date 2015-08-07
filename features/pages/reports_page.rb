class ReportsPage < SitePrism::Page
  set_url '/reports'
  set_url_matcher /\/reports$/

  elements :orders, '#orders tbody tr'
  elements :credits, '#credits tbody tr'
end

def view_orders
  stub_get to: Order.url, returns: orders_response
  stub_get to: Credit.url, returns: credits_response

  site.reports.load
end

def assert_orders_displayed
  site.reports.displayed?.must_equal true

  site.reports.orders.count.must_equal 4
  site.reports.credits.count.must_equal 1
end

private

def orders_response
  [
    {
      id: 1,
      partner:     {
        id: 1,
        name: 'alpha',
        organization: 'Company',
        credits: 0.00,
        site: 'http://alpha.org',
        nature: 'Nature',
        representative: 'Representative',
        position: 'Position',
        street: 'Street',
        city: 'City',
        state: 'State',
        postal_code: '1234',
        country_code: 'PH',
        phone: '+63.21234567',
        fax: '+63.21234567',
        email: 'alpha@alpha.org',
        local: true,
        admin: false
      },
      order_number: 'ABCD123',
      total_price:  70.00,
      fee: 0.00,
      ordered_at: '2015-02-04T00:00:00Z',
      status: 'complete',
      currency_code: 'USD',
      order_details: [
        {
          type:   'domain_create',
          price:  70.00,
          domain: 'test.ph',
          authcode: 'ABC123',
          period: 2,
          registrant_handle: 'domains_registrant',
          registered_at: '2015-02-04T00:00:00Z'
        }
      ]
    },
    {
      id: 2,
      partner:     {
        id: 2,
        name: 'alpha',
        organization: 'Company',
        credits: 0.00,
        site: 'http://alpha.org',
        nature: 'Nature',
        representative: 'Representative',
        position: 'Position',
        street: 'Street',
        city: 'City',
        state: 'State',
        postal_code: '1234',
        country_code: 'PH',
        phone: '+63.21234567',
        fax: '+63.21234567',
        email: 'alpha@alpha.org',
        local: true,
        admin: false
      },
      order_number: 'ABCD124',
      total_price: 35.00,
      fee: 0.00,
      ordered_at: '2015-02-27T14:00:00Z',
      status: 'complete',
      currency_code: 'USD',
      order_details: [
        {
          type: 'domain_renew',
          price: 35.00,
          domain: 'test.ph',
          period: 1
        }
      ]
    },
    {
      id: 3,
      partner:     {
        id: 3,
        name: 'alpha',
        organization: 'Company',
        credits: 0.00,
        site: 'http://alpha.org',
        nature: 'Nature',
        representative: 'Representative',
        position: 'Position',
        street: 'Street',
        city: 'City',
        state: 'State',
        postal_code: '1234',
        country_code: 'PH',
        phone: '+63.21234567',
        fax: '+63.21234567',
        email: 'alpha@alpha.org',
        local: true,
        admin: false
      },
      order_number: 'ABCD125',
      total_price: 150.00,
      fee: 0.00,
      ordered_at: '2015-02-27T14:00:00Z',
      status: 'complete',
      currency_code: 'USD',
      order_details: [
        {
          type: 'credits',
          price: 150.00
        }
      ]
    },
    {
      id: 4,
      partner:     {
        id: 4,
        name: 'alpha',
        organization: 'Company',
        credits: 0.00,
        site: 'http://alpha.org',
        nature: 'Nature',
        representative: 'Representative',
        position: 'Position',
        street: 'Street',
        city: 'City',
        state: 'State',
        postal_code: '1234',
        country_code: 'PH',
        phone: '+63.21234567',
        fax: '+63.21234567',
        email: 'alpha@alpha.org',
        local: true,
        admin: false
      },
      order_number: 'ABCD126',
      total_price: 15.00,
      fee: 0.00,
      ordered_at: '2015-02-27T14:00:00Z',
      status: 'complete',
      currency_code: 'USD',
      order_details: [
        {
          type: 'domain_transfer',
          price: 15.00
        }
      ]
    }
  ]
end

def credits_response
  [
    {
      id: 1,
      partner:     {
        id: 1,
        name: 'alpha',
        organization: 'Company',
        credits: 0.00,
        site: 'http://alpha.org',
        nature: 'Nature',
        representative: 'Representative',
        position: 'Position',
        street: 'Street',
        city: 'City',
        state: 'State',
        postal_code: '1234',
        country_code: 'PH',
        phone: '+63.21234567',
        fax: '+63.21234567',
        email: 'alpha@alpha.org',
        local: true,
        admin: false
      },
      order_number: 1,
      credits: 150.00,
      credited_at: '2015-02-27T15:00:00Z',
      created_at: '2015-02-27T15:00:00Z',
      updated_at: '2015-02-27T15:00:00Z'
    }
  ]
end
