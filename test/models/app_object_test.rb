require 'test_helper'

describe AppObject do
  describe :new do
    subject { AppObject.new params }

    let(:params) {
      {
        id: 1,
        type: 'domain',
        name: 'domain.ph'
      }
    }

    specify { subject.id.must_equal 1 }
    specify { subject.type.must_equal 'domain' }
    specify { subject.name.must_equal 'domain.ph' }
  end
end
