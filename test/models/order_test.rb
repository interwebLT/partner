require 'test_helper'

describe Order do
  describe :new do
    subject { Order.new params }

    let(:params) {
      {
        id: 1,
        partner: alpha_partner,
        order_number: 'ABCD123',
        total_price:  70.00,
        fee: 0.00,
        ordered_at: '2015-02-04'.to_date,
        status: 'complete',
        currency_code: 'USD',
        order_details: [
          {
            type:   'domain_create',
            price:  70.00,
            domain: 'test.ph',
            period: 2,
            registrant_handle: 'domains_registrant'
          }
        ]
      }
    }

    specify { subject.id.must_equal 1 }
    specify { subject.partner.as_json.symbolize_keys.must_equal alpha_partner }
    specify { subject.order_number.must_equal 'ABCD123' }
    specify { subject.total_price.must_equal 70.00 }
    specify { subject.fee.must_equal 0.00 }
    specify { subject.ordered_at.must_equal '2015-02-04'.to_date }
    specify { subject.status.must_equal 'complete' }
    specify { subject.currency_code.must_equal 'USD' }
    specify { subject.order_details.wont_be_empty }
  end

  describe :complete? do
    subject { Order.new }

    context :when_status_complete do
      before do
        subject.status = Order::COMPLETE
      end

      specify { subject.complete?.must_equal true }
    end

    context :when_status_not_complete do
      specify { subject.complete?.must_equal false }
    end
  end

  describe :pending? do
    subject { Order.new }

    context :when_status_pending do
      before do
        subject.status = Order::PENDING
      end

      specify { subject.pending?.must_equal true }
    end

    context :when_status_not_pending do
      specify { subject.pending?.must_equal false }
    end
  end
end

def alpha_partner
  {
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
  }
end
