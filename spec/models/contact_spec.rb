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
      context 'when nil' do
        let(:local_name)  { nil }

        it { is_expected.to be_invalid }
      end

      context 'when blank' do
        let(:local_name)  { '' }

        it { is_expected.to be_invalid }
      end

      context 'when too long' do
        let(:local_name) { '123456789 223456789 323456789 423456789 523456789 623456789 723456789 823456789 923456789 A23456789 X' }

        it { is_expected.to be_invalid }
      end
    end

    describe '#local_organization' do
      context 'when nil' do
        let(:local_organization)  { nil }

        it { is_expected.to be_invalid }
      end

      context 'when blank' do
        let(:local_organization)  { '' }

        it { is_expected.to be_invalid }
      end

      context 'when too long' do
        let(:local_organization)  { '123456789 223456789 323456789 423456789 523456789 623456789 723456789 823456789 923456789 A23456789 X' }

        it { is_expected.to be_invalid }
      end
    end

    describe '#local_street' do
      context 'when nil' do
        let(:local_street)  { nil }

        it { is_expected.to be_invalid }
      end

      context 'when blank' do
        let(:local_street)  { '' }

        it { is_expected.to be_invalid }
      end

      context 'when too long' do
        let(:local_street)  { '123456789 223456789 323456789 423456789 523456789 X' }

        it { is_expected.to be_invalid }
      end
    end

    describe '#local_city' do
      context 'when nil' do
        let(:local_city)  { nil }

        it { is_expected.to be_invalid }
      end

      context 'when blank' do
        let(:local_city)  { '' }

        it { is_expected.to be_invalid }
      end

      context 'when too long' do
        let(:local_city)  { '123456789 223456789 323456789 423456789 523456789 X' }

        it { is_expected.to be_invalid }
      end
    end

    describe '#local_country_code' do
      context 'when nil' do
        let(:local_country_code)  { nil }

        it { is_expected.to be_invalid }
      end

      context 'when blank' do
        let(:local_country_code)  { '' }

        it { is_expected.to be_invalid }
      end
    end

    describe '#voice' do
      context 'when nil' do
        let(:voice)  { nil }

        it { is_expected.to be_invalid }
      end

      context 'when blank' do
        let(:voice)  { '' }

        it { is_expected.to be_invalid }
      end

      context 'when too short' do
        let(:voice) { '+63.56789' }

        it { is_expected.to be_invalid }
      end

      context 'when too long' do
        let(:voice) { '+63.56789022345678903234567890420' }

        it { is_expected.to be_invalid }
      end

      context 'when not in format' do
        let(:voice) { '123456789 ' }

        it { is_expected.to be_invalid }
      end
    end

    describe '#email' do
      context 'when nil' do
        let(:email)  { nil }

        it { is_expected.to be_invalid }
      end

      context 'when blank' do
        let(:email)  { '' }

        it { is_expected.to be_invalid }
      end

      context 'when not an email address' do
        let(:voice) { 'notanemailaddress' }

        it { is_expected.to be_invalid }
      end
    end

    describe '#local_postal_code' do
      context 'when nil' do
        let(:local_postal_code) { nil }

        it { is_expected.to be_valid }
      end

      context 'when blank' do
        let(:local_postal_code) { '' }

        it { is_expected.to be_valid }
      end

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
      context 'when nil' do
        let(:fax)  { nil }

        it { is_expected.to be_valid }
      end

      context 'when blank' do
        let(:fax)  { '' }

        it { is_expected.to be_valid }
      end

      context 'when too short' do
        let(:fax) { '+63.56789' }

        it { is_expected.to be_invalid }
      end

      context 'when too long' do
        let(:fax) { '+63.56789022345678903234567890420' }

        it { is_expected.to be_invalid }
      end

      context 'when not in format' do
        let(:fax) { '123456789 ' }

        it { is_expected.to be_invalid }
      end
    end
  end
end
