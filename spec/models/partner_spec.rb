RSpec.describe Partner do
  describe '.new' do
    subject { Partner.new 'partner'.json }

    it 'converts from JSON to model' do
      expect(subject.id).to eql 1
      expect(subject.name).to eql 'alpha'
      expect(subject.organization).to eql 'Company'
      expect(subject.credits).to eql 1000.00
      expect(subject.site).to eql 'http://alpha.ph'
      expect(subject.nature).to eql 'Business'
      expect(subject.representative).to eql 'Representative'
      expect(subject.position).to eql 'Position'
      expect(subject.street).to eql 'Street'
      expect(subject.city).to eql 'City'
      expect(subject.state).to eql 'State'
      expect(subject.postal_code).to eql '1234'
      expect(subject.country_code).to eql 'PH'
      expect(subject.phone).to eql '+63.21234567'
      expect(subject.fax).to eql '+63.21234567'
      expect(subject.email).to eql 'alpha@alpha.ph'
      expect(subject.local).to eql true
      expect(subject.admin).to eql false

      expect(subject.default_nameservers).not_to be_empty
      expect(subject.pricing).not_to be_empty
    end
  end

  describe '#persisted?' do
    subject { Partner.new(id: id).persisted? }

    context 'when id is set' do
      let(:id) { 1 }

      it { is_expected.to be true }
    end

    context 'when id is nil' do
      let(:id) { nil }

      it { is_expected.to be false }
    end
  end
end

