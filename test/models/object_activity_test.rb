require 'test_helper'

describe ObjectActivity do
  describe :new do
    subject { ObjectActivity.new params }

    context :when_create do
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

      specify { subject.id.must_equal 1 }
      specify { subject.type.must_equal 'create' }
      specify { subject.activity_at.must_equal '2015-03-03 15:00:00'.in_time_zone }
      specify { subject.object.wont_be_nil }
    end

    context :when_update do
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

      specify { subject.id.must_equal 1 }
      specify { subject.type.must_equal 'update' }
      specify { subject.activity_at.must_equal '2015-03-03 15:00:00'.in_time_zone }
      specify { subject.object.wont_be_nil }
      specify { subject.property_changed.must_equal 'name' }
      specify { subject.old_value.must_equal 'old_name' }
      specify { subject.new_value.must_equal 'new_name' }
    end
  end

  describe :all do
    subject { ObjectActivity.all(token: default_token) }

    before do
      stub_request(:get, ObjectActivity.url)
        .to_return(status: 200, body: activities_response.to_json)
    end

    specify { subject.count.must_equal 2 }
  end

  private

  def activities_response
    [
      {
        id: 1,
        type: 'create',
        activity_at: '2015-03-03T15:00:00Z',
        object: {
          id: 1,
          type: 'domain',
          name: 'domain.ph'
        }
      },
      {
        id: 2,
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
    ]
  end
end
