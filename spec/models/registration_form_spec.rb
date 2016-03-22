RSpec.describe RegistrationForm do
  describe '.new' do
    subject { RegistrationForm.new }

    it 'initializes contact' do
      expect(subject.registrant).not_to be nil
    end

    context 'when params provided' do
      subject { RegistrationForm.new params }

      let(:params) {
        {
          domain_name: 'domain.ph',
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
        expect(subject.domain_name).to eql 'domain.ph'
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

  describe '#valid?' do
    subject do
      RegistrationForm.new  domain_name:        domain_name,
                            period:             period,
                            handle:             handle,
                            local_name:         local_name,
                            local_organization: local_organization,
                            local_street:       local_street,
                            local_city:         local_city,
                            local_country_code: local_country_code,
                            voice:              voice,
                            email:              email
    end

    let(:domain_name)         { 'domain.ph' }
    let(:period)              { 1 }

    let(:handle)              { '123456789ABCDEF' }
    let(:local_name)          { 'Local Name' }
    let(:local_organization)  { 'Local Organization' }
    let(:local_street)        { 'Local Street' }
    let(:local_city)          { 'Local City' }
    let(:local_country_code)  { 'PH' }
    let(:voice)               { '+63.1234' }
    let(:email)               { 'contact@alpha.ph' }

    it { is_expected.to be_valid }

    context 'when domain_name is nil' do
      let(:domain_name) { nil }

      it { is_expected.to be_invalid }
    end

    context 'when domain_name is blank' do
      let(:domain_name) { '' }

      it { is_expected.to be_invalid }
    end

    context 'when domain_name is not valid' do
      let(:domain_name) { 'notvalid' }

      it { is_expected.to be_invalid }
    end

    context 'when registrant field is not valid' do
      let(:local_name) { nil }

      it { is_expected.to be_invalid }
    end
  end
end
