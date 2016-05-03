RSpec.describe DomainHost do
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
end
