RSpec.describe DefaultNameserver do
  describe '.new' do
    subject { DefaultNameserver.new params }

    let(:params) {
      {
        name: 'ns3.domains.ph'
      }
    }

    it 'converts from JSON to model' do
      expect(subject.name).to eql 'ns3.domains.ph'
    end
  end
end
