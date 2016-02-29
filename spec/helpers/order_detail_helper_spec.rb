RSpec.describe OrderDetailHelper do
  describe '.order_detail_type' do
    specify { expect(order_detail_type('domain_create')).to eql 'Registration' }
    specify { expect(order_detail_type('domain_renew')).to eql 'Renewal' }
    specify { expect(order_detail_type('transfer_domain')).to eql 'Transfer' }
    specify { expect(order_detail_type('credits')).to eql 'Replenish Credits' }
    specify { expect(order_detail_type('migrate_domain')).to eql 'Migrated' }
    specify { expect(order_detail_type('refund')).to eql 'Refund' }

    specify { expect(order_detail_type(nil)).to eql '' }
    specify { expect(order_detail_type('something')).to eql '' }
  end

  describe '.order_detail_duration' do
    specify { expect(order_detail_duration(1, 'year')).to eql '1 year' }
    specify { expect(order_detail_duration(nil, 'year')).to eql '' }
    specify { expect(order_detail_duration(1, nil)).to eql '' }
    specify { expect(order_detail_duration('', 'year')).to eql '' }
    specify { expect(order_detail_duration(1, '')).to eql '' }
    specify { expect(order_detail_duration(5, 'YEAR')).to eql '5 years' }
  end
end
