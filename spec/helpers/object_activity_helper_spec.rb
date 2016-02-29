RSpec.describe ObjectActivityHelper do
  subject { activity_description activity }

  context 'when type is created' do
    let(:activity) {
      ObjectActivity.new  type: 'create'
    }

    it { is_expected.to eql 'created' }
  end

  context 'when type is transfer' do
    let(:activity) {
      ObjectActivity.new  type:           'transfer',
                          partner:        { name: 'partner' },
                          losing_partner: 'other_partner'
    }

    it { is_expected.to eql 'transferred to partner' }
  end

  context 'when type is update' do
    let(:activity) {
      ObjectActivity.new  type:             'update',
                          property_changed: property_changed,
                          old_value:        old_value,
                          new_value:        new_value
    }

    let(:property_changed) { 'field' }
    let(:old_value) { 'old value' }
    let(:new_value) { 'new value' }

    context 'when old value is nil' do
      let(:old_value) { nil }

      it { is_expected.to eql 'field: added entry <strong>new value</strong>' }
    end

    context 'when new value is nil' do
      let(:new_value) { nil }

      it { is_expected.to eql 'field: removed entry <strong>old value</strong>' }
    end

    context 'when both old and new values are present' do
      it { is_expected.to eql 'field: updated value from <strong>old value</strong> to <strong>new value</strong>' }
    end

    context 'when old value is blank' do
      let(:old_value) { '' }

      it { is_expected.to eql 'field: set value to <strong>new value</strong>' }
    end

    context 'when new value is blank' do
      let(:new_value) { '' }

      it { is_expected.to eql 'field: set value from <strong>old value</strong> to <strong>blank</strong>' }
    end

    context 'when property_changed is domain_host' do
      let(:property_changed) { 'domain_host' }
      let(:old_value) { nil }

      it { is_expected.to eql 'nameserver: added entry <strong>new value</strong>' }
    end

    context 'when status is ok' do
      let(:property_changed) { 'ok' }
      let(:old_value) { 'false' }
      let(:new_value) { 'true' }

      it { is_expected.to eql 'status: is now <strong>OK</strong>' }
    end

    context 'when status is no longer ok' do
      let(:property_changed) { 'ok' }
      let(:old_value) { 'true' }
      let(:new_value) { 'false' }

      it { is_expected.to eql 'status: is no longer <strong>OK</strong>' }
    end

    context 'when status is inactive' do
      let(:property_changed) { 'inactive' }
      let(:old_value) { 'false' }
      let(:new_value) { 'true' }

      it { is_expected.to eql 'status: is now <strong>inactive</strong>' }
    end

    context 'when status is no longer inactive' do
      let(:property_changed) { 'inactive' }
      let(:old_value) { 'true' }
      let(:new_value) { 'false' }

      it { is_expected.to eql 'status: is no longer <strong>inactive</strong>' }
    end

    context 'when status is client_hold' do
      let(:property_changed) { 'client_hold' }
      let(:old_value) { 'false' }
      let(:new_value) { 'true' }

      it { is_expected.to eql 'status: is now <strong>client hold</strong>' }
    end

    context 'when status is no longer client_hold' do
      let(:property_changed) { 'client_hold' }
      let(:old_value) { 'true' }
      let(:new_value) { 'false' }

      it { is_expected.to eql 'status: is no longer <strong>client hold</strong>' }
    end

    context 'when status is client_delete_prohibited' do
      let(:property_changed) { 'client_delete_prohibited' }
      let(:old_value) { 'false' }
      let(:new_value) { 'true' }

      it { is_expected.to eql 'status: is now <strong>client delete prohibited</strong>' }
    end

    context 'when status is no longer client_delete_prohibited' do
      let(:property_changed) { 'client_delete_prohibited' }
      let(:old_value) { 'true' }
      let(:new_value) { 'false' }

      it { is_expected.to eql 'status: is no longer <strong>client delete prohibited</strong>' }
    end

    context 'when status is client_renew_prohibited' do
      let(:property_changed) { 'client_renew_prohibited' }
      let(:old_value) { 'false' }
      let(:new_value) { 'true' }

      it { is_expected.to eql 'status: is now <strong>client renew prohibited</strong>' }
    end

    context 'when status is no longer client_renew_prohibited' do
      let(:property_changed) { 'client_renew_prohibited' }
      let(:old_value) { 'true' }
      let(:new_value) { 'false' }

      it { is_expected.to eql 'status: is no longer <strong>client renew prohibited</strong>' }
    end

    context 'when status is client_transfer_prohibited' do
      let(:property_changed) { 'client_transfer_prohibited' }
      let(:old_value) { 'false' }
      let(:new_value) { 'true' }

      it { is_expected.to eql 'status: is now <strong>client transfer prohibited</strong>' }
    end

    context 'when status is no longer client_transfer_prohibited' do
      let(:property_changed) { 'client_transfer_prohibited' }
      let(:old_value) { 'true' }
      let(:new_value) { 'false' }

      it { is_expected.to eql 'status: is no longer <strong>client transfer prohibited</strong>' }
    end

    context 'when status is client_update_prohibited' do
      let(:property_changed) { 'client_update_prohibited' }
      let(:old_value) { 'false' }
      let(:new_value) { 'true' }

      it { is_expected.to eql 'status: is now <strong>client update prohibited</strong>' }
    end

    context 'when status is no longer client_update_prohibited' do
      let(:property_changed) { 'client_update_prohibited' }
      let(:old_value) { 'true' }
      let(:new_value) { 'false' }

      it { is_expected.to eql 'status: is no longer <strong>client update prohibited</strong>' }
    end

    context 'when property_changed is registrant_handle' do
      let(:property_changed) { 'registrant_handle' }
      let(:old_value) { '' }

      it { is_expected.to eql 'registrant: set value to <strong>new value</strong>' }
    end

    context 'when property_changed is admin_handle' do
      let(:property_changed) { 'admin_handle' }
      let(:old_value) { '' }

      it { is_expected.to eql 'admin: set value to <strong>new value</strong>' }
    end

    context 'when property_changed is billing_handle' do
      let(:property_changed) { 'billing_handle' }
      let(:old_value) { '' }

      it { is_expected.to eql 'billing: set value to <strong>new value</strong>' }
    end

    context 'when property_changed is tech_handle' do
      let(:property_changed) { 'tech_handle' }
      let(:old_value) { '' }

      it { is_expected.to eql 'tech: set value to <strong>new value</strong>' }
    end

    context 'when property_changed is expires_at' do
      let(:property_changed) { 'expires_at' }

      it { is_expected.to eql 'expiry date: updated value from <strong>old value</strong> to <strong>new value</strong>' }
    end

    context 'when property_changed is authcode' do
      let(:property_changed) { 'authcode' }
      let(:old_value) { 'old_authcode' }
      let(:new_value) { 'new_authcode' }

      it { is_expected.to eql 'authcode: updated value' }
    end
  end
end
