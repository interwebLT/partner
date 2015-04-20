require 'test_helper'

describe ObjectActivityHelper do
  describe :activity_description do
    subject { activity_description activity }

    context :when_type_created do
      let(:activity) {
        ObjectActivity.new  type: 'create'
      }

      specify { subject.must_equal 'created' }
    end

    context :when_type_transfer do
      let(:activity) {
        ObjectActivity.new  type: 'transfer',
                            losing_partner: 'other_partner'
      }

      specify { subject.must_equal 'transferred from other_partner' }
    end

    context :when_update do
      let(:activity) {
        ObjectActivity.new  type: 'update',
                            property_changed: property_changed,
                            old_value: old_value,
                            new_value: new_value
      }

      let(:property_changed) { 'field' }
      let(:old_value) { 'old value' }
      let(:new_value) { 'new value' }

      context :when_old_value_nil do
        let(:old_value) { nil }

        specify { subject.must_equal 'field: added entry <strong>new value</strong>' }
      end

      context :when_new_value_nil do
        let(:new_value) { nil }

        specify { subject.must_equal 'field: removed entry <strong>old value</strong>' }
      end

      context :when_both_old_and_new_value_present do
        specify { subject.must_equal 'field: updated value from <strong>old value</strong> to <strong>new value</strong>' }
      end

      context :when_old_value_blank do
        let(:old_value) { '' }

        specify { subject.must_equal 'field: set value to <strong>new value</strong>' }
      end

      context :when_new_value_blank do
        let(:new_value) { '' }

        specify { subject.must_equal 'field: set value from <strong>old value</strong> to <strong>blank</strong>' }
      end

      context :when_property_changed_domain_host do
        let(:property_changed) { 'domain_host' }
        let(:old_value) { nil }

        specify { subject.must_equal 'nameserver: added entry <strong>new value</strong>' }
      end

      context :when_ok do
        let(:property_changed) { 'ok' }
        let(:old_value) { 'false' }
        let(:new_value) { 'true' }

        specify { subject.must_equal 'status: is now <strong>OK</strong>' }
      end

      context :when_not_ok do
        let(:property_changed) { 'ok' }
        let(:old_value) { 'true' }
        let(:new_value) { 'false' }

        specify { subject.must_equal 'status: is no longer <strong>OK</strong>' }
      end

      context :when_inactive do
        let(:property_changed) { 'inactive' }
        let(:old_value) { 'false' }
        let(:new_value) { 'true' }

        specify { subject.must_equal 'status: is now <strong>inactive</strong>' }
      end

      context :when_not_inactive do
        let(:property_changed) { 'inactive' }
        let(:old_value) { 'true' }
        let(:new_value) { 'false' }

        specify { subject.must_equal 'status: is no longer <strong>inactive</strong>' }
      end

      context :when_client_hold do
        let(:property_changed) { 'client_hold' }
        let(:old_value) { 'false' }
        let(:new_value) { 'true' }

        specify { subject.must_equal 'status: is now <strong>client hold</strong>' }
      end

      context :when_not_client_hold do
        let(:property_changed) { 'client_hold' }
        let(:old_value) { 'true' }
        let(:new_value) { 'false' }

        specify { subject.must_equal 'status: is no longer <strong>client hold</strong>' }
      end

      context :when_client_delete_prohibited do
        let(:property_changed) { 'client_delete_prohibited' }
        let(:old_value) { 'false' }
        let(:new_value) { 'true' }

        specify { subject.must_equal 'status: is now <strong>client delete prohibited</strong>' }
      end

      context :when_not_client_delete_prohibited do
        let(:property_changed) { 'client_delete_prohibited' }
        let(:old_value) { 'true' }
        let(:new_value) { 'false' }

        specify { subject.must_equal 'status: is no longer <strong>client delete prohibited</strong>' }
      end

      context :when_client_renew_prohibited do
        let(:property_changed) { 'client_renew_prohibited' }
        let(:old_value) { 'false' }
        let(:new_value) { 'true' }

        specify { subject.must_equal 'status: is now <strong>client renew prohibited</strong>' }
      end

      context :when_not_client_renew_prohibited do
        let(:property_changed) { 'client_renew_prohibited' }
        let(:old_value) { 'true' }
        let(:new_value) { 'false' }

        specify { subject.must_equal 'status: is no longer <strong>client renew prohibited</strong>' }
      end

      context :when_client_transfer_prohibited do
        let(:property_changed) { 'client_transfer_prohibited' }
        let(:old_value) { 'false' }
        let(:new_value) { 'true' }

        specify { subject.must_equal 'status: is now <strong>client transfer prohibited</strong>' }
      end

      context :when_not_client_transfer_prohibited do
        let(:property_changed) { 'client_transfer_prohibited' }
        let(:old_value) { 'true' }
        let(:new_value) { 'false' }

        specify { subject.must_equal 'status: is no longer <strong>client transfer prohibited</strong>' }
      end

      context :when_client_update_prohibited do
        let(:property_changed) { 'client_update_prohibited' }
        let(:old_value) { 'false' }
        let(:new_value) { 'true' }

        specify { subject.must_equal 'status: is now <strong>client update prohibited</strong>' }
      end

      context :when_not_client_update_prohibited do
        let(:property_changed) { 'client_update_prohibited' }
        let(:old_value) { 'true' }
        let(:new_value) { 'false' }

        specify { subject.must_equal 'status: is no longer <strong>client update prohibited</strong>' }
      end

      context :when_property_changed_registrant_handle do
        let(:property_changed) { 'registrant_handle' }
        let(:old_value) { '' }

        specify { subject.must_equal 'registrant: set value to <strong>new value</strong>' }
      end

      context :when_property_changed_admin_handle do
        let(:property_changed) { 'admin_handle' }
        let(:old_value) { '' }

        specify { subject.must_equal 'admin: set value to <strong>new value</strong>' }
      end

      context :when_property_changed_billing_handle do
        let(:property_changed) { 'billing_handle' }
        let(:old_value) { '' }

        specify { subject.must_equal 'billing: set value to <strong>new value</strong>' }
      end

      context :when_property_changed_tech_handle do
        let(:property_changed) { 'tech_handle' }
        let(:old_value) { '' }

        specify { subject.must_equal 'tech: set value to <strong>new value</strong>' }
      end

      context :when_property_changed_expires_at do
        let(:property_changed) { 'expires_at' }

        specify { subject.must_equal 'expiry date: updated value from <strong>old value</strong> to <strong>new value</strong>' }
      end

      context :when_property_changed_authcode do
        let(:property_changed) { 'authcode' }
        let(:old_value) { 'old_authcode' }
        let(:new_value) { 'new_authcode' }

        specify { subject.must_equal 'authcode: updated value' }
      end
    end
  end
end

