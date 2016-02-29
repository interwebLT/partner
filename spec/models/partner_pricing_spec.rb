RSpec.describe PartnerPricing do
  describe '.new' do
    subject { PartnerPricing.new params }

    let(:params) {
      {
        id: 1,
        action: 'domain_create',
        period: 1,
        price: 35.00
      }
    }

    it 'converts from JSON to model' do
      expect(subject.id).to eql 1
      expect(subject.action).to eql 'domain_create'
      expect(subject.period).to eql 1
      expect(subject.price).to eql 35.00
    end
  end
end
