RSpec.describe Authorization do
  describe '.authenticate' do
    subject { Authorization.authenticate 'username', 'password' }

    context 'when authenticated' do
      before do
        stub_request(:post, Authorization.url)
          .to_return(body: { id: 1, token: 'abcd123456' }.to_json, status: 201)
      end

      it 'provides authentication info' do
        expect(subject.id).to eql 1
        expect(subject.token).to eql 'abcd123456'
      end
    end

    context 'when authentication fails' do
      before do
        stub_request(:post, Authorization.url).to_return(status: 400)
      end

      it { is_expected.to be nil }
    end
  end
end
