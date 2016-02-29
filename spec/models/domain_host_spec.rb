RSpec.describe DomainHost do
  describe '.new' do
    subject { DomainHost.new params }

    let(:params) {
      {
        id: 1,
        name: 'ns5.domains.ph',
        created_at: '2015-03-04T19:00:00Z',
        updated_at: '2015-03-04T19:00:00Z'
      }
    }

    it 'converts from JSON to model' do
      expect(subject.id).to eql 1
      expect(subject.name).to eql 'ns5.domains.ph'
      expect(subject.created_at).to eql '2015-03-04T19:00:00Z'
      expect(subject.updated_at).to eql '2015-03-04T19:00:00Z'
    end
  end
end
