require 'rails_helper'

RSpec.describe Contact do
  subject do
    Contact.new local_name: local_name,
                local_organization: local_organization,
                local_street: local_street,
                local_city: local_city,
                local_postal_code: local_postal_code,
                local_country_code: local_country_code,
                voice: voice,
                fax: fax,
                email: email
  end

  let(:local_name)          { 'Local Name' }
  let(:local_organization)  { 'Local Organization' }
  let(:local_street)        { 'Local Street' }
  let(:local_city)          { 'Local City' }
  let(:local_country_code)  { 'PH' }
  let(:voice)               { '+63.21234567' }
  let(:email)               { 'contact@alpha.ph' }

  let(:local_postal_code)   { nil }
  let(:fax)                 { nil }

  describe '#valid?' do
    context 'when minimum valid object' do
      it { is_expected.to be_valid }
    end

    context 'when new' do
      it { expect(Contact.new).to be_invalid }
    end

    describe '#local_name' do
      it_behaves_like 'a string field', :local_name
    end

    describe '#local_organization' do
      it_behaves_like 'a string field', :local_organization
    end

    describe '#local_street' do
      it_behaves_like 'an address field', :local_street
    end

    describe '#local_city' do
      it_behaves_like 'an address field', :local_city
    end

    describe '#local_country_code' do
      it_behaves_like 'a required field', :local_country_code
    end

    describe '#voice' do
      it_behaves_like 'a required field', :voice
      it_behaves_like 'a contact number field', :voice
    end

    describe '#email' do
      it_behaves_like 'a required field', :voice

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
end
