require 'test_helper'

describe DefaultNameserver do
  describe :new do
    subject { DefaultNameserver.new params }

    let(:params) {
      {
        name: 'ns3.domains.ph'
      }
    }

    specify { subject.name.must_equal 'ns3.domains.ph' }
  end
end
