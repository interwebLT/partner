require 'test_helper'

describe Credit do
  describe :new do
    subject { Credit.new params }

    let(:params) {
      {
        id: 1,
        partner: 'alpha',
        credit_number: 1,
        amount: 150.00,
        credited_at: '2015-02-27T15:00:00Z',
        created_at: '2015-02-27T15:00:00Z',
        updated_at: '2015-02-27T15:00:00Z'
      }
    }

    specify { subject.id.must_equal 1 }
    specify { subject.partner.must_equal 'alpha' }
    specify { subject.credit_number.must_equal 1 }
    specify { subject.amount.must_equal 150.00 }
    specify { subject.credited_at.must_equal '2015-02-27 15:00'.in_time_zone }
    specify { subject.created_at.must_equal '2015-02-27 15:00'.in_time_zone }
    specify { subject.updated_at.must_equal '2015-02-27 15:00'.in_time_zone }
  end
end
