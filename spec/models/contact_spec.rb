RSpec.describe Contact do
  subject do
    Contact.new handle:             handle,
                local_name:         local_name,
                local_organization: local_organization,
                local_street:       local_street,
                local_street2:      local_street2,
                local_street3:      local_street3,
                local_city:         local_city,
                local_state:        local_state,
                local_postal_code:  local_postal_code,
                local_country_code: local_country_code,
                voice:              voice,
                voice_ext:          voice_ext,
                fax:                fax,
                fax_ext:            fax_ext,
                email:              email
  end

  let(:handle)              { '123456789ABCDEF' }
  let(:local_name)          { 'Local Name' }
  let(:local_organization)  { 'Local Organization' }
  let(:local_street)        { 'Local Street' }
  let(:local_city)          { 'Local City' }
  let(:local_country_code)  { 'PH' }
  let(:voice)               { '+63.1234' }
  let(:email)               { 'contact@alpha.ph' }

  let(:local_street2)       { nil }
  let(:local_street3)       { nil }
  let(:local_state)         { nil }
  let(:local_postal_code)   { nil }
  let(:voice_ext)           { nil }
  let(:fax)                 { nil }
  let(:fax_ext)             { nil }

  describe '#valid?' do
    context 'when minimum valid object' do
      it { is_expected.to be_valid }
    end

    context 'when new' do
      it { expect(Contact.new).to be_invalid }
    end

    describe '#handle' do
      it_behaves_like 'a required field', :handle

      context 'when too long' do
        let(:handle) { '123456789 123456X' }

        it { is_expected.to be_invalid }
      end
    end

    describe '#local_name' do
      it_behaves_like 'a required field', :local_name
      it_behaves_like 'a string field', :local_name
    end

    describe '#local_organization' do
      it_behaves_like 'a required field', :local_organization
      it_behaves_like 'a string field', :local_organization
    end

    describe '#local_street' do
      it_behaves_like 'a required field', :local_street
      it_behaves_like 'an address field', :local_street
    end

    describe '#local_city' do
      it_behaves_like 'a required field', :local_city
      it_behaves_like 'an address field', :local_city
    end

    describe '#local_country_code' do
      it_behaves_like 'a required field', :local_country_code
      it_behaves_like 'a required field', :local_country_code
    end

    describe '#voice' do
      it_behaves_like 'a required field', :voice
      it_behaves_like 'a contact number field', :voice
    end

    describe '#email' do
      it_behaves_like 'a required field', :email

      context 'when not an email address' do
        let(:voice) { 'notanemailaddress' }

        it { is_expected.to be_invalid }
      end
    end

    describe '#local_postal_code' do
      context 'when too short' do
        let(:local_postal_code) { '12' }

        it { is_expected.to be_invalid }
      end

      context 'when too long' do
        let(:local_postal_code) { '123456789 X' }

        it { is_expected.to be_invalid }
      end

      context 'when not alphanumeric' do
        let(:local_postal_code) { '!@#$%^&*()' }

        it { is_expected.to be_invalid }
      end
    end

    describe '#fax' do
      it_behaves_like 'a contact number field', :fax
    end
  end

  describe '.new' do
    subject { Contact.new params }

    let(:params) {
      {
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

    it 'creates a new contact' do
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

  describe '#save' do
    before do
      stub_request(:post, Contact.url)
        .with(headers: headers, body: 'contacts/post_request'.body)
        .to_return status: status, body: {}.to_json
    end

    let(:headers) {
      {
        'Authorization' => 'Token token=ABC123',
        'Content-Type'  => 'application/json',
        'Accept'        => 'application/json'
      }
    }

    context 'when response code is 200' do
      let(:status) { 200 }

      it 'creates contact' do
        expect(subject.save(token: 'ABC123')).to be true
      end

      context 'when handle is nil' do
        let(:handle) { nil }

        before do
          subject.handle = Contact.generate_handle
        end

        it 'creates contact' do
          expect(subject.save(token: 'ABC123')).to be true
        end
      end
    end

    context 'when response code is 422' do
      let(:status) { 422 }

      it 'does not create contact' do
        expect(subject.save(token: 'ABC123')).to be false
        expect(subject.errors[:handle]).to include 'already exists'
      end
    end
  end

  describe '#as_json' do
    let(:expected_json) {
      {
        handle:             '123456789ABCDEF',
        local_name:         'Local Name',
        local_organization: 'Local Organization',
        local_street:       'Local Street',
        local_street2:      nil,
        local_street3:      nil,
        local_city:         'Local City',
        local_state:        nil,
        local_postal_code:  nil,
        local_country_code: 'PH',
        voice:              '+63.1234',
        voice_ext:          nil,
        fax:                nil,
        fax_ext:            nil,
        email:              'contact@alpha.ph'
      }
    }

    it 'returns contact json' do
      expect(subject.as_json).to eql expected_json
    end

    context 'when optional field blank' do
      let(:local_street2)     { '' }
      let(:local_street3)     { '' }
      let(:local_state)       { '' }
      let(:local_postal_code) { '' }
      let(:voice_ext)         { '' }
      let(:fax)               { '' }
      let(:fax_ext)           { '' }

      it 'returns null for blank optional fields' do
        expect(subject.as_json).to eql expected_json
      end
    end
  end

  describe '#local_country_name' do
    subject do
      contact = Contact.new local_country_code: local_country_code

      contact.local_country_name
    end

    let(:local_country_code) { 'PH' }

    it { is_expected.to eq 'Philippines' }

    context 'when local_country_code is nil' do
      let(:local_country_code) { nil }

      it { is_expected.to be nil }
    end

    context 'when local_country_code is not a country' do
      let(:local_country_code) { 'E&L' }

      it { is_expected.to be nil }
    end
  end
end
