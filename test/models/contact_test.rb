require 'test_helper'

describe Contact do
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

  describe :new do
    specify { subject.street2.must_equal 'Street 2' }
    specify { subject.street3.must_equal 'Street 3' }
    specify { subject.local_name.must_equal 'Registrant' }
    specify { subject.local_organization.must_equal 'Organization' }
    specify { subject.local_street.must_equal 'Street' }
    specify { subject.local_street2.must_equal 'Street 2' }
    specify { subject.local_street3.must_equal 'Street 3' }
    specify { subject.local_city.must_equal 'City' }
    specify { subject.local_state.must_equal 'State' }
    specify { subject.local_postal_code.must_equal '1234' }
    specify { subject.local_country_code.must_equal 'PH' }
  end

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

  describe :valid? do
    specify { subject.valid?.must_equal true }
    specify { Contact.new.valid?.must_equal false }

    specify { subject.name  = nil;  subject.valid?.must_equal false }
    specify { subject.organization  = nil;  subject.valid?.must_equal false }
    specify { subject.street  = nil;  subject.valid?.must_equal false }
    specify { subject.city  = nil;  subject.valid?.must_equal false }
    specify { subject.country_code  = nil;  subject.valid?.must_equal false }
    specify { subject.voice = nil;  subject.valid?.must_equal false }
    specify { subject.email = nil;  subject.valid?.must_equal false }

    specify { subject.postal_code ='12)(b@!#$'; subject.valid?.must_equal false }
    specify { subject.voice = 'asdasd'; subject.valid?.must_equal false }
    specify { subject.fax = 'asdasd'; subject.valid?.must_equal false }
    specify { subject.email = 'sample.ph';  subject.valid?.must_equal false }

    specify { subject.name  = ''; subject.valid?.must_equal false }
    specify { subject.organization  = ''; subject.valid?.must_equal false }
    specify { subject.street  = ''; subject.valid?.must_equal false }
    specify { subject.city  = ''; subject.valid?.must_equal false }
    specify { subject.country_code  = ''; subject.valid?.must_equal false }
    specify { subject.voice = ''; subject.valid?.must_equal false }
    specify { subject.email = ''; subject.valid?.must_equal false }

    specify { subject.postal_code = '12'; subject.valid?.must_equal false }
    specify { subject.voice = '123456789';  subject.valid?.must_equal false }
    specify { subject.fax = '123456789';  subject.valid?.must_equal false }
    specify { subject.name = '123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 X'; subject.valid?.must_equal false }
    specify { subject.organization  = '123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 X';  subject.valid?.must_equal false }
    specify { subject.street = '123456789 123456789 123456789 123456789 123456789 X'; subject.valid?.must_equal false }
    specify { subject.city  = '123456789 123456789 123456789 123456789 123456789 X'; subject.valid?.must_equal false }
    specify { subject.postal_code = '123456789 X'; subject.valid?.must_equal false }
    specify { subject.voice = '123456789 123456789 123456789 12X';  subject.valid?.must_equal false }
    specify { subject.fax = '123456789 123456789 123456789 12X';  subject.valid?.must_equal false }
  end
end
