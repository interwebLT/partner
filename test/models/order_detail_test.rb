require 'test_helper'

describe OrderDetail do
  describe :new do
    subject { OrderDetail.new params }

    context :when_register_domain do
      let(:params) {
        {
          type: 'domain_create',
          price: 70.00,
          domain: 'test.ph',
          authcode: 'ABC123',
          period: 2,
          registrant_handle: 'domain_registrant'
        }
      }

      specify { subject.type.must_equal 'domain_create' }
      specify { subject.price.must_equal 70.00 }
      specify { subject.domain.must_equal 'test.ph' }
      specify { subject.authcode.must_equal 'ABC123' }
      specify { subject.period.must_equal 2 }
      specify { subject.registrant_handle.must_equal 'domain_registrant' }
    end

    context :when_renew_domain do
      let(:params) {
        {
          type: 'domain_renew',
          price: 70.00,
          domain: 'test.ph',
          period: 2
        }
      }

      specify { subject.type.must_equal 'domain_renew' }
      specify { subject.price.must_equal 70.00 }
      specify { subject.domain.must_equal 'test.ph' }
      specify { subject.period.must_equal 2 }
    end

    context :when_migrate_domain do
      let(:params) {
        {
          type:               'migrate_domain',
          price:              0.00,
          domain:             'migrated.ph',
          registrant_handle:  'migrated_r',
          registered_at:      '2015-04-10T15:00:00Z',
          expires_at:         '2017-04-10T15:00:00Z'
        }
      }

      specify { subject.type.must_equal 'migrate_domain' }
      specify { subject.price.must_equal 0.00 }
      specify { subject.domain.must_equal 'migrated.ph' }
      specify { subject.registered_at.must_equal '2015-04-10 15:00'.in_time_zone }
      specify { subject.expires_at.must_equal '2017-04-10 15:00'.in_time_zone }
    end

    context :when_refund do
      let(:params) {
        {
          type: 'refund',
          price:  -35.00,
          refunded_order_detail: {
            type: 'domain_renew',
            price: 35.00,
            domain: 'test.ph',
            period: 1
          }
        }
      }

      specify { subject.type.must_equal 'refund' }
      specify { subject.price.must_equal -35.00 }
      specify { subject.domain.must_equal 'test.ph' }
      specify { subject.period.must_equal 1 }
    end
  end
end
