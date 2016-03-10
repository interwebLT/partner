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
          registrant: {
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
      }

      it 'sets params' do
        expect(subject.domain).to eql 'domain.ph'
        expect(subject.period).to eql 2

        expect(subject.registrant.handle).to eql 'handle'

        expect(subject.registrant.local_name).to eql 'Registrant'
        expect(subject.registrant.local_organization).to eql 'Organization'
        expect(subject.registrant.local_street).to eql 'Street'
        expect(subject.registrant.local_street2).to eql 'Street 2'
        expect(subject.registrant.local_street3).to eql 'Street 3'
        expect(subject.registrant.local_city).to eql 'City'
        expect(subject.registrant.local_state).to eql 'State'
        expect(subject.registrant.local_postal_code).to eql '1234'
        expect(subject.registrant.local_country_code).to eql 'PH'

        expect(subject.registrant.voice).to eql '+63.123456789'
        expect(subject.registrant.voice_ext).to be_nil
        expect(subject.registrant.fax).to eql '+63.123456789'
        expect(subject.registrant.fax_ext).to be_nil
        expect(subject.registrant.email).to eql 'sample@dot.ph'

        expect(subject.registrant.name).to eql 'Test Registrant'
        expect(subject.registrant.organization).to eql 'Test Organization'
        expect(subject.registrant.street).to eql '#123 Test Street'
        expect(subject.registrant.street2).to eql 'Street 2'
        expect(subject.registrant.street3).to eql 'Street 3'
        expect(subject.registrant.city).to eql 'Test City'
        expect(subject.registrant.state).to eql 'Test State'
        expect(subject.registrant.postal_code).to eql '1240'
        expect(subject.registrant.country_code).to eql 'PH'
      end

      context 'when registrant is nil' do
        let(:params) {
          {
            domain: 'domain.ph',
            period: 2
          }
        }

        it 'maintains registrant as model' do
          expect(subject.registrant).not_to be nil
          expect(subject.registrant).not_to be_a Hash
          expect(subject.registrant).to be_a Contact
        end
      end
    end
  end
end
