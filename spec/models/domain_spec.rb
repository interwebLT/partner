RSpec.describe Domain do
  describe '.exists?' do
    subject { Domain.exists? domain, token: 'ABC123' }

    let(:domain) { 'domain.ph' }

    context 'when domain exists' do
      before do
        response = { id: 1 }

        stub_request(:get, Domain.url(id: domain))
          .to_return body: response.to_json
      end

      it { is_expected.to be true }
    end

    context 'when domain does not exist' do
      before do
        stub_request(:get, Domain.url(id: domain))
          .to_return status: 404
      end

      it { is_expected.to be false }
    end
  end

  describe '.new' do
    subject { Domain.new 'domain'.json }

    it 'converts from JSON to model' do
      expect(subject.id).to eql 1
      expect(subject.zone).to eql 'ph'
      expect(subject.name).to eql 'domain.ph'
      expect(subject.partner).to eql 'alpha'
      expect(subject.registered_at).to eql '2015-02-27T20:30:00Z'
      expect(subject.expires_at).to eql '2017-02-27T20:30:00Z'
      expect(subject.expiring).to eql false
      expect(subject.expired).to eql true

      expect(subject.registrant_handle).to eql 'registrant'
      expect(subject.admin_handle).to eql 'admin'
      expect(subject.billing_handle).to eql 'billing'
      expect(subject.tech_handle).to eql 'tech'

      expect(subject.registrant).not_to be nil
      expect(subject.admin_contact).not_to be nil
      expect(subject.billing_contact).not_to be nil
      expect(subject.tech_contact).not_to be nil

      expect(subject.registrant).to be_a Contact
      expect(subject.admin_contact).to be_a Contact
      expect(subject.billing_contact).to be_a Contact
      expect(subject.tech_contact).to be_a Contact

      expect(subject.client_hold).to be false
      expect(subject.client_delete_prohibited).to be false
      expect(subject.client_renew_prohibited).to be false
      expect(subject.client_transfer_prohibited).to be false
      expect(subject.client_update_prohibited).to be false

      expect(subject.activities).not_to be_empty
      expect(subject.hosts).not_to be_empty
    end
  end

  describe '#expired?' do
    subject { Domain.new expired: true }

    specify { expect(subject.expired?).to eql true }
  end

  describe '#expiring?' do
    subject { Domain.new expiring: true }

    specify { expect(subject.expiring?).to eql true }
  end

  describe '.valid?' do
    specify { expect(Domain.valid?('domain-123.ph')).to eql true }
    specify { expect(Domain.valid?('')).to eql false }
    specify { expect(Domain.valid?('under_score.ph')).to eql false }
    specify { expect(Domain.valid?('a.ph')).to eql false }
    specify { expect(Domain.valid?('abcd123456789012345678901234567890123456789012345678901234567890.ph')).to eql false }
    specify { expect(Domain.valid?('test-123-!@#$.ph')).to eql false }
    specify { expect(Domain.valid?('domain123.com.ph')).to eql true }
    specify { expect(Domain.valid?('domain123.net.ph')).to eql true }
    specify { expect(Domain.valid?('domain123.org.ph')).to eql true }
    specify { expect(Domain.valid?('a.com.ph')).to eql false }
    specify { expect(Domain.valid?('com.ph')).to eql false }
    specify { expect(Domain.valid?('org.ph')).to eql false }
    specify { expect(Domain.valid?('net.ph')).to eql false }
    specify { expect(Domain.valid?('mil.ph')).to eql false }
    specify { expect(Domain.valid?('ngo.ph')).to eql false }
    specify { expect(Domain.valid?('edu.ph')).to eql false }
    specify { expect(Domain.valid?('gov.ph')).to eql false }
    specify { expect(Domain.valid?('domain123.foo')).to eql false }
    specify { expect(Domain.valid?('123.ph')).to eql false }
    specify { expect(Domain.valid?('-domain123.ph')).to eql false }
    specify { expect(Domain.valid?('domain--123.ph')).to eql false }
    specify { expect(Domain.valid?(nil)).to eql false }
    specify { expect(Domain.valid?('domain123')).to eql false }
  end

  describe '#domain_owner' do
    subject { Domain.new(params).domain_owner }

    context 'when international address is provided' do
      let(:params) {
        {
          registrant: {
            name: 'International',
            local_name: 'Local'
          }
        }
      }

      it { is_expected.to eql 'International' }
    end

    context 'when international address is not provided' do
      let(:params) {
        {
          registrant: {
            name: nil,
            local_name: 'Local'
          }
        }
      }

      it { is_expected.to eql 'Local' }
    end

    context 'when international address is blank' do
      let(:params) {
        {
          registrant: {
            name: '',
            local_name: 'Local'
          }
        }
      }

      it { is_expected.to eql 'Local' }
    end
  end
end
