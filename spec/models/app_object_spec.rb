RSpec.describe AppObject do
  describe '.new' do
    subject { AppObject.new params }

    let(:params) {
      {
        id: 1,
        type: 'domain',
        name: 'domain.ph'
      }
    }

    it 'converts from JSON to model' do
      expect(subject.id).to eql 1
      expect(subject.type).to eql 'domain'
      expect(subject.name).to eql 'domain.ph'
    end
  end
end
