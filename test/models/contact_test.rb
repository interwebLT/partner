require 'test_helper'

describe Contact do
  describe :handle do
    context :when_provided do
      subject {
        Contact.new handle: 'test_handle',
                    name: 'Test Registrant',
                    organization: 'Test Organization',
                    street: '#123 Test Street',
                    city: 'Test City',
                    state: 'Test State',
                    postal_code: '1240',
                    country_code: 'PH',
                    voice: '+63.123456789',
                    fax: '+63.123456789',
                    email: 'sample@dot.ph'
      }
      specify { subject.handle.must_equal 'test_handle' }
    end

    context :when_not_provided do
      before do
        Timecop.freeze Time.local(2015)
      end

      after do
        Timecop.return
      end

      subject {
        Contact.new name: 'Test Registrant',
                    organization: 'Test Organization',
                    street: '#123 Test Street',
                    city: 'Test City',
                    state: 'Test State',
                    postal_code: '1240',
                    country_code: 'PH',
                    voice: '+63.123456789',
                    fax: '+63.123456789',
                    email: 'sample@dot.ph'
      }
      specify { subject.handle.must_equal 'PH1420041600.000' }
    end
  end
end
