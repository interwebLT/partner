RSpec.describe DomainHost do
  subject(:domain_host) do
    DomainHost.new  domain: domain,
                    name:   name
  end

  let(:domain)  { 'domain.ph' }
  let(:name)    { 'ns5.domains.ph' }

  describe '.new' do
    subject { DomainHost.new params }

    let(:params) {
      {
        id: 1,
        name: 'ns5.domains.ph',
        created_at: '2015-03-04T19:00:00Z',
        updated_at: '2015-03-04T19:00:00Z'
      }
    }

    it do
      is_expected.to have_attributes  id:         1,
                                      name:       'ns5.domains.ph',
                                      created_at: '2015-03-04T19:00:00Z',
                                      updated_at: '2015-03-04T19:00:00Z'
    end
  end

  describe '#valid?' do
    it { is_expected.to be_valid }

    context 'when domain is nil' do
      let(:domain) { nil }

      it { is_expected.not_to be_valid }
    end

    context 'when domain is blank' do
      let(:domain) { '' }

      it { is_expected.not_to be_valid }
    end

    context 'when name is nil' do
      let(:name) { nil }

      it { is_expected.not_to be_valid }
    end

    context 'when name is blank' do
      let(:name) { '' }

      it { is_expected.not_to be_valid }
    end
  end

  describe '#save' do
    subject { domain_host.save token: 'abcd123456' }

    context 'when object is not valid' do
      let(:domain)  { nil }
      let(:name)    { nil }

      it { is_expected.to eql false }
    end
  end
end
