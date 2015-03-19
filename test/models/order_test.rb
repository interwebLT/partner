require 'test_helper'

describe Order do
  describe :new do
    subject { Order.new params }

    let(:params) {
      {
        id: 1,
        partner: 'alpha',
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
    specify { subject.partner.must_equal 'alpha' }
    specify { subject.order_number.must_equal 'ABCD123' }
    specify { subject.total_price.must_equal 70.00 }
    specify { subject.fee.must_equal 0.00 }
    specify { subject.ordered_at.must_equal '2015-02-04'.to_date }
    specify { subject.status.must_equal 'complete' }
    specify { subject.currency_code.must_equal 'USD' }
    specify { subject.order_details.wont_be_empty }
  end
end
