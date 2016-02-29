RSpec.describe ObjectActivity do
  describe '.new' do
    subject { ObjectActivity.new params }

    context 'when activity is create' do
      let(:params) {
        {
          id: 1,
          type: 'create',
          activity_at: '2015-03-03T15:00:00Z',
          object: {
            id: 1,
            type: 'domain',
            name: 'domain.ph'
          }
        }
      }

      it 'converts from JSON to model' do
        expect(subject.id).to eql 1
        expect(subject.type).to eql 'create'
        expect(subject.activity_at).to eql '2015-03-03T15:00:00Z'
        expect(subject.object).not_to be nil
      end
    end

    context 'when activity is update' do
      let(:params) {
        {
          id: 1,
          type: 'update',
          activity_at: '2015-03-03T15:00:00Z',
          object: {
            id: 1,
            type: 'domain',
            name: 'domain.ph'
          },
          property_changed: 'name',
          old_value: 'old_name',
          new_value: 'new_name'
        }
      }

      it 'converts from JSON to model' do
        expect(subject.id).to eql 1
        expect(subject.type).to eql 'update'
        expect(subject.activity_at).to eql '2015-03-03T15:00:00Z'
        expect(subject.object).not_to be nil
        expect(subject.property_changed).to eql 'name'
        expect(subject.old_value).to eql 'old_name'
        expect(subject.new_value).to eql 'new_name'
      end
    end

    context 'when activity is transfer' do
      let(:params) {
        {
          id: 1,
          type: 'update',
          activity_at: '2015-04-16T19:30:00Z',
          object: {
            id: 1,
            type: 'domain',
            name: 'domain.ph'
          },
          losing_partner: 'other_partner'
        }
      }

      it 'converts from JSON to model' do
        expect(subject.id).to eql 1
        expect(subject.type).to eql 'update'
        expect(subject.activity_at).to eql '2015-04-16T19:30:00Z'
        expect(subject.object).not_to be nil
        expect(subject.losing_partner).to eql 'other_partner'
      end
    end
  end


  describe :all do
    subject { ObjectActivity.all token: nil }

    before do
      stub_request(:get, ObjectActivity.url)
        .to_return status: 200, body: 'activities'.body
    end

    specify { expect(subject.count).to eql 3 }
  end
end
