RSpec.describe Order do
  describe '.new' do
    subject { Order.new params }

    let(:params) {
      {
        id: 1,
        partner: 'alpha',
        order_number: 'ABCD123',
        total_price:  70.00,
        fee: 0.00,
        ordered_at: '2015-02-04T00:00:00Z',
        status: 'complete',
        currency_code: 'USD',
        order_details: [
          {
            type:   'domain_create',
            price:  70.00,
            domain: 'test.ph',
            period: 2,
            registrant_handle: 'domains_registrant'
          }
        ]
      }
    }

    it 'converts from JSON to model' do
      expect(subject.id).to eql 1
      expect(subject.partner).to eql 'alpha'
      expect(subject.order_number).to eql 'ABCD123'
      expect(subject.total_price).to eql 70.00
      expect(subject.fee).to eql 0.00
      expect(subject.ordered_at).to eql '2015-02-04T00:00:00Z'
      expect(subject.status).to eql 'complete'
      expect(subject.currency_code).to eql 'USD'
      expect(subject.order_details).not_to be_empty
    end
  end

  describe '#complete?' do
    subject { Order.new(status: status).complete? }

    context 'when status is complete' do
      let(:status) { Order::COMPLETE }

      it { is_expected.to be true }
    end

    context 'when status it not complete' do
      let(:status) { Order::PENDING }

      it { is_expected.to be false }
    end
  end

  describe '#pending?' do
    subject { Order.new(status: status).pending? }

    context 'when status is pending' do
      let(:status) { Order::PENDING }

      it { is_expected.to be true }
    end

    context 'when status it not pending' do
      let(:status) { Order::ERROR }

      it { is_expected.to be false }
    end
  end

  describe '#error?' do
    subject { Order.new(status: status).error? }

    context 'when status is error' do
      let(:status) { Order::ERROR }

      it { is_expected.to be true }
    end

    context 'when status it not error' do
      let(:status) { Order::COMPLETE }

      it { is_expected.to be false }
    end
  end
end
