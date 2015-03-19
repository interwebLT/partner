require 'test_helper'

describe OrderDetailHelper do
  describe :order_detail_type do
    specify { order_detail_type('domain_create').must_equal 'Domain Registration' }
    specify { order_detail_type('domain_renew').must_equal 'Domain Renewal' }
    specify { order_detail_type('domain_transfer').must_equal 'Domain Transfer' }
    specify { order_detail_type('credits').must_equal 'Replenish Credits' }
    specify { order_detail_type(nil).must_equal '' }
    specify { order_detail_type('something').must_equal '' }
  end

  describe :order_detail_duration do
    specify { order_detail_duration(1, 'year').must_equal '1 year' }
    specify { order_detail_duration(nil, 'year').must_equal '' }
    specify { order_detail_duration(1, nil).must_equal '' }
    specify { order_detail_duration('', 'year').must_equal '' }
    specify { order_detail_duration(1, '').must_equal '' }
    specify { order_detail_duration(5, 'YEAR').must_equal '5 years' }
  end
end
