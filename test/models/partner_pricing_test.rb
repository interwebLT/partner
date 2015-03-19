require 'test_helper'

describe PartnerPricing do
  describe :new do
    subject { PartnerPricing.new params }

    let(:params) {
      {
        id: 1,
        action: 'domain_create',
        period: 1,
        price: 35.00
      }
    }

    specify { subject.id.wont_be_nil }
    specify { subject.action.must_equal 'domain_create' }
    specify { subject.period.must_equal 1 }
    specify { subject.price.must_equal 35.00 }
  end
end
