require 'test_helper'

describe DomainHost do
  describe :new do
    subject { DomainHost.new params }

    let(:params) {
      {
        id: 1,
        name: 'ns5.domains.ph',
        created_at: '2015-03-04T19:00:00Z',
        updated_at: '2015-03-04T19:00:00Z'
      }
    }

    specify { subject.id.must_equal 1 }
    specify { subject.name.must_equal 'ns5.domains.ph' }
    specify { subject.created_at.must_equal '2015-03-04 19:00:00'.in_time_zone }
    specify { subject.updated_at.must_equal '2015-03-04 19:00:00'.in_time_zone }
  end
end
