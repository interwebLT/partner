RSpec.describe OrderDetail do
  describe '.new' do
    subject { OrderDetail.new params }

    context 'when type is register domain' do
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

      it 'converts from JSON to model' do
        expect(subject.type).to eql 'domain_create'
        expect(subject.price).to eql 70.00
        expect(subject.domain).to eql 'test.ph'
        expect(subject.authcode).to eql 'ABC123'
        expect(subject.period).to eql 2
        expect(subject.registrant_handle).to eql 'domain_registrant'
      end
    end

    context 'when type is renew domain' do
      let(:params) {
        {
          type: 'domain_renew',
          price: 70.00,
          domain: 'test.ph',
          period: 2
        }
      }

      it 'converts from JSON to model' do
        expect(subject.type).to eql 'domain_renew'
        expect(subject.price).to eql 70.00
        expect(subject.domain).to eql 'test.ph'
        expect(subject.period).to eql 2
      end
    end

    context 'when type is migrate domain' do
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

      it 'converts from JSON to model' do
        expect(subject.type).to eql 'migrate_domain'
        expect(subject.price).to eql 0.00
        expect(subject.domain).to eql 'migrated.ph'
        expect(subject.registered_at).to eql '2015-04-10T15:00:00Z'
        expect(subject.expires_at).to eql '2017-04-10T15:00:00Z'
      end
    end

    context 'when type is refund' do
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

      it 'converts from JSON to model' do
        expect(subject.type).to eql 'refund'
        expect(subject.price).to eql -35.00
        expect(subject.domain).to eql 'test.ph'
        expect(subject.period).to eql 1
      end
    end
  end
end
