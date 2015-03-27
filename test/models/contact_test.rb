require 'test_helper'

describe Contact do
  describe :new do
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

  describe :valid? do
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

    context :when_valid do
      specify { subject.valid?.must_equal true }
    end

    context :when_name_missing do
      before do
        subject.name = nil
      end

      specify { subject.valid?.must_equal false }
    end

    context :when_organization_missing do
      before do
        subject.organization = nil
      end

      specify { subject.valid?.must_equal false }
    end

    context :when_street_missing do
      before do
        subject.street = nil
      end

      specify { subject.valid?.must_equal false }
    end

    context :when_city_missing do
      before do
        subject.city = nil
      end

      specify { subject.valid?.must_equal false }
    end

    context :when_state_missing do
      before do
        subject.state = nil
      end

      specify { subject.valid?.must_equal false }
    end

    context :when_country_code_missing do
      before do
        subject.country_code = nil
      end

      specify { subject.valid?.must_equal false }
    end

    context :when_voice_missing do
      before do
        subject.voice = nil
      end

      specify { subject.valid?.must_equal false }
    end

    context :when_email_missing do
      before do
        subject.email = nil
      end

      specify { subject.valid?.must_equal false }
    end

    context :when_postal_code_contains_special_chars do
      before do
        subject.postal_code = '12)(b@!#$'
      end

      specify { subject.valid?.must_equal false }
    end

    context :when_voice_not_a_number do
      before do
        subject.voice = 'asdasd'
      end

      specify { subject.valid?.must_equal false }
    end

    context :when_fax_not_a_number do
      before do
        subject.fax = 'asdasd'
      end

      specify { subject.valid?.must_equal false }
    end

    context :when_email_invalid do
      before do
        subject.email = 'sampledot.ph'
      end

      specify { subject.valid?.must_equal false }
    end

    context :when_name_blank do
      before do
        subject.name = ''
      end

      specify { subject.valid?.must_equal false }
    end

    context :when_organization_blank do
      before do
        subject.organization = ''
      end

      specify { subject.valid?.must_equal false }
    end

    context :when_street_blank do
      before do
        subject.street = ''
      end

      specify { subject.valid?.must_equal false }
    end

    context :when_city_blank do
      before do
        subject.city = ''
      end

      specify { subject.valid?.must_equal false }
    end

    context :when_state_blank do
      before do
        subject.state = ''
      end

      specify { subject.valid?.must_equal false }
    end

    context :when_postal_code_less_than_3_chars do
      before do
        subject.postal_code = '12'
      end

      specify { subject.valid?.must_equal false }
    end

    context :when_voice_less_than_10_chars do
      before do
        subject.voice = '123456789'
      end

      specify { subject.valid?.must_equal false }
    end

    context :when_fax_less_than_10_chars do
      before do
        subject.fax = '123456789'
      end

      specify { subject.valid?.must_equal false }
    end

    context :when_name_more_than_100_chars do
      before do
        subject.name = '123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 X'
      end

      specify { subject.valid?.must_equal false }
    end

    context :when_organization_more_than_100_chars do
      before do
        subject.name = '123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 X'
      end

      specify { subject.valid?.must_equal false }
    end

    context :when_street_more_than_50_chars do
      before do
        subject.street = '123456789 123456789 123456789 123456789 123456789 X'
      end

      specify { subject.valid?.must_equal false }
    end

    context :when_city_more_than_50_chars do
      before do
        subject.city = '123456789 123456789 123456789 123456789 123456789 X'
      end

      specify { subject.valid?.must_equal false }
    end

    context :when_state_more_than_50_chars do
      before do
        subject.state = '123456789 123456789 123456789 123456789 123456789 X'
      end

      specify { subject.valid?.must_equal false }
    end

    context :when_postal_code_more_than_10_chars do
      before do
        subject.postal_code = '123456789 X'
      end

      specify { subject.valid?.must_equal false }
    end

    context :when_voice_more_than_32_chars do
      before do
        subject.voice = '123456789 123456789 123456789 12X'
      end

      specify { subject.valid?.must_equal false }
    end

    context :when_fax_more_than_32_chars do
      before do
        subject.fax = '123456789 123456789 123456789 12X'
      end

      specify { subject.valid?.must_equal false }
    end
  end
end
