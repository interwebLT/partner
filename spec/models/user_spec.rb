RSpec.describe User do
  describe '.info' do
    subject { User.info token: nil }

    context 'when user exists' do
      before do
        stub_request(:get, User.url)
          .to_return body: 'user'.body
      end

      it 'converts from JSON to model' do
        expect(subject.id).to eql 1
        expect(subject.username).to eql 'alpha'
        expect(subject.token).to eql 'abcd123456'
        expect(subject.partner_name).to eql 'alpha'
        expect(subject.credits).to eql 20.00
        expect(subject.staff).to eql false
      end
    end

    context 'when user does not exist' do
      before do
        stub_request(:get, User.url).to_return(status: 404)
      end

      it { is_expected.to be nil }
    end
  end

  describe '.partner' do
    subject { User.new token: nil }

    before do
      stub_request(:get, User.partner_url)
        .to_return body: 'partner'.body
    end

    it 'converts from JSON to model' do
      expect(subject.partner.id).to eql 1
      expect(subject.partner.name).to eql 'alpha'
      expect(subject.partner.credits).to eql 1000.00
    end
  end
end
