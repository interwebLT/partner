RSpec.describe Domain do
  subject { Domain.exists? domain, token: 'ABC123' }

  let(:domain) { 'domain.ph' }

  describe '.exists?' do
    context 'when domain exists' do
      before do
        stub_request(:get, Domain.url(params: { name: domain }))
          .to_return(body: { id: 1 }.to_json)
      end

      it { is_expected.to be true }
    end

    context 'when domain does not exist' do
      before do
        stub_request(:get, Domain.url(params: { name: domain }))
          .to_return(body: {}.to_json)
      end

      it { is_expected.to be false }
    end
  end
end
