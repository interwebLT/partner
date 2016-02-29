RSpec.describe Credit do
  describe '.new' do
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

    it 'converts from JSON to model' do
      expect(subject.id).to eql 1
      expect(subject.partner).to eql 'alpha'
      expect(subject.credit_number).to eql 1
      expect(subject.amount).to eql 150.00
      expect(subject.credited_at).to eql '2015-02-27T15:00:00Z'
      expect(subject.created_at).to eql '2015-02-27T15:00:00Z'
      expect(subject.updated_at).to eql '2015-02-27T15:00:00Z'
    end
  end
end
