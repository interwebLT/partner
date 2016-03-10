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

  describe '#save' do
    subject do
      order = Order.new json_request

      order.save token: token
    end

    let(:json_request) {
      {
        currency_code:  'USD',
        ordered_at:     '2016-03-10T18:00:00Z',
        order_details:  [
          {
            type: 'domain_create',
            domain: 'available.ph',
            authcode: 'ABC123',
            period: 2,
            registrant_handle:  '123456789ABCDEF'
          }
        ]
      }
    }

    let(:headers) {
      {
        'Authorization' => 'Token token=ABC123',
        'Content-Type'  => 'application/json',
        'Accept'        => 'application/json'
      }
    }

    let(:token) { 'ABC123' }

    before do
      stub_request(:post, Order.url)
        .with(headers: headers, body: 'orders/post_register_domain_request'.body)
        .to_return status: status, body: {}.to_json
    end

    context 'when response code is 200' do
      let(:status) { 200 }

      it { is_expected.to be true }
    end

    context 'when response code is 422' do
      let(:status) { 422 }

      it { is_expected.to be false }
    end
  end
end
