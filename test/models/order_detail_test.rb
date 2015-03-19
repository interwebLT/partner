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
          period: 2,
          registrant_handle: 'domain_registrant',
          registered_at: '2015-02-27T14:00:00Z'
        }
      }

      specify { subject.type.must_equal 'domain_create' }
      specify { subject.price.must_equal 70.00 }
      specify { subject.domain.must_equal 'test.ph' }
      specify { subject.period.must_equal 2 }
      specify { subject.registrant_handle.must_equal 'domain_registrant' }
      specify { subject.registered_at.must_equal '2015-02-27 14:00'.in_time_zone }
    end

    context :when_renew_domain do
      let(:params) {
        {
          type: 'domain_renew',
          price: 70.00,
          domain: 'test.ph',
          period: 2,
          renewed_at: '2015-02-27T14:00:00Z'
        }
      }

      specify { subject.type.must_equal 'domain_renew' }
      specify { subject.price.must_equal 70.00 }
      specify { subject.domain.must_equal 'test.ph' }
      specify { subject.period.must_equal 2 }
      specify { subject.renewed_at.must_equal '2015-02-27 14:00'.in_time_zone }
    end
  end
end
