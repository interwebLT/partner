RSpec.describe Registration do
  describe '.new' do
    subject { Registration.new }

    it 'initializes contact' do
      expect(subject.registrant).not_to be nil
    end

    context 'when params provided' do
      subject { Registration.new params }

      let(:params) {
        {
          domain: 'domain.ph',
          period: 2,
          handle: 'handle',
          name: 'Test Registrant',
          organization: 'Test Organization',
          street: '#123 Test Street',
          street2: 'Street 2',
          street3: 'Street 3',
          city: 'Test City',
          state: 'Test State',
          postal_code: '1240',
          country_code: 'PH',
          local_name: 'Registrant',
          local_organization: 'Organization',
          local_street: 'Street',
          local_street2: 'Street 2',
          local_street3: 'Street 3',
          local_city: 'City',
          local_state: 'State',
          local_postal_code: '1234',
          local_country_code: 'PH',
          voice: '+63.123456789',
          voice_ext: nil,
          fax: '+63.123456789',
          fax_ext: nil,
          email: 'sample@dot.ph'
        }
      }

      it 'sets params' do
        expect(subject.domain).to eql 'domain.ph'
        expect(subject.period).to eql 2

        expect(subject.handle).to eql 'handle'

        expect(subject.local_name).to eql 'Registrant'
        expect(subject.local_organization).to eql 'Organization'
        expect(subject.local_street).to eql 'Street'
        expect(subject.local_street2).to eql 'Street 2'
        expect(subject.local_street3).to eql 'Street 3'
        expect(subject.local_city).to eql 'City'
        expect(subject.local_state).to eql 'State'
        expect(subject.local_postal_code).to eql '1234'
        expect(subject.local_country_code).to eql 'PH'

        expect(subject.voice).to eql '+63.123456789'
        expect(subject.voice_ext).to be_nil
        expect(subject.fax).to eql '+63.123456789'
        expect(subject.fax_ext).to be_nil
        expect(subject.email).to eql 'sample@dot.ph'

        expect(subject.name).to eql 'Test Registrant'
        expect(subject.organization).to eql 'Test Organization'
        expect(subject.street).to eql '#123 Test Street'
        expect(subject.street2).to eql 'Street 2'
        expect(subject.street3).to eql 'Street 3'
        expect(subject.city).to eql 'Test City'
        expect(subject.state).to eql 'Test State'
        expect(subject.postal_code).to eql '1240'
        expect(subject.country_code).to eql 'PH'
      end
    end
  end
end
